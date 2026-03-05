# Day 06 – Amazon EC2

![Day](https://img.shields.io/badge/Day-06-blue) ![Topic](https://img.shields.io/badge/Topic-Amazon%20EC2-orange) ![Level](https://img.shields.io/badge/Level-Beginner-green)

---

## 📋 Overview

If you need to run a web server, process data, or host any application in the cloud, EC2 is usually where you start. It is the foundational compute service that gives you virtual servers (instances) on demand — just like having your own server, but in AWS's data center.

---

## ☁️ What is Amazon EC2 (Elastic Compute Cloud)?

Amazon EC2 (Elastic Compute Cloud) provides resizable virtual servers (called instances) in the cloud. You choose the operating system, CPU, memory, storage, and networking configuration. EC2 instances run your applications just like a physical server would — but you can launch them in minutes and pay only while they run.

---

## 🤔 Why AWS Created This Service

Buying and maintaining physical servers is expensive, slow, and inflexible. EC2 eliminates the need to predict capacity, purchase hardware, wait for delivery, and hire staff to maintain physical machines. You get a server in minutes and can scale up or down based on actual demand.

---

## 💼 Business Value

Companies run any workload on EC2 — web servers, application servers, machine learning training, game servers, batch processing — without owning a single piece of hardware. They pay only for compute time actually used, with no capital expenditure.

---

## 🔑 Key Features

- **Instance Types**: t (general), c (compute-optimized), r (memory-optimized), p (GPU), i (storage-optimized)
- **AMIs (Amazon Machine Images)**: Templates containing OS + pre-installed software
- **Security Groups**: Stateful virtual firewall for controlling instance traffic
- **Key Pairs**: SSH keys for secure instance access
- **Elastic IPs**: Static public IP addresses for instances
- **User Data**: Bootstrap scripts that run on first launch
- **Instance Store**: Temporary, high-speed local storage
- **Placement Groups**: Control how instances are physically placed for performance

---

## 🏢 Real-World Use Case

Slack runs thousands of EC2 instances across multiple instance types: c5 instances for CPU-intensive message processing, r5 instances for memory-intensive search, and t3 instances for lower-traffic services. Auto Scaling automatically adds instances during peak hours and removes them overnight, keeping costs proportional to actual usage.

---

## 💰 Pricing Overview

**On-Demand**: Pay per second (Linux) or hour (Windows). No commitment. Highest price.
**Reserved Instances**: 1 or 3 year commitment. Up to 72% discount vs On-Demand.
**Spot Instances**: AWS's unused capacity. Up to 90% discount but can be interrupted with 2-min notice.
**Savings Plans**: Flexible hourly spend commitment. Up to 66% discount.
**Dedicated Hosts**: Physical server dedicated to you. For compliance/licensing requirements.

> 💡 Use the [AWS Pricing Calculator](https://calculator.aws) to estimate your specific costs.

---

## 🔗 Integration with Other AWS Services

EC2 is the hub of many AWS architectures:
- **EC2 + EBS**: Persistent block storage attached to instances
- **EC2 + ELB**: Distribute traffic across multiple instances
- **EC2 + Auto Scaling**: Automatically manage instance count
- **EC2 + VPC**: Network isolation and security
- **EC2 + IAM Roles**: Secure access to other AWS services
- **EC2 + CloudWatch**: Monitor CPU, memory, disk, and network

---

## 🏗️ Basic Architecture Explanation

EC2 instances run inside a VPC in a specific Availability Zone. Instances connect to EBS volumes for storage and to the internet via an Internet Gateway (public subnet) or NAT Gateway (private subnet). Security Groups control traffic. An Elastic Load Balancer distributes traffic across multiple instances in multiple AZs.

---

## 🖥️ Hands-On Practice

> **Goal:** Launch a t2.micro EC2 instance (Free Tier eligible), connect to it via EC2 Instance Connect, install a web server (Apache/nginx), and access it in your browser.

### Steps:
1. Log into the **AWS Management Console** at [console.aws.amazon.com](https://console.aws.amazon.com)
2. Search for **Amazon EC2 (Elastic Compute Cloud)** using the top search bar
3. Explore the service dashboard and main configuration options
4. Try creating a basic resource within Free Tier limits
5. Review the monitoring and logging options available
6. Clean up any resources to avoid unexpected charges

> 📸 *Screenshot placeholder: Amazon EC2 (Elastic Compute Cloud) console dashboard*

---

## 📝 Key Exam Concepts

**Pricing models are heavily tested**: On-Demand (flexible, no discount), Reserved (commit for discount), Spot (cheapest, can be interrupted). Know what an AMI is. Know Security Groups are stateful. Know the difference between instance families (t=general, c=compute, r=memory). Know that t2.micro is Free Tier eligible.

---

## ❓ Mini Knowledge Check

**Question 1:** What is an Amazon Machine Image (AMI)?
<details>
<summary>Answer</summary>
An AMI is a template that contains the OS, application server configuration, and applications needed to launch an EC2 instance. It is the blueprint for your instance. AWS provides AMIs for common OS configurations, and you can create custom AMIs from your own instances.
</details>

**Question 2:** What EC2 pricing model is best for a workload that runs continuously for 3 years?
<details>
<summary>Answer</summary>
Reserved Instances with a 3-year commitment offer the maximum discount (up to 72% off On-Demand). For predictable, steady-state workloads that run continuously, Reserved Instances are the most cost-efficient option.
</details>

**Question 3:** What is a Security Group and is it stateful or stateless?
<details>
<summary>Answer</summary>
A Security Group is a virtual firewall that controls inbound and outbound traffic to EC2 instances. It is stateful — if you allow inbound traffic on port 80, the response traffic is automatically allowed out, even if there is no explicit outbound rule for that connection.
</details>

**Question 4:** How does Amazon EC2 (Elastic Compute Cloud) integrate with AWS IAM for security?
<details>
<summary>Answer</summary>
IAM policies control who can access and perform operations on Amazon EC2 (Elastic Compute Cloud) resources. Follow the principle of least privilege — grant only the minimum permissions needed for each user, group, or role.
</details>

**Question 5:** What monitoring is available for Amazon EC2 (Elastic Compute Cloud)?
<details>
<summary>Answer</summary>
Amazon CloudWatch provides metrics, alarms, and dashboards for Amazon EC2 (Elastic Compute Cloud). CloudTrail logs all API calls. Together they provide full operational visibility and audit capability.
</details>

---

## ✅ Key Takeaways

EC2 is the backbone of AWS compute. Know the three pricing models (On-Demand, Reserved, Spot) — this is one of the most tested areas. Security Groups protect instances. AMIs are blueprints. Always use IAM Instance Profiles (roles) for secure access to other AWS services.

---

## 📚 Further Reading

- [AWS Amazon EC2 (Elastic Compute Cloud) Documentation](https://docs.aws.amazon.com)
- [AWS Compute Overview](https://aws.amazon.com/products)

---

*[⬅️ Previous](../Day05-IAM-Roles-and-Policies/README.md) | [Next: Day 07 ➡️](../Day07-Amazon-EBS/README.md)*
