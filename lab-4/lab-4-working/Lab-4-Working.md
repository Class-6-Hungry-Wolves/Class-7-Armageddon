# Lab 4 — Japan Medical Multi-Cloud Reality in Regulated Healthcare
---
---

## Process Write Up

The pre-shared keys were generated automatically by the GCP New York team during VPN tunnel creation using cryptographically secure random number generators, ensuring sufficient entropy and uniqueness per tunnel. Creating VPNs in GCP is a bit more user friendly so they will be in charge of connecting to the AWS Japan Network using the GCP tools. The PSKs are stored in GCP secrets manager, this means that the GCP team will be in charge of storing and rotating the PSKs. Also, the GCP New York team will create login credentials for the AWS Japan team that has read privileges to the secrets manager. From there, the AWS side will be able to configure their side of the VPN connecting to the GCP VPN.

This approach matters in regulated environments because it enforces least privilege, auditability, and repeatability. Automated generation and controlled distribution reduce the risk of credential leakage and support compliance with frameworks such as SOC 2, ISO 27001, and PCI DSS. Sharing of PSKs occurred only through secure, access-controlled infrastructure-as-code pipelines and encrypted state backends, rather than email or chat.. In addition, they were not stored in plaintext documentation or long-lived secrets stores outside the GCP and AWS environments, this limits the possibility of interference and tampering. Each VPN tunnel was assigned a distinct PSK to reduce blast radius in the event of a key compromise.

---

## Compliance Stament

No customer or regulated data is stored within GCP; the GCP New York environment is used solely as a transient network transit layer for a VPN connections to route encrypted traffic between the two teams. All application data at rest, including databases, object storage, and backups, remains exclusively within the AWS Japan Network. Because GCP does not persist payload data and only processes encrypted packets in memory for routing purposes, this architecture does not constitute cross-border data storage or replication, which aligns with Japanese privacy and data residency requirements under APPI and related guidance. Encryption in transit ensures that data remains protected while traversing the VPN, and no plaintext inspection or retention occurs within GCP. This satisfies regulatory expectations by maintaining clear control over where data is stored and who has access to it. 

Finally, “multi-cloud” in this context refers to the use of AWS and GCP for connectivity and resiliency, not for duplicating or distributing data storage, ensuring compliance without expanding the data residency footprint. The GCP New York team only has the necessary architecture to complete the task of connecting to the AWS Japan network via a private VPN connection. The GCP New York team doesn't create any resources that store data. Any data that they get immediately, gets sent via IPSec VPN tunnels to the AWS Japan team where they store data for further use while adhering to Japanese law for compliance purposes.

---

---