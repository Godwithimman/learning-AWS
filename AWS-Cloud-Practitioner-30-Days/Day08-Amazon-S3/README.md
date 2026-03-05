# Day 08 – Amazon S3

![Day](https://img.shields.io/badge/Day-08-blue) ![Topic](https://img.shields.io/badge/Topic-Amazon%20S3-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Amazon S3 is one of the most fundamental and widely-used AWS services. It stores virtually unlimited amounts of data — files, images, videos, backups, static websites — accessible from anywhere in the world. S3 is the internet's most popular storage service for good reason.

---

## ☁️ What is Amazon S3 (Simple Storage Service)?

Amazon Simple Storage Service (S3) is an object storage service that provides industry-leading scalability, data availability, security, and performance. You store data as objects (files + metadata) in containers called buckets. Each object gets a unique URL and can be accessed via HTTPS from anywhere.

---

## 🤔 Why AWS Created This Service

Applications need to store files that are too large for a database, need to be accessible from multiple servers, or need to be delivered to users globally. Building and maintaining a scalable file storage system is complex — S3 handles all of that complexity so you just upload files and they are reliably stored.

---

## 💼 Business Value

Companies store unlimited data with 11 nines (99.999999999%) of durability — effectively zero data loss. Files are accessible from any AWS service, any application, and any user in the world. S3 scales automatically from 1 file to billions without any capacity planning.

---

## 🔑 Key Features

- **Unlimited storage** with no capacity limits
- **99.999999999% (11 nines) durability** through multi-AZ replication
- **Versioning**: Keep multiple versions of every object
- **Bucket Policies and ACLs**: Fine-grained access control
- **Static Website Hosting**: Serve HTML/CSS/JS directly from S3
- **Event Notifications**: Trigger Lambda on upload, delete, or modify
- **Lifecycle Policies**: Automatically transition objects between storage classes
- **S3 Select**: Query data directly in S3 without downloading it
- **Transfer Acceleration**: Fast uploads using CloudFront edge locations
- **Replication**: Cross-Region and Same-Region replication for redundancy

---

## 🏢 Real-World Use Case

Pinterest stores billions of images on S3. Every image uploaded by a user goes to S3. When a user views pins, images are served from S3 via CloudFront CDN for low-latency global delivery. S3 Lifecycle Policies automatically archive older, less-viewed images to S3 Glacier, reducing storage costs by 80%.

---

## 💰 Pricing Overview

- Storage: ~$0.023/GB/month for S3 Standard
- Requests: $0.005 per 1,000 PUT requests, $0.0004 per 1,000 GET requests
- Data transfer: Free in, $0.09/GB out to internet
- Free Tier: 5GB S3 Standard storage, 20,000 GET requests, 2,000 PUT requests per month (12 months)

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

S3 integrates with almost every AWS service:
- **S3 + CloudFront**: Serve objects via CDN for global low-latency access
- **S3 + Lambda**: Trigger functions on object events (upload, delete)
- **S3 + Athena**: Query S3 data with standard SQL
- **S3 + Glacier**: Archive infrequently accessed data at low cost
- **S3 + CloudTrail**: Log all S3 API calls for audit
- **S3 + Replication**: Copy objects to another Region automatically

---

## 🏗️ Basic Architecture Explanation

S3 stores objects in buckets. Buckets are Region-specific but globally accessible via URL. S3 automatically replicates objects across at least 3 Availability Zones within the Region — you do not manage this replication. Public access can be blocked at bucket or account level. CloudFront sits in front of S3 for CDN caching.

---

## 🖥️ Hands-On Practice

> **Goal:** Create an S3 bucket, upload a static HTML file, enable static website hosting, and access your website via the S3 website URL. Enable versioning and upload a second version of the file.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **Amazon S3 (Simple Storage Service)** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: Amazon S3 (Simple Storage Service) console dashboard*

---

## 📝 Key Exam Concepts

S3 is object storage (not block storage like EBS). Bucket names are globally unique across all AWS accounts. Know the 11 nines durability figure. Understand the difference between bucket policies (resource-based) and IAM policies (identity-based). Know what S3 Block Public Access does.

---

## ❓ Mini Knowledge Check

**Question 1:** What is the maximum size of a single object in Amazon S3?
<details>
<summary>Answer</summary>
5 TB (terabytes) per object. For objects larger than 5GB, you must use multipart upload. Objects can range from 0 bytes to 5TB.
</details>

**Question 2:** A company's S3 bucket is accidentally made public. What is the fastest way to prevent any S3 bucket from becoming public in the future?
<details>
<summary>Answer</summary>
Enable S3 Block Public Access at the account level — it prevents any bucket or object from being made publicly accessible, overriding bucket policies and ACLs. This is a one-click preventive control that applies to all current and future buckets.
</details>

**Question 3:** What is S3 Versioning and why would you enable it?
<details>
<summary>Answer</summary>
S3 Versioning keeps multiple variants of an object in the same bucket. When you overwrite or delete an object, the previous version is preserved. This protects against accidental deletion and overwrites — you can restore any previous version of any object.
</details>

**Question 4:** How does Amazon S3 (Simple Storage Service) integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on Amazon S3 (Simple Storage Service) resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for Amazon S3 (Simple Storage Service)?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for Amazon S3 (Simple Storage Service). CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

S3 is foundational to AWS — nearly every architecture uses it. It provides infinite, durable, globally accessible object storage. Know S3 vs EBS: S3 for objects/files accessible via URL, EBS for block storage attached to EC2. Know the 11 nines durability. Master S3 — it appears throughout the exam.

---

## 📚 Further Reading

- [AWS Amazon S3 (Simple Storage Service) Documentation](https://docs.aws.amazon.com)
- [AWS Storage Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day07-Amazon-EBS/README.md) | [Next: Day 09 ➡️](../Day09-S3-Storage-Classes/README.md)*
