# Day 04 – IAM Basics

![Day](https://img.shields.io/badge/Day-04-blue) ![Topic](https://img.shields.io/badge/Topic-IAM%20Basics-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Security is foundational — without IAM, anyone with your AWS credentials could delete your databases, rack up thousands in charges, or steal your data. IAM is the security gatekeeper for your entire AWS account.

---

## ☁️ What is AWS IAM (Identity and Access Management)?

AWS Identity and Access Management (IAM) is a service that controls who can authenticate (sign in) and who is authorized (has permissions) to use AWS resources. It is the first line of defense for every AWS account.

---

## 🤔 Why AWS Created This Service

Without controlled access, a single compromised password could destroy an entire company's cloud infrastructure. IAM lets you create fine-grained permissions so each user or service only has exactly the access they need — nothing more.

---

## 💼 Business Value

Organizations prevent accidental and malicious changes to cloud infrastructure, meet compliance requirements for access control, and enforce security policies by managing exactly who can do what in AWS — all without sharing a single master password.

---

## 🔑 Key Features

- **IAM Users**: Individual accounts for humans with permanent credentials
- **IAM Groups**: Collections of users sharing the same permissions
- **IAM Policies**: JSON documents defining what actions are allowed or denied
- **Multi-Factor Authentication (MFA)**: Extra verification layer for enhanced security
- **Password Policies**: Enforce complexity, expiration, and reuse rules
- **Access Keys**: Programmatic access credentials for CLI and SDK usage
- **IAM Identity Center**: Single Sign-On (SSO) for multiple AWS accounts

---

## 🏢 Real-World Use Case

A financial services company uses IAM to ensure: developers can only access development EC2 instances, the database team can only access RDS, finance can only view the billing dashboard, and the CISO's account requires MFA to log in. The root account is locked away and never used for daily operations.

---

## 💰 Pricing Overview

IAM itself is completely free — no charges for creating users, groups, roles, or policies. You pay for the AWS resources that IAM users access, not for the IAM configuration itself.

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

IAM integrates with every AWS service. When you call any AWS API (from the console, CLI, or SDK), IAM evaluates your permissions before allowing or denying the action:
- **EC2**: IAM controls who can start/stop/terminate instances
- **S3**: Bucket policies combine with IAM policies for access control
- **RDS**: IAM database authentication replaces static passwords
- **Lambda**: Execution roles grant Lambda functions permissions to other services

---

## 🏗️ Basic Architecture Explanation

IAM sits at the authentication and authorization layer of every AWS architecture. Every API call flows through IAM evaluation: Is the requester authenticated? Do their policies allow this action? On this resource? Under these conditions? IAM enforces this for 100% of AWS API calls.

---

## 🖥️ Hands-On Practice

> **Goal:** Create your first IAM user with console access, put them in a group, attach a read-only policy, and test that they cannot create or delete resources.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **AWS IAM (Identity and Access Management)** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: AWS IAM (Identity and Access Management) console dashboard*

---

## 📝 Key Exam Concepts

IAM is one of the most heavily tested topics. Know: root account vs IAM user (never use root for daily tasks). Know the difference between users, groups, roles, and policies. Know what MFA is and why it matters. Know the principle of least privilege.

---

## ❓ Mini Knowledge Check

**Question 1:** What is the AWS account root user and why should it not be used for daily tasks?
<details>
<summary>Answer</summary>
The root user is created when you first open an AWS account and has unrestricted access to all services. It should be protected with MFA and used only for account-level tasks (like closing the account or changing the root email). Use IAM users for all day-to-day work.
</details>

**Question 2:** What is an IAM Policy?
<details>
<summary>Answer</summary>
An IAM Policy is a JSON document that defines permissions — specifying which AWS actions are allowed or denied, on which resources, and under what conditions. Policies are attached to users, groups, or roles to grant permissions.
</details>

**Question 3:** What is the principle of least privilege?
<details>
<summary>Answer</summary>
Grant each user, group, or role only the minimum permissions needed to perform their job function — nothing more. This limits the blast radius if credentials are compromised and reduces the chance of accidental changes.
</details>

**Question 4:** How does AWS IAM (Identity and Access Management) integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on AWS IAM (Identity and Access Management) resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for AWS IAM (Identity and Access Management)?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for AWS IAM (Identity and Access Management). CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

IAM is the security foundation of AWS. Protect the root account with MFA and never use it for daily work. Create individual IAM users and organize them into groups. Apply policies with least privilege. IAM is free and essential.

---

## 📚 Further Reading

- [AWS AWS IAM (Identity and Access Management) Documentation](https://docs.aws.amazon.com)
- [AWS Security & Identity Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day03-AWS-Core-Services-Overview/README.md) | [Next: Day 05 ➡️](../Day05-IAM-Roles-and-Policies/README.md)*
