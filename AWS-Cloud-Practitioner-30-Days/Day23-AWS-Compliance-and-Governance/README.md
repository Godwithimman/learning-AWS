# Day 23 – AWS Compliance and Governance

![Day](https://img.shields.io/badge/Day-23-blue) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## Overview

Welcome to Day 23! Today we explore **AWS Compliance and Governance** — a key Compliance service on AWS.

---

## What is AWS Compliance and Governance?

AWS Compliance and Governance is a fully managed AWS service in the Compliance domain. It removes the complexity of managing infrastructure so teams can focus on building applications.

---

## Why AWS Created This Service

Before AWS offered AWS Compliance and Governance, teams had to build, configure, scale, and maintain this type of infrastructure themselves. AWS created this service to eliminate that operational burden and let teams focus on their core product.

---

## Business Value

- No infrastructure management overhead
- Automatic scaling to match demand
- Pay-as-you-go pricing with no upfront costs
- Built-in high availability across Availability Zones
- Native security integration with IAM and KMS

---

## Key Features

- Fully managed with automated patching and maintenance
- Multi-AZ deployment for fault tolerance
- CloudWatch integration for monitoring and alerting
- IAM integration for fine-grained access control
- CloudFormation support for infrastructure as code
- Encryption at rest and in transit

---

## Real-World Use Case

Large enterprises use AWS Compliance and Governance to handle Compliance workloads at scale without dedicated infrastructure teams. The managed nature of the service reduces operational costs and allows faster iteration.

---

## Pricing Overview

AWS Compliance and Governance uses AWS pay-as-you-go pricing:
- No upfront costs
- Free Tier available for new accounts (12 months)
- Pay only for what you use
- Use the [AWS Pricing Calculator](https://calculator.aws) to estimate costs

---

## Integration with Other AWS Services

- **IAM**: Access control and permissions
- **CloudWatch**: Monitoring, metrics, and alarms
- **CloudTrail**: API call logging and audit
- **VPC**: Network isolation and security
- **CloudFormation**: Infrastructure as code

---

## Architecture Explanation

AWS Compliance and Governance fits into the Compliance layer of AWS architectures. It is deployed within a VPC, protected by Security Groups, accessed via IAM policies, and monitored by CloudWatch.

---

## Hands-On Practice

1. Log into the AWS Management Console
2. Search for AWS Compliance and Governance using the search bar
3. Explore the service dashboard
4. Create a basic resource within Free Tier limits
5. Review monitoring options in CloudWatch
6. Clean up resources to avoid charges

---

## Key Exam Concepts

- What problem does AWS Compliance and Governance solve?
- What is the pricing model?
- How does it provide high availability?
- What does AWS manage vs what you manage (Shared Responsibility Model)?
- How does it integrate with IAM, CloudWatch, and VPC?

---

## Mini Knowledge Check

**Q1:** What category does AWS Compliance and Governance belong to?
<details><summary>Answer</summary>
Compliance. AWS Compliance and Governance provides managed Compliance capabilities without requiring infrastructure management.
</details>

**Q2:** What service monitors AWS Compliance and Governance performance?
<details><summary>Answer</summary>
Amazon CloudWatch — it provides metrics, alarms, and dashboards for operational visibility.
</details>

**Q3:** How does AWS Compliance and Governance achieve high availability?
<details><summary>Answer</summary>
By deploying across multiple Availability Zones. If one AZ fails, the service continues in healthy AZs.
</details>

**Q4:** What is your responsibility vs AWS's responsibility for AWS Compliance and Governance?
<details><summary>Answer</summary>
AWS manages: hardware, infrastructure, software patches. You manage: IAM configuration, encryption settings, data, and application-level security.
</details>

**Q5:** Is AWS Compliance and Governance available in the AWS Free Tier?
<details><summary>Answer</summary>
Many AWS services offer Free Tier limits for the first 12 months. Check the AWS Free Tier page for current limits for AWS Compliance and Governance.
</details>

---

## Key Takeaways

- AWS Compliance and Governance is a managed AWS Compliance service
- AWS handles infrastructure — you focus on configuration and usage
- Pay-as-you-go pricing with no upfront costs
- Integrates with IAM, CloudWatch, CloudTrail, and VPC
- Deploy across multiple AZs for production high availability

---

*[Previous](../Day22-AWS-Security-Services/README.md) | [Next](../Day24-AWS-CloudFormation/README.md)*
