# CloudFront Invalidation – Break Glass Procedure


## Purpose

### Invalidate the smallest necessary CloudFront path when cached content must be refreshed immediately (e.g., stale index.html).

### Invalidation is not part of normal deployments. It is a controlled operational action.

# Step 0 — Discover Distribution ID + Route 53 Alias (CLI)

List CloudFront Distributions
```
aws cloudfront list-distributions \
  --query "DistributionList.Items[].{Id:Id,Aliases:Aliases.Items}" \
  --output table
```
```
Example Output:

------------------------------------------------------------
|                     ListDistributions                   |
+--------------------------+------------------------------+
|            Id            |           Aliases            |
+--------------------------+------------------------------+
|  <CLOUDFRONT_DIST_ID>    |  [<ROUTE53_ALIAS_DOMAIN>]   |
+--------------------------+------------------------------+
```

Identify:

<CLOUDFRONT_DIST_ID>

<ROUTE53_ALIAS_DOMAIN>

Set Session Variables
```
export DIST_ID="<CLOUDFRONT_DIST_ID>"
export APP_DOMAIN="<ROUTE53_ALIAS_DOMAIN>"
export URL="https://$APP_DOMAIN/static/index.html"
```


# Step 1 — Confirm Caching (Baseline Proof)

Verify the object is cached:

```
curl -s -D - -o /dev/null "$URL" | egrep -i '^(HTTP|x-cache:|age:|cache-control:)'
curl -s -D - -o /dev/null "$URL" | egrep -i '^(x-cache:|age:)'
```

Expected:

X-Cache: Hit from cloudfront

Age present and increasing

Optional: inspect current content

``` 
curl -s "$URL" | head -n 40
```

# Step 2 — Deploy Origin Change

Update the object in S3 (Terraform or deployment pipeline).

If Terraform-managed:

``` terraform apply ```


Re-test:

``` curl -s -D - -o /dev/null "$URL" | egrep -i '^(x-cache:|age:)' ```


If old content is still served and X-Cache: Hit, proceed to invalidation.




# Step 3 — Create Targeted Invalidation
Create Invalidation Batch File

```
TS=$(date +%s)

cat > invalidation.json <<JSON
{
  "CallerReference": "break-glass-$TS",
  "Paths": {
    "Quantity": 1,
    "Items": ["/static/index.html"]
  }
}
JSON
```
Execute Invalidation
```
aws cloudfront create-invalidation \
  --distribution-id $DIST_ID \
  --invalidation-batch file://invalidation.json
```

Capture:

Invalidation.Id

# Step 4 — Track Invalidation Completion

```
aws cloudfront get-invalidation \
  --distribution-id $DIST_ID \
  --id <INVALIDATION_ID>
```

Wait until:

Example :
```
{
    "Invalidation": {
        "Id": "<INVALIDATION_ID>",
        "Status": "Completed",
        "CreateTime": "2026-02-09T21:26:01.408000+00:00",
        "InvalidationBatch": {
            "Paths": {
                "Quantity": 1,
                "Items": [
                    "/static/index.html"
                ]
            },
            "CallerReference": "lab2b-1770672296"
        }
    }
}
```




# Step 5 — Verify Refresh (Correctness Proof)

Verify cache refresh:

```
curl -s -D - -o /dev/null "$URL" | egrep -i '^(HTTP|x-cache:|age:|cache-control:)'
```

Expected:

X-Cache: Miss from cloudfront or RefreshHit

Age reset or absent

Confirm updated content:

```
curl -s "$URL" | head -n 40
```

Verify caching resumes:

```
curl -s -D - -o /dev/null "$URL" | egrep -i '^(x-cache:|age:)'
```


- Expected:

- X-Cache: Hit

- Age increasing

### Guardrails (Non-Negotiable)

Allowed Invalidations

- /static/index.html

- Specific narrow file paths

- Minimal blast radius only

### Restricted Invalidations

- /static/* → allowed only with justification

- /* → break-glass only

- Security incident

- Corrupted content

- Legal takedown

- Catastrophic caching misconfiguration

- Requires approval + incident documentation

### Deployment Policy

- Static assets must be versioned (e.g. app.<hash>.js)

- Versioned assets do not require invalidation

- Invalidation is reserved for unversioned entrypoints or emergency scenarios

- Terraform must not automatically invalidate on apply