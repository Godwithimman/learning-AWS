# Day 03 – AWS Core Services Overview

![Day](https://img.shields.io/badge/Day-03-blue) ![Topic](https://img.shields.io/badge/Topic-AWS%20Core%20Services%20Overview-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Before diving deep into individual services, you need a map of the AWS landscape. AWS offers 200+ services — understanding the main categories makes navigation much easier and helps you pick the right tool for each job.

---

## ☁️ What is AWS Core Services?

AWS Core Services refers to the foundational set of services that form the backbone of most AWS architectures. These are organized into categories: Compute, Storage, Database, Networking, Security, and Monitoring.

---

## 🤔 Why AWS Created This Service

AWS built its service portfolio to cover every IT need a business might have — from raw compute power to managed databases to serverless functions. The goal is to provide purpose-built services that are better than building and maintaining your own.

---

## 💼 Business Value

Teams can assemble complete cloud solutions from purpose-built services. Instead of building everything from scratch, organizations pick the AWS service designed exactly for their use case and pay only for what they use.

---

## 🔑 Key Features

- **Compute**: EC2 (virtual servers), Lambda (serverless), ECS/EKS (containers)
- **Storage**: S3 (object storage), EBS (block storage), EFS (file storage), Glacier (archive)
- **Database**: RDS (relational), DynamoDB (NoSQL), ElastiCache (in-memory), Redshift (data warehouse)
- **Networking**: VPC (private network), Route 53 (DNS), CloudFront (CDN), Direct Connect
- **Security**: IAM (access control), KMS (encryption), GuardDuty (threat detection)
- **Monitoring**: CloudWatch (metrics/alerts), CloudTrail (audit logging), X-Ray (tracing)

---

## 🏢 Real-World Use Case

A SaaS startup builds their entire product on AWS: EC2 Auto Scaling handles web traffic, RDS PostgreSQL stores customer data, S3 stores user-uploaded files, CloudFront serves those files globally, IAM controls who can access what, and CloudWatch alerts the team when anything goes wrong.

---

## 💰 Pricing Overview

Each service has its own pricing model, but they all follow AWS's core principles: pay-as-you-go, no upfront costs (unless you choose Reserved pricing for discounts), and Free Tier availability for new accounts.

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs before deploying.

---

## 🔗 Integration with Other AWS Services

All AWS services integrate through common patterns:
- **IAM** controls access to every service
- **VPC** provides the network fabric connecting services
- **CloudWatch** monitors every service
- **CloudTrail** audits every API call to every service
- **CloudFormation** provisions any service as infrastructure as code

---

## 🏗️ Basic Architecture Explanation

Think of AWS services as building blocks. A typical three-tier web architecture uses: Route 53 (DNS) → CloudFront (CDN) → ALB (load balancer) → EC2 in Auto Scaling (app tier) → RDS (database tier), with IAM, CloudWatch, and VPC securing and monitoring everything.

---

## 🖥️ Hands-On Practice

> **Goal:** Navigate through the AWS console and find one service per category. Note what each service's dashboard looks like and what the key configuration options are.

### Steps:

1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Use the **Search bar** at the top to find the relevant service
3. Explore the service dashboard and review the main features
4. Try creating a basic resource (use Free Tier eligible options)
5. Review the service's **Monitoring** tab or CloudWatch integration
6. Clean up any resources created to avoid unexpected charges

> 📸 *Screenshot placeholder: Service dashboard in AWS Console*

---

## 📝 Key Exam Concepts

Understand the purpose of each major service category. Know which service to use for which job. The exam presents scenarios and asks which service is the right fit.

| Concept | Importance |
|---|---|
| Service purpose and use case | High |
| Pricing model | Medium-High |
| Integration with IAM, CloudWatch | High |
| High Availability configuration | Medium |
| Comparison with similar services | High |

---

## ❓ Mini Knowledge Check

**Question 1:** A company needs to store unstructured files like images and videos. Which AWS service is best?
<details>
<summary>Answer</summary>
Amazon S3 — it is object storage designed for unstructured data like images, videos, and backups. It offers unlimited scalability and 11 nines of durability.
</details>

**Question 2:** What category does Amazon EC2 belong to?
<details>
<summary>Answer</summary>
Compute. EC2 provides resizable virtual servers (Elastic Compute Cloud) in the cloud.
</details>

**Question 3:** A developer needs a NoSQL database that scales automatically to millions of requests per second. Which service should they use?
<details>
<summary>Answer</summary>
Amazon DynamoDB — AWS's fully managed NoSQL database service designed for single-digit millisecond performance at any scale.
</details>

**Question 4:** What is the AWS pricing model for AWS Core Services?
<details>
<summary>Answer</summary>
Each service has its own pricing model, but they all follow AWS's core principles: pay-as-you-go, no upfront costs (unless you choose Reserved pricing for discounts), and Free Tier availability for new accounts.
</details>

**Question 5:** How does AWS Core Services integrate with AWS IAM?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform actions on AWS Core Services resources. You should always follow the principle of least privilege — grant only the minimum permissions needed.
</details>

---

## ✅ Key Takeaways

AWS has 200+ services organized into clear categories. Understanding the categories helps you navigate the platform and answer exam scenario questions. The core services are Compute, Storage, Database, Networking, Security, and Monitoring.

- Always use IAM roles for service-to-service communication (not users)
- Monitor with CloudWatch and audit with CloudTrail
- Design for high availability across multiple Availability Zones
- Use the AWS Free Tier to practice without incurring costs

---

## 📚 Further Reading

- [AWS Documentation](https://docs.aws.amazon.com)
- [AWS Foundations Services](https://aws.amazon.com/products)
- [AWS Free Tier](https://aws.amazon.com/free)

---

*[⬅️ Previous: Day 02](../Day02-AWS-Global-Infrastructure/README.md) | [Next: Day 04 ➡️](../Day04-IAM-Basics/README.md)*
