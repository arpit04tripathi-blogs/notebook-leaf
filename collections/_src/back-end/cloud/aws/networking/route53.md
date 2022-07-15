---
layout: page
title: Route53 DNS
permalink: /aws/route53
---

- TOC
{:toc}

---

* Amzon's DNS service.
* Amazon Route 53 (Route 53) is a scalable and highly available Domain Name System (DNS) service.
* The name is a reference to TCP or UDP port 53, where DNS server requests are addressed.
* Allows to map your domain names to
    - EC2 Instances
    - Load Balancers
    - S3 Buckets
* AWS Services --> Register domain --> verify email to purchase --> Hosted Zones
* AWS Services --> Create Record Set --> A Record(ipv4)
* Zone Apex Record - Record with no name before doamin (naked domain name)
* Create Alias with Target, but no custom target found so create one.
* AWS Services --> EC2 --> Create Application Load Balancer --> Assign security group --> Create new Target Group with target type as instance ID --> Add to Registered --> Check Load Balancer Target Groups
    - http port 80
    - https port 443
* * Create Alias with newly created Target.

![route53-record]({{site.cdn}}/aws/ec2/route53-record.png)
