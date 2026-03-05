# Day 09 – S3 Storage Classes

![Day](https://img.shields.io/badge/Day-09-blue) ![Topic](https://img.shields.io/badge/Topic-S3%20Storage%20Classes-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Not all data has the same access patterns. A file uploaded today is accessed constantly; a compliance record from 5 years ago may never be accessed again. S3 Storage Classes let you optimize cost by matching storage pricing to how frequently each piece of data is actually accessed.

---

## ☁️ What is Amazon S3 Storage Classes?

S3 Storage Classes are different tiers of storage within Amazon S3, each with different costs, availability, and retrieval characteristics. They all offer the same 11 nines of durability but differ in cost, minimum storage duration, and how quickly you can retrieve objects.

---

## 🤔 Why AWS Created This Service

Storing all data at the same price — regardless of how often it is accessed — wastes money. A rarely-accessed backup stored at the same price as a frequently-accessed web asset is economically inefficient. Storage Classes let you pay appropriate prices for each type of data.

---

## 💼 Business Value

Organizations reduce S3 storage costs by 70-95% for infrequently accessed and archival data without changing how applications interact with S3. Lifecycle policies automate the tiering process based on age, reducing manual management.

---

## 🔑 Key Features

- **S3 Standard**: Frequent access, millisecond retrieval, highest cost
- **S3 Intelligent-Tiering**: Automatic tiering based on access patterns, monitoring fee per object
- **S3 Standard-IA**: Infrequent Access, millisecond retrieval, lower cost, retrieval fee
- **S3 One Zone-IA**: Like Standard-IA but single AZ (lower durability), cheapest IA option
- **S3 Glacier Instant Retrieval**: Archival with millisecond retrieval, lowest cost for frequent retrieval from archive
- **S3 Glacier Flexible Retrieval**: Archival with minutes-to-hours retrieval, very low cost
- **S3 Glacier Deep Archive**: Cheapest option, 12-48 hour retrieval, for compliance archives

---

## 🏢 Real-World Use Case

A genomics research company stores 10 petabytes of DNA sequencing data on S3. Using lifecycle policies: data from the last 30 days stays in S3 Standard (actively analyzed). Data 30-365 days old moves to S3 Standard-IA. Data over 1 year old moves to S3 Glacier Deep Archive at $0.00099/GB/month — 95% cheaper than Standard. Total annual savings: $2 million.

---

## 💰 Pricing Overview

Per GB/month approximate costs:
- S3 Standard: ~$0.023
- S3 Intelligent-Tiering: ~$0.023 (Standard), ~$0.0125 (IA tier) + $0.0025 per 1,000 objects monitored
- S3 Standard-IA: ~$0.0125 + $0.01/GB retrieval fee
- S3 One Zone-IA: ~$0.01 + retrieval fee
- S3 Glacier Instant Retrieval: ~$0.004
- S3 Glacier Flexible Retrieval: ~$0.0036 + retrieval fee
- S3 Glacier Deep Archive: ~$0.00099 (cheapest) + $0.02/GB retrieval

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

- **S3 Lifecycle Policies**: Automate transitions between storage classes
- **S3 Intelligent-Tiering + CloudWatch**: Monitor access patterns
- **S3 Glacier + AWS Backup**: Centralized backup with Glacier as destination
- **S3 Glacier + Vault Lock**: WORM (Write Once Read Many) compliance controls
- **S3 Replication**: Replicate to same or different storage class in another Region

---

## 🏗️ Basic Architecture Explanation

Storage classes are transparent to applications — the same S3 API calls work regardless of storage class. Lifecycle policies define rules like: 'After 30 days, move to Standard-IA. After 90 days, move to Glacier Flexible Retrieval.' AWS handles all transitions automatically.

---

## 🖥️ Hands-On Practice

> **Goal:** Create an S3 Lifecycle Policy that transitions objects to Standard-IA after 30 days and Glacier Flexible Retrieval after 90 days. Upload test objects and verify the policy configuration.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **Amazon S3 Storage Classes** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: Amazon S3 Storage Classes console dashboard*

---

## 📝 Key Exam Concepts

Know all storage classes and their retrieval times. Key exam distinctions: Standard-IA vs One Zone-IA (durability difference). Glacier Instant vs Flexible vs Deep Archive (retrieval time differences). Know that S3 Intelligent-Tiering automatically optimizes costs. Know minimum storage duration charges (IA = 30 days, Glacier = 90 days, Deep Archive = 180 days).

---

## ❓ Mini Knowledge Check

**Question 1:** A compliance team needs to store audit logs for 7 years. They will almost never need to retrieve them. Which S3 storage class minimizes cost?
<details>
<summary>Answer</summary>
S3 Glacier Deep Archive — at approximately $0.00099/GB/month, it is the lowest-cost S3 storage option. Designed for data retained for 7-10 years that is rarely (if ever) accessed. Retrieval time is 12-48 hours, which is acceptable for rarely-needed compliance archives.
</details>

**Question 2:** What is the difference between S3 Standard-IA and S3 One Zone-IA?
<details>
<summary>Answer</summary>
Both are for infrequent access data with the same retrieval speed (milliseconds). Standard-IA replicates across at least 3 AZs (99.999999999% durability). One Zone-IA stores in a single AZ — lower durability, lower cost. Use One Zone-IA only for data that can be recreated if the AZ fails.
</details>

**Question 3:** What is S3 Intelligent-Tiering and when should you use it?
<details>
<summary>Answer</summary>
S3 Intelligent-Tiering automatically moves objects between Standard and IA tiers based on actual access patterns. Objects not accessed for 30 days move to the IA tier. If accessed again, they move back to Standard. Use it when you have unpredictable access patterns and don't want to manually manage lifecycle policies. There is a small per-object monitoring fee.
</details>

**Question 4:** How does Amazon S3 Storage Classes integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on Amazon S3 Storage Classes resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for Amazon S3 Storage Classes?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for Amazon S3 Storage Classes. CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

S3 Storage Classes are a powerful cost optimization tool. Use Lifecycle Policies to automate tiering. Know the retrieval times for each class (instant, minutes, or hours). Deep Archive is the cheapest for long-term compliance archives. Intelligent-Tiering automates optimization when access patterns are unpredictable.

---

## 📚 Further Reading

- [AWS Amazon S3 Storage Classes Documentation](https://docs.aws.amazon.com)
- [AWS Storage Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day08-Amazon-S3/README.md) | [Next: Day 10 ➡️](../Day10-Amazon-RDS/README.md)*
