# 🧪 Hands-On Labs

Practical hands-on exercises corresponding to each day's learning topic. All labs are designed to work within the AWS Free Tier.

---

## ⚠️ Before You Start

1. **Create an AWS Account** — [aws.amazon.com](https://aws.amazon.com)
2. **Set Up a Budget Alert** — Billing Console → Budgets → Create $1 budget with email alert
3. **Enable MFA** on your root account immediately
4. **Create an IAM User** for daily work (never use root for labs)
5. **Review the Free Tier** — [aws.amazon.com/free](https://aws.amazon.com/free) to understand limits

---

## Lab Index

| Day | Lab | Estimated Time | Cost |
|---|---|---|---|
| Day 01 | Explore AWS Console and create a Free Tier account | 20 min | Free |
| Day 02 | Compare resources across different Regions | 15 min | Free |
| Day 04 | Create IAM User, Group, and Policy | 30 min | Free |
| Day 05 | Create IAM Role and attach to a service | 20 min | Free |
| Day 06 | Launch EC2 t2.micro instance and connect | 45 min | Free Tier |
| Day 07 | Create EBS volume, attach to EC2, create snapshot | 30 min | Free Tier |
| Day 08 | Create S3 bucket, upload files, enable versioning | 30 min | Free Tier |
| Day 09 | Configure S3 Lifecycle Policy for storage class transitions | 20 min | Free |
| Day 10 | Launch RDS MySQL with Multi-AZ (⚠️ small cost) | 45 min | ~$0.05/hr |
| Day 11 | Create DynamoDB table, insert items, query data | 30 min | Free |
| Day 12 | Create VPC with public and private subnets | 45 min | Free |
| Day 13 | Create ALB with two EC2 targets | 45 min | ~$0.02/hr |
| Day 14 | Create Auto Scaling Group with Target Tracking policy | 45 min | Free Tier |
| Day 15 | Create Lambda function triggered by S3 upload | 45 min | Free |
| Day 16 | Create CloudWatch Dashboard and EC2 CPU alarm | 30 min | Free |
| Day 17 | Enable CloudTrail and query event history | 20 min | Free |
| Day 24 | Deploy CloudFormation stack (S3 bucket) | 30 min | Free |
| Day 30 | Complete Final Project: S3 + CloudFront + CloudWatch | 2 hrs | Minimal |

---

## Lab Tips

- **Always clean up resources** after each lab to avoid charges
- Use the **AWS Free Tier usage dashboard** in Billing to monitor usage
- **Tag all lab resources** with `Project: CloudPractitionerLab` for easy tracking
- **Delete resources in reverse order** of creation to avoid dependency errors
- When in doubt, check the [AWS Free Tier page](https://aws.amazon.com/free) before creating resources

---

## Resource Cleanup Checklist

After each lab, verify you have cleaned up:

- [ ] Terminated EC2 instances (running instances = charges)
- [ ] Deleted RDS instances (most expensive lab resource)
- [ ] Removed NAT Gateways (charged per hour when running)
- [ ] Released Elastic IPs (charged when not attached to running instance)
- [ ] Deleted CloudFormation stacks (automatically cleans up resources)
- [ ] Removed unused EBS volumes
- [ ] Deleted S3 buckets (remove all objects first)
