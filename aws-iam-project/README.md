# 🔐 AWS IAM Project — Learn Cloud Security with Terraform

> **Perfect for freshers learning AWS Cloud & Infrastructure as Code (IaC)**  
> This project teaches you how to manage AWS Identity and Access Management (IAM) using Terraform.

---

## 📚 What is IAM?

**IAM (Identity and Access Management)** is the AWS service that controls **who** can do **what** in your AWS account.

| Concept | Simple Definition | Real-World Analogy |
|---------|-------------------|-------------------|
| **User** | A person who accesses AWS | An employee |
| **Group** | A collection of users | A department (e.g., HR, IT) |
| **Role** | Permissions for AWS services | A job title with responsibilities |
| **Policy** | A document that defines permissions | A rulebook |

---

## 🗂️ Project Structure

```
aws-iam-project/
│
├── 📁 modules/                   ← Reusable building blocks
│   ├── iam_users/                ← Creates IAM Users
│   ├── iam_groups/               ← Creates IAM Groups
│   ├── iam_roles/                ← Creates IAM Roles
│   └── iam_policies/             ← Creates Custom Policies
│
├── 📁 environments/              ← Separate configs per environment
│   ├── dev/                      ← Development environment
│   └── prod/                     ← Production environment
│
├── 📁 scripts/                   ← Helper shell scripts
├── 📁 .github/workflows/         ← CI/CD with GitHub Actions
│
├── main.tf                       ← Root: calls all modules
├── variables.tf                  ← All input variables defined here
├── outputs.tf                    ← What to show after terraform apply
├── versions.tf                   ← Terraform & provider version locks
└── terraform.tfvars              ← Your variable values go here
```

---

## 👥 IAM Resources Created

### 🏢 Groups (6 Groups)
| Group Name | Purpose | AWS Managed Policy |
|------------|---------|-------------------|
| `admins` | Full AWS access for cloud admins | `AdministratorAccess` |
| `developers` | Access to dev services (EC2, S3, Lambda, RDS) | `PowerUserAccess` |
| `devops` | Infrastructure + deployment pipelines | `PowerUserAccess` + custom |
| `readonly` | View-only access (for auditors/interns) | `ReadOnlyAccess` |
| `security` | Security auditing (CloudTrail, GuardDuty) | `SecurityAudit` |
| `billing` | Cost and billing management | `Billing` |

### 👤 Users (10 Users)
| Username | Group | MFA Enforced | Description |
|----------|-------|-------------|-------------|
| `alice.admin` | admins | ✅ | Cloud Administrator |
| `bob.devops` | devops | ✅ | DevOps Engineer |
| `carol.dev` | developers | ✅ | Backend Developer |
| `dave.dev` | developers | ✅ | Frontend Developer |
| `eve.security` | security, readonly | ✅ | Security Analyst |
| `frank.billing` | billing | ✅ | Finance Manager |
| `grace.readonly` | readonly | ❌ | Intern / Auditor |
| `henry.devops` | devops | ✅ | SRE Engineer |
| `iris.dev` | developers | ✅ | Full-stack Developer |
| `jake.readonly` | readonly | ❌ | Business Analyst |

### 🎭 Roles (6 Roles)
| Role Name | Trusted By | Purpose |
|-----------|-----------|---------|
| `ec2-instance-role` | EC2 Service | For EC2 to access S3, SSM |
| `lambda-execution-role` | Lambda Service | For Lambda to write logs, access DynamoDB |
| `ci-cd-deployment-role` | GitHub Actions (OIDC) | For automated deployments |
| `cross-account-readonly-role` | Another AWS Account | Read-only cross-account access |
| `rds-monitoring-role` | RDS Service | Enhanced RDS monitoring |
| `ecs-task-role` | ECS Tasks | For containers to access AWS services |

---

## 🚀 How to Get Started (Step-by-Step for Beginners)

### Step 1: Install Prerequisites
```bash
# Install Terraform
brew install terraform           # Mac
choco install terraform          # Windows
sudo apt install terraform       # Ubuntu/Linux

# Install AWS CLI
pip install awscli
aws configure                    # Enter your Access Key, Secret Key, Region
```

### Step 2: Clone and Setup
```bash
git clone https://github.com/YOUR_USERNAME/aws-iam-project.git
cd aws-iam-project
```

### Step 3: Initialize Terraform
```bash
terraform init
# This downloads AWS provider plugins
```

### Step 4: Preview Changes
```bash
terraform plan
# This shows you WHAT will be created — no changes made yet
```

### Step 5: Apply (Create Resources)
```bash
terraform apply
# Type 'yes' when prompted
```

### Step 6: Destroy (Clean Up)
```bash
terraform destroy
# ⚠️ This deletes everything — use carefully!
```

---

## 📖 Learning Resources

- [AWS IAM Documentation](https://docs.aws.amazon.com/iam/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [Terraform Getting Started](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

---

## 🔒 Security Best Practices Followed

- ✅ Principle of Least Privilege (users only get what they need)
- ✅ MFA enforced for all human users via policy
- ✅ No hardcoded passwords or access keys
- ✅ Password policy enforced (12+ chars, complexity required)
- ✅ Roles used for services instead of embedding credentials
- ✅ Groups used instead of attaching policies directly to users

---

## 🤝 Contributing

1. Fork the repo
2. Create a branch: `git checkout -b feature/add-new-role`
3. Commit: `git commit -m "Add data science role"`
4. Push: `git push origin feature/add-new-role`
5. Open a Pull Request

---

## 📝 License

MIT License — Free to use for learning and projects!

---

> 💡 **Tip for Freshers:** Start by reading `main.tf`, then explore each `modules/` folder. Each file has detailed comments explaining every line!
