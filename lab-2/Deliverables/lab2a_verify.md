# LAB2-A: RESULTS

---


## 1. “VPC is only reachable via CloudFront”

### Direct ALB access should fail (403)
  curl -I https://<ALB_DNS_NAME>

![#](./artifacts/01-ALB-HTTPS-Fail.PNG)

### CloudFront access should succeed
  curl -I https://chewbacca-growl.com
  curl -I https://app.chewbacca-growl.com

![#](./artifacts/02-CloudFront-HTTPS-Access.PNG)


## 2. WAF moved to CloudFront

  aws wafv2 get-web-acl \
  --name <project>-cf-waf01 \
  --scope CLOUDFRONT \
  --id <WEB_ACL_ID>

![#](./artifacts/03-AWF-to-CloudFront.PNG)

### And confirm distribution references it:
  aws cloudfront get-distribution \
  --id <DISTRIBUTION_ID> \
  --query "Distribution.DistributionConfig.WebACLId"

![#](./artifacts/04-CloudFront-Distro-Ref.PNG)

## 3. resilienetsolutions.click points to CloudFront

  dig chewbacca-growl.com A +short
  dig app.chewbacca-growl.com A +short

![#](./artifacts/05-CloudFront-DNS-Resolve.PNG)
