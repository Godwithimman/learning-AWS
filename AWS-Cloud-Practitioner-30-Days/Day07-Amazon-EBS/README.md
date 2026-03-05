# Day 07 – Amazon EBS

![Day](https://img.shields.io/badge/Day-07-blue) ![Topic](https://img.shields.io/badge/Topic-Amazon%20EBS-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

Your EC2 instance needs somewhere to store data that survives reboots. EBS provides persistent block storage that works like a hard drive attached to your server — data persists even when the instance stops, and you can take snapshots for backup.

---

## ☁️ What is Amazon EBS (Elastic Block Store)?

Amazon Elastic Block Store (EBS) provides persistent block storage volumes for use with EC2 instances. Think of EBS like a hard drive that you plug into your virtual server. Unlike the instance's local storage (which disappears when the instance stops), EBS data persists independently of the instance lifecycle.

---

## 🤔 Why AWS Created This Service

EC2 instances have local storage (instance store), but that data disappears when the instance stops or terminates. For databases, application data, logs, and anything important, you need durable storage that survives instance lifecycle events. EBS provides this persistent layer.

---

## 💼 Business Value

Teams run databases, store application data, and maintain OS state on durable, high-performance block storage without managing physical disks, RAID arrays, or storage hardware. EBS snapshots provide automated, incremental backups to S3.

---

## 🔑 Key Features

- **Volume Types**: gp3/gp2 (General Purpose SSD), io2/io1 (Provisioned IOPS SSD), st1 (Throughput Optimized HDD), sc1 (Cold HDD)
- **EBS Snapshots**: Point-in-time backups stored in S3, incremental and shareable
- **Encryption**: AES-256 encryption at rest and in transit using AWS KMS
- **Multi-Attach**: Attach io1/io2 volumes to multiple instances simultaneously (up to 16)
- **Elastic Volumes**: Modify volume type, size, and IOPS without downtime
- **Fast Snapshot Restore**: Pre-warm snapshots for immediate full performance

---

## 🏢 Real-World Use Case

A PostgreSQL database runs on EC2 with a 500GB io2 EBS volume for high IOPS performance. Automated EBS snapshots run every 4 hours (managed by AWS Data Lifecycle Manager). When a developer accidentally deletes critical data, the team restores from the most recent snapshot — data loss limited to under 4 hours.

---

## 💰 Pricing Overview

Priced per GB per month based on volume type:
- gp3: ~$0.08/GB/month (most common general purpose)
- io2: ~$0.125/GB/month + $0.065 per provisioned IOPS
- st1: ~$0.045/GB/month
- sc1: ~$0.015/GB/month
- EBS Snapshots: ~$0.05/GB/month (stored in S3, incremental)
- Free Tier: 30GB of EBS General Purpose (SSD) storage per month

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

- **EBS + EC2**: EBS volumes attach to EC2 instances in the same AZ only
- **EBS Snapshots + S3**: Snapshots are stored in S3 regionally
- **EBS + KMS**: Encryption uses AWS Key Management Service
- **EBS + CloudWatch**: Monitor volume performance (IOPS, throughput, latency)
- **EBS + Data Lifecycle Manager**: Automate snapshot creation and deletion

---

## 🏗️ Basic Architecture Explanation

EBS volumes exist in a specific Availability Zone and can only attach to EC2 instances in that same AZ. For disaster recovery, EBS Snapshots are Region-wide — you can create a new volume from a snapshot in any AZ within the Region. Cross-Region snapshot copies enable geo-redundant backups.

---

## 🖥️ Hands-On Practice

> **Goal:** Create a gp3 EBS volume, attach it to an EC2 instance, format the filesystem, mount it, write some data, create a snapshot, then restore from the snapshot to a new volume.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **Amazon EBS (Elastic Block Store)** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: Amazon EBS (Elastic Block Store) console dashboard*

---

## 📝 Key Exam Concepts

EBS is AZ-specific (cannot cross AZs directly). Snapshots are Region-level. Know the volume types: gp3 is the default for most workloads, io2 is for high-performance databases. Know the difference between EBS (persistent) and instance store (ephemeral). Snapshots are incremental.

---

## ❓ Mini Knowledge Check

**Question 1:** An EC2 instance is terminated. What happens to its attached EBS root volume by default?
<details>
<summary>Answer</summary>
By default, the root EBS volume is deleted when the instance is terminated (DeleteOnTermination is set to true for root volumes). Additional data volumes attached to the instance are NOT deleted by default. You can change this behavior when configuring the instance.
</details>

**Question 2:** What is the difference between EBS and EC2 instance store?
<details>
<summary>Answer</summary>
EBS is persistent — data survives instance stops, restarts, and you can detach and reattach to other instances. Instance store is ephemeral — it provides very fast local storage but all data is lost if the instance stops or terminates. Use EBS for databases and important data.
</details>

**Question 3:** Can you attach an EBS volume to an EC2 instance in a different Availability Zone?
<details>
<summary>Answer</summary>
No — EBS volumes can only be attached to EC2 instances in the same Availability Zone. To move data between AZs, create an EBS Snapshot (Region-wide), then restore it as a new volume in the target AZ.
</details>

**Question 4:** How does Amazon EBS (Elastic Block Store) integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on Amazon EBS (Elastic Block Store) resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for Amazon EBS (Elastic Block Store)?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for Amazon EBS (Elastic Block Store). CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

EBS is the persistent block storage layer for EC2. Match volume types to workloads: gp3 for most use cases, io2 for high-performance databases, st1 for big data sequential reads. Always create EBS Snapshots for backup. Remember: EBS is AZ-specific, Snapshots are Regional.

---

## 📚 Further Reading

- [AWS Amazon EBS (Elastic Block Store) Documentation](https://docs.aws.amazon.com)
- [AWS Storage Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day06-Amazon-EC2/README.md) | [Next: Day 08 ➡️](../Day08-Amazon-S3/README.md)*
