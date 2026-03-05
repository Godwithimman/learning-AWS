# Day 05 – IAM Roles and Policies

![Day](https://img.shields.io/badge/Day-05-blue) ![Topic](https://img.shields.io/badge/Topic-IAM%20Roles%20and%20Policies-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Yesterday we learned about IAM users and groups for humans. Today we go deeper: IAM Roles are for AWS services and temporary access, while advanced policy features let you control permissions with surgical precision.

---

## ☁️ What is IAM Roles and Policies?

An IAM Role is an identity with specific permissions that can be assumed by AWS services, applications, or users from other accounts. Unlike users, roles have no permanent credentials — they provide temporary security tokens that rotate automatically.

---

## 🤔 Why AWS Created This Service

Applications running on AWS need to call other AWS services (an EC2 instance reading from S3, a Lambda function writing to DynamoDB). You should never hardcode credentials in application code. Roles solve this by providing automatic, rotating, temporary credentials to AWS services.

---

## 💼 Business Value

Applications access AWS services securely without storing credentials in code or configuration files — eliminating a major category of security vulnerabilities. Credentials automatically expire and rotate, reducing breach risk dramatically.

---

## 🔑 Key Features

- **IAM Roles**: Assumable by services, users, or cross-account principals
- **AWS Managed Policies**: Pre-built policies maintained by AWS (e.g., AmazonS3ReadOnlyAccess)
- **Customer Managed Policies**: Your own reusable policies
- **Inline Policies**: Policies embedded directly in a user, group, or role
- **Permission Boundaries**: Maximum permission guardrails for IAM entities
- **Policy Conditions**: Context-based restrictions (IP, time, MFA status)
- **Trust Policies**: Define who (which principal) can assume a role

---

## 🏢 Real-World Use Case

A Lambda function needs to read data from S3 and write results to DynamoDB. Instead of creating an IAM user and putting access keys in the Lambda code (dangerous — credentials could be leaked), you create an IAM Role with an S3 read policy and DynamoDB write policy, then attach it to the Lambda function. Lambda automatically receives temporary credentials.

---

## 💰 Pricing Overview

IAM Roles and Policies are completely free. No charges for creating roles, policies, or assuming roles. This is one of the most cost-effective security investments you can make.

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

IAM Roles are the glue that lets AWS services communicate securely:
- **EC2 Instance Profile**: Role attached to EC2 instances for AWS SDK calls
- **Lambda Execution Role**: Permissions for Lambda to call other services
- **ECS Task Role**: Permissions for containers to access AWS services
- **Cross-Account Roles**: Allow one AWS account to access resources in another
- **AWS Service Roles**: Roles that AWS services (like CloudFormation) assume to act on your behalf

---

## 🏗️ Basic Architecture Explanation

In a well-architected application, every service that calls another service uses an IAM role. The architecture has no static credentials anywhere in the code. EC2 instance profiles, Lambda execution roles, and ECS task roles form a chain of trust where each service has exactly the permissions it needs.

---

## 🖥️ Hands-On Practice

> **Goal:** Create an IAM role that allows an EC2 instance to read from S3. Attach it to an EC2 instance and verify the instance can list S3 buckets without any credentials configured.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **IAM Roles and Policies** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: IAM Roles and Policies console dashboard*

---

## 📝 Key Exam Concepts

Know roles vs users: roles are for services/temporary access, users are for humans/long-term. Know that roles provide temporary credentials that rotate automatically. Know the difference between AWS Managed, Customer Managed, and Inline policies. Know what a trust policy is.

---

## ❓ Mini Knowledge Check

**Question 1:** What is the difference between an IAM User and an IAM Role?
<details>
<summary>Answer</summary>
An IAM User has permanent credentials (username/password or access keys) and is intended for human operators. An IAM Role has no permanent credentials — it provides temporary security tokens to whoever assumes it. Roles are for AWS services, cross-account access, and federated identity.
</details>

**Question 2:** Why should you use an IAM Role for an EC2 instance instead of an IAM User with access keys?
<details>
<summary>Answer</summary>
IAM Roles provide automatically rotating temporary credentials — the EC2 instance gets new credentials every few hours without any manual rotation. Access keys (from IAM users) are static and can be leaked in code, logs, or version control. Roles are the secure, recommended approach.
</details>

**Question 3:** What is an AWS Managed Policy?
<details>
<summary>Answer</summary>
AWS Managed Policies are pre-built IAM policies created and maintained by AWS for common use cases — like AmazonS3ReadOnlyAccess or AdministratorAccess. They are automatically updated when AWS adds new features to services, saving you the effort of maintaining policy documents.
</details>

**Question 4:** How does IAM Roles and Policies integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on IAM Roles and Policies resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for IAM Roles and Policies?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for IAM Roles and Policies. CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

IAM Roles are the secure way to grant AWS services permissions. Never hardcode credentials — use roles instead. Managed policies are convenient and maintained by AWS. Permission boundaries add a powerful guardrail layer. Master IAM Roles to master AWS security.

---

## 📚 Further Reading

- [AWS IAM Roles and Policies Documentation](https://docs.aws.amazon.com)
- [AWS Security & Identity Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day04-IAM-Basics/README.md) | [Next: Day 06 ➡️](../Day06-Amazon-EC2/README.md)*
