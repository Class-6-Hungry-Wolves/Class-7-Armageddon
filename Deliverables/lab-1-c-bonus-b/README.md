\# Lab 1C – Bonus B Deliverables



This folder contains verification evidence for the following architecture:



\- Public Application Load Balancer (internet-facing)

\- Private EC2 targets (no public IPs)

\- WAF attached to ALB

\- CloudWatch Dashboard

\- CloudWatch Alarm on ALB 5xx errors (SNS notifications)

\- Enterprise ingress pattern using Terraform



\## Evidence



1\. ALB active – 1-alb-active.png  

2\. HTTPS listener (80/443) – 2-https-listener.png  

3\. Target healthy – 3-target-healthy.png  

4\. WAF attached to ALB – 4-waf-attached.png  

5\. ALB 5xx alarm – 5-alb-5xx-alarm.png  

6\. CloudWatch dashboard – 6-cloudwatch-dashboard.png  



\## TLS / ACM Status (Domain Pending)



HTTPS (443) and ACM are implemented in Terraform.  

DNS validation is pending because a custom domain is not currently owned.  



HTTP listener (80) and ALB/WAF/alarms/dashboard are fully deployed and verified.



In a real organization, DNS ownership and certificate validation are handled by a separate team.  

TLS would be completed after domain delegation.



\## Real-world relevance



This mirrors standard enterprise patterns:



\- Private compute with managed ingress (ALB)

\- Centralized TLS termination (ACM)

\- Web Application Firewall (WAF)

\- Observability (CloudWatch dashboards)

\- Alerting (SNS on 5xx spikes)

\- Infrastructure as Code workflow (plan → apply → verify → document)

