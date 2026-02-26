# 📖 AWS IAM Concepts Cheatsheet

> Quick reference guide for freshers learning AWS IAM

---

## 🔑 Core Concepts

### What is IAM?
IAM = **Identity and Access Management**  
It answers two questions:
- **Authentication** → *Who are you?* (login with username + password)
- **Authorization** → *What can you do?* (permissions to services)

---

## 👤 IAM Users

A **User** represents a **real person** who needs to access AWS.

```
alice.admin        → logs in at console.aws.amazon.com
bob.developer      → uses AWS CLI on their laptop
```

| Credential Type | Used For |
|----------------|---------|
| Username + Password | AWS Management Console (website) |
| Access Key ID + Secret | AWS CLI, SDKs, APIs |
| MFA Token | Extra security layer (mandatory in this project) |

---

## 🏢 IAM Groups

A **Group** is a **collection of users** that share the same permissions.

```
Group: "developers"
  ├── carol.dev
  ├── dave.dev
  └── iris.dev
  → All get: EC2, S3, Lambda, CloudWatch access
```

**Best Practice:** Never attach policies directly to users. Always use groups!

---

## 🎭 IAM Roles

A **Role** is for **AWS services** (not people) to access other services.

```
EC2 Instance → assumes ec2-instance-role → reads from S3
Lambda Function → assumes lambda-execution-role → writes to DynamoDB
GitHub Actions → assumes cicd-deployment-role → deploys to ECS
```

**Key Difference:**
- Users have permanent credentials
- Roles provide **temporary** credentials (automatically rotated!)

---

## 📋 IAM Policies

A **Policy** is a **JSON document** that defines what actions are allowed.

```json
{
  "Effect": "Allow",          ← Allow or Deny
  "Action": "s3:GetObject",   ← What API call
  "Resource": "arn:aws:s3:::my-bucket/*"  ← On which resource
}
```

### Two types of policies:
| Type | Description | Example |
|------|-------------|---------|
| **AWS Managed** | Pre-built by Amazon | `AdministratorAccess`, `ReadOnlyAccess` |
| **Custom** | Written by you | Custom developer policy in this project |

---

## 🔒 Security Best Practices

| Practice | Why? |
|---------|------|
| **Enable MFA** | Even if password is stolen, attacker can't login |
| **Least Privilege** | Only give minimum permissions needed |
| **Use Groups** | Easier to manage than per-user policies |
| **Use Roles for Services** | No hardcoded credentials on servers |
| **Rotate Access Keys** | Limit damage if keys are compromised |
| **Never use Root account** | Root has unlimited power — too dangerous for daily use |

---

## 🌐 ARN Format (Amazon Resource Name)

Every AWS resource has a unique ARN:
```
arn:aws:iam::123456789012:user/alice.admin
arn:aws:iam::123456789012:group/developers
arn:aws:iam::123456789012:role/ec2-instance-role
arn:aws:iam::aws:policy/AdministratorAccess
     ^    ^      ^            ^
  prefix  svc  account     resource
```

---

## 💻 Useful AWS CLI Commands

```bash
# List all users
aws iam list-users

# List all groups
aws iam list-groups

# List all roles
aws iam list-roles

# Show policies attached to a user
aws iam list-attached-user-policies --user-name alice.admin

# Show groups a user belongs to
aws iam list-groups-for-user --user-name alice.admin

# Test if an action is allowed (simulate permissions)
aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::ACCOUNT:user/alice.admin \
  --action-names s3:GetObject \
  --resource-arns arn:aws:s3:::my-bucket/*

# Check current identity
aws sts get-caller-identity
```

---

## 🧠 Common Interview Questions

**Q: What is the difference between a User and a Role?**  
A: Users are for humans with permanent credentials. Roles are for services with temporary credentials that auto-rotate.

**Q: What is the principle of least privilege?**  
A: Give users/services only the minimum permissions they need to do their job — nothing more.

**Q: Why should you use IAM Groups instead of attaching policies to users?**  
A: Groups make permission management scalable. When a new developer joins, add them to the "developers" group instead of re-assigning 10 individual policies.

**Q: What is MFA and why is it important?**  
A: Multi-Factor Authentication requires a second form of verification (phone app code) in addition to password. Even if a password is stolen, the account remains secure.

**Q: What is an IAM Role Trust Policy?**  
A: The trust policy defines WHO can assume the role (e.g., "EC2 service is allowed to use this role"). The permission policy defines WHAT they can do.
