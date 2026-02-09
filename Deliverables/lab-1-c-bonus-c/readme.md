## Lab 1C – Bonus C: ACM DNS Validation Drift (“Max Payne / Max Pain”)

### Overview  
This bonus lab was about getting HTTPS working properly using:
- Route53 for DNS  
- ACM for TLS certificates (DNS validation)  
- ALB as the HTTPS entry point  

The domain I used was app.maxpayne.lol.
The name ended up being accurate: Max Payne turned into Max Pain because of TLS + DNS issues.

I chose the name Max Payne because it’s one of my favourite third-person shooter games.
We are also experiencing a record breaking cold winter this winter similar to the first game, and Armageddon is the real world chaos and pain that you see in the Max Payne games. Everything going wrong one by one or at once until it was fixed.

### What Went Wrong (The Max Pain)  
When I ran `terraform apply`, it looked like it was stuck for around **30 minutes**.  
Nothing was crashing, it just kept waiting.

The issue was not Terraform itself. The problem was:

- There was already an old ACM DNS validation CNAME record in Route53  
- The old record didn’t match the new certificate validation token  
- ACM kept waiting for DNS validation that could never succeed  
- Terraform was correctly waiting for ACM to return `ISSUED`  
- This made it feel like Terraform was frozen or broken  

This kind of thing happens in real setups when:
- You delete and recreate certificates  
- You reuse domains  
- Old DNS records are left behind  
- DNS takes time to propagate  

### How I Fixed It  
I fixed the issue by:

1. Checking the certificate status:
   ```bash
   aws acm describe-certificate --certificate-arn <CERT_ARN>
2. Checking the validation records ACM expected vs what was in Route53:

aws route53 list-resource-record-sets --hosted-zone-id <ZONE_ID>


3. Deleting the old / wrong validation CNAME record

4. Running Terraform again:

terraform apply


After that, ACM was able to validate the domain and issue the certificate, and Terraform finished properly.

Verification
aws acm describe-certificate --certificate-arn <CERT_ARN> --query "Certificate.Status"
curl -I https://app.maxpayne.lol


Expected result:

Certificate status shows ISSUED

HTTPS returns 200 OK (or 301 → 200)

What I Learned

This wasn’t a Terraform bug. Terraform was doing the right thing by waiting.
The real issue was DNS drift from an old ACM validation record.

This is the kind of problem that happens in real cloud environments and blocks deploys until you understand what ACM is waiting for.

So indeed Max Payne became Max Pain, but that’s the point of this bonus lab.