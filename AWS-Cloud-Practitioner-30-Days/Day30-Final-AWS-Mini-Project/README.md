# Day 30 – Final AWS Mini Project 🎉

![Day](https://img.shields.io/badge/Day-30-blue) ![Topic](https://img.shields.io/badge/Topic-Capstone%20Project-red) ![Level](https://img.shields.io/badge/Level-Beginner-green) ![Type](https://img.shields.io/badge/Type-Hands--On%20Project-purple)

---

## 🎯 Project Overview

Congratulations on making it to Day 30! Today you bring together everything you have learned across the past 29 days into a single, deployable cloud architecture. This project is your capstone — a demonstration that you can combine AWS services into a real solution.

**Project Name:** Static Website with Monitoring and Security

**What You Will Build:**
- A static website hosted on Amazon S3
- Delivered globally via Amazon CloudFront (CDN)
- Access managed securely with IAM roles and policies
- Monitored with Amazon CloudWatch alarms and dashboards
- Infrastructure defined in AWS CloudFormation templates

---

## 🏗️ Architecture Diagram

```
                           ┌─────────────────────────────────────────────────────┐
                           │                  AWS Cloud                          │
                           │                                                     │
  [ Website Visitor ]      │  ┌──────────────────────────────────────────────┐  │
        │                  │  │           Amazon CloudFront                  │  │
        │ HTTPS Request     │  │           (Global CDN)                       │  │
        └──────────────────►  │  Edge Location (closest to user)             │  │
                           │  └──────────────────┬───────────────────────────┘  │
                           │                     │ Cache Miss                   │
                           │                     ▼                              │
                           │  ┌──────────────────────────────────────────────┐  │
                           │  │            Amazon S3 Bucket                  │  │
                           │  │    (Static Website Hosting Enabled)          │  │
                           │  │                                              │  │
                           │  │  index.html, styles.css, scripts.js          │  │
                           │  │  images/, error.html                         │  │
                           │  │                                              │  │
                           │  │  Bucket Policy: Allow CloudFront OAC only    │  │
                           │  └──────────────────┬───────────────────────────┘  │
                           │                     │                              │
                           │  ┌──────────────────▼───────────────────────────┐  │
                           │  │           Amazon CloudWatch                  │  │
                           │  │  Metrics: CloudFront requests, errors        │  │
                           │  │  Alarms: Error rate > 5% → SNS notification  │  │
                           │  │  Dashboard: Traffic, latency, error rates    │  │
                           │  └──────────────────────────────────────────────┘  │
                           │                                                     │
                           │  ┌──────────────────────────────────────────────┐  │
                           │  │              AWS IAM                         │  │
                           │  │  Role: CloudFormation deployment role        │  │
                           │  │  Policy: S3 deploy, CloudWatch admin         │  │
                           │  └──────────────────────────────────────────────┘  │
                           │                                                     │
                           └─────────────────────────────────────────────────────┘
```

---

## 📁 Project Files

```
Day30-Final-AWS-Mini-Project/
├── README.md                    ← This file (architecture and walkthrough)
├── website/
│   ├── index.html               ← Main webpage
│   ├── error.html               ← Custom error page
│   └── styles.css               ← Styling
└── cloudformation/
    └── template.yaml            ← Infrastructure as Code
```

---

## 🌐 Part 1: Build the Static Website

### Step 1: Create the HTML File

Create `website/index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My AWS Cloud Practitioner Journey</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #0f1b2d; color: #fff; }
        header { 
            background: linear-gradient(135deg, #ff9900, #ff6600); 
            padding: 60px 20px; text-align: center;
        }
        header h1 { font-size: 2.5rem; margin-bottom: 10px; }
        header p { font-size: 1.2rem; opacity: 0.9; }
        .aws-badge { 
            display: inline-block; background: #232f3e; 
            color: #ff9900; padding: 8px 20px; border-radius: 20px;
            font-weight: bold; margin-top: 15px;
        }
        .container { max-width: 900px; margin: 0 auto; padding: 40px 20px; }
        .services-grid { 
            display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px; margin: 30px 0;
        }
        .service-card { 
            background: #1a2f45; border-radius: 12px; padding: 25px;
            border-left: 4px solid #ff9900; transition: transform 0.2s;
        }
        .service-card:hover { transform: translateY(-4px); }
        .service-card h3 { color: #ff9900; margin-bottom: 8px; }
        .service-card p { color: #8ea0b4; font-size: 0.9rem; }
        .stats { 
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 20px; margin: 40px 0;
        }
        .stat { text-align: center; background: #1a2f45; padding: 30px; border-radius: 12px; }
        .stat .number { font-size: 3rem; color: #ff9900; font-weight: bold; }
        .stat .label { color: #8ea0b4; margin-top: 5px; }
        h2 { color: #ff9900; margin: 40px 0 20px; font-size: 1.8rem; }
        footer { text-align: center; padding: 40px; background: #0a1525; color: #4a6280; }
    </style>
</head>
<body>
    <header>
        <h1>☁️ AWS Cloud Practitioner Journey</h1>
        <p>30 Days of Learning AWS Fundamentals</p>
        <div class="aws-badge">Hosted on Amazon S3 + CloudFront</div>
    </header>
    
    <div class="container">
        <div class="stats">
            <div class="stat">
                <div class="number">30</div>
                <div class="label">Days Completed</div>
            </div>
            <div class="stat">
                <div class="number">20+</div>
                <div class="label">AWS Services Learned</div>
            </div>
            <div class="stat">
                <div class="number">1</div>
                <div class="label">Certification Goal</div>
            </div>
        </div>

        <h2>🛠️ AWS Services I Learned</h2>
        <div class="services-grid">
            <div class="service-card">
                <h3>Amazon EC2</h3>
                <p>Virtual servers in the cloud with flexible pricing models</p>
            </div>
            <div class="service-card">
                <h3>Amazon S3</h3>
                <p>Object storage with 11 nines of durability — hosting this site!</p>
            </div>
            <div class="service-card">
                <h3>AWS IAM</h3>
                <p>Identity and access management for secure cloud operations</p>
            </div>
            <div class="service-card">
                <h3>Amazon VPC</h3>
                <p>Private cloud networking with complete traffic control</p>
            </div>
            <div class="service-card">
                <h3>AWS Lambda</h3>
                <p>Serverless compute — run code without managing servers</p>
            </div>
            <div class="service-card">
                <h3>Amazon RDS</h3>
                <p>Managed relational databases with automatic backups</p>
            </div>
            <div class="service-card">
                <h3>Amazon CloudFront</h3>
                <p>Global CDN delivering this website from 600+ edge locations</p>
            </div>
            <div class="service-card">
                <h3>Amazon CloudWatch</h3>
                <p>Monitoring and alerting for all AWS services</p>
            </div>
        </div>

        <h2>📚 Key AWS Concepts Mastered</h2>
        <ul style="list-style: none; padding: 0;">
            <li style="padding: 12px; border-bottom: 1px solid #1a2f45;">
                ✅ <strong>Shared Responsibility Model</strong> — AWS secures infrastructure, I secure my configuration
            </li>
            <li style="padding: 12px; border-bottom: 1px solid #1a2f45;">
                ✅ <strong>Well-Architected Framework</strong> — 6 pillars for building robust cloud systems
            </li>
            <li style="padding: 12px; border-bottom: 1px solid #1a2f45;">
                ✅ <strong>Pay-As-You-Go Pricing</strong> — No upfront costs, scale to match demand
            </li>
            <li style="padding: 12px; border-bottom: 1px solid #1a2f45;">
                ✅ <strong>High Availability</strong> — Multiple AZs, load balancing, auto scaling
            </li>
            <li style="padding: 12px;">
                ✅ <strong>Infrastructure as Code</strong> — CloudFormation for reproducible deployments
            </li>
        </ul>
    </div>

    <footer>
        <p>Built with ☁️ on AWS | Hosted on Amazon S3 | Delivered by CloudFront</p>
        <p style="margin-top: 10px; font-size: 0.85rem;">AWS Cloud Practitioner 30-Day Learning Journey</p>
    </footer>
</body>
</html>
```

### Step 2: Create an Error Page

Create `website/error.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Page Not Found</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 80px; background: #0f1b2d; color: white; }
        h1 { font-size: 4rem; color: #ff9900; }
        a { color: #ff9900; text-decoration: none; font-size: 1.2rem; }
    </style>
</head>
<body>
    <h1>404</h1>
    <p style="font-size: 1.5rem; margin: 20px 0;">Page not found in the cloud!</p>
    <a href="/">← Return to Home</a>
</body>
</html>
```

---

## ☁️ Part 2: Deploy to Amazon S3

### Step 1: Create an S3 Bucket

1. Go to **AWS Console → S3 → Create Bucket**
2. **Bucket name**: `my-aws-journey-[your-name]-[random]` (must be globally unique)
3. **Region**: Choose your nearest Region (e.g., `us-east-1`)
4. **Block Public Access**: Keep enabled for now (CloudFront will access it)
5. Click **Create Bucket**

### Step 2: Enable Static Website Hosting

1. Open your bucket → **Properties** tab
2. Scroll to **Static website hosting** → Click **Edit**
3. Enable: **Enable**
4. Index document: `index.html`
5. Error document: `error.html`
6. Click **Save changes**

### Step 3: Upload Website Files

1. Go to **Objects** tab → Click **Upload**
2. Upload `index.html` and `error.html`
3. Click **Upload**

### Step 4: Set Bucket Policy

Since we will use CloudFront with Origin Access Control (OAC), we configure the bucket policy after setting up CloudFront (see Part 3).

> 📸 *Screenshot placeholder: S3 bucket with uploaded files*
> 📸 *Screenshot placeholder: Static website hosting enabled confirmation*

---

## 🌍 Part 3: Set Up Amazon CloudFront

### Step 1: Create a CloudFront Distribution

1. Go to **AWS Console → CloudFront → Create Distribution**
2. **Origin domain**: Select your S3 bucket
3. **Origin access**: Select **Origin access control settings (recommended)**
4. Click **Create new OAC** → Create
5. **Viewer protocol policy**: **Redirect HTTP to HTTPS**
6. **Default root object**: `index.html`
7. Click **Create Distribution**

### Step 2: Update S3 Bucket Policy

1. After creating the distribution, CloudFront will show a **banner** with a bucket policy
2. Click **Copy policy**
3. Go to your **S3 bucket → Permissions → Bucket Policy**
4. Paste the policy and save

### Step 3: Wait for Deployment

CloudFront distributions take 5-15 minutes to deploy globally. Status changes from "Deploying" to "Enabled".

Once deployed:
- **CloudFront URL**: `https://d[xxxx].cloudfront.net`
- Visit the URL to see your website delivered globally via CDN!

> 📸 *Screenshot placeholder: CloudFront distribution status: Enabled*
> 📸 *Screenshot placeholder: Website loading from CloudFront URL*

---

## 🔐 Part 4: Configure IAM

### Create a Deployment IAM Policy

Create a policy named `S3WebsiteDeployPolicy`:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowS3WebsiteDeploy",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR-BUCKET-NAME",
                "arn:aws:s3:::YOUR-BUCKET-NAME/*"
            ]
        },
        {
            "Sid": "AllowCloudFrontInvalidation",
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateInvalidation"
            ],
            "Resource": "*"
        }
    ]
}
```

### Create a Deployment IAM Role

1. Go to **IAM → Roles → Create Role**
2. **Trusted entity**: AWS service → Select the deployment service you use
3. Attach the `S3WebsiteDeployPolicy` policy
4. Name it: `WebsiteDeploymentRole`

This follows the principle of least privilege — only the permissions needed for deployment.

---

## 📊 Part 5: Set Up CloudWatch Monitoring

### Create a CloudWatch Dashboard

1. Go to **CloudWatch → Dashboards → Create Dashboard**
2. Name: `WebsiteMonitoring`
3. Add the following widgets:

**Widget 1: CloudFront Requests**
- Metric: `AWS/CloudFront → Requests`
- Select your distribution
- Period: 5 minutes

**Widget 2: CloudFront Error Rate**
- Metric: `AWS/CloudFront → 4xxErrorRate` and `5xxErrorRate`
- Select your distribution

**Widget 3: CloudFront Bytes Downloaded**
- Metric: `AWS/CloudFront → BytesDownloaded`

### Create a CloudWatch Alarm

1. Go to **CloudWatch → Alarms → Create Alarm**
2. Select metric: `CloudFront → Per-Distribution Metrics → 5xxErrorRate`
3. **Threshold**: Greater than 5 (5% error rate)
4. **Period**: 5 minutes
5. **Action**: Send notification to an SNS topic (enter your email)
6. **Alarm name**: `WebsiteHighErrorRate`

> 📸 *Screenshot placeholder: CloudWatch dashboard with website metrics*
> 📸 *Screenshot placeholder: CloudWatch alarm configuration*

---

## 📝 Part 6: CloudFormation Template

Save this as `cloudformation/template.yaml` to deploy the same infrastructure automatically:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'AWS Cloud Practitioner Journey - Static Website Infrastructure'

Parameters:
  BucketName:
    Type: String
    Description: Globally unique name for the S3 website bucket
    Default: my-aws-journey-website

  NotificationEmail:
    Type: String
    Description: Email address for CloudWatch alarm notifications

Resources:

  # S3 Bucket for Static Website
  WebsiteBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref BucketName
      WebsiteConfiguration:
        IndexDocument: index.html
        ErrorDocument: error.html
      VersioningConfiguration:
        Status: Enabled
      Tags:
        - Key: Project
          Value: CloudPractitionerJourney
        - Key: Day
          Value: '30'

  # CloudFront Origin Access Control
  CloudFrontOAC:
    Type: AWS::CloudFront::OriginAccessControl
    Properties:
      OriginAccessControlConfig:
        Name: WebsiteOAC
        OriginAccessControlOriginType: s3
        SigningBehavior: always
        SigningProtocol: sigv4

  # CloudFront Distribution
  WebsiteDistribution:
    Type: AWS::CloudFront::Distribution
    Properties:
      DistributionConfig:
        Origins:
          - Id: S3Origin
            DomainName: !GetAtt WebsiteBucket.RegionalDomainName
            S3OriginConfig:
              OriginAccessIdentity: ''
            OriginAccessControlId: !GetAtt CloudFrontOAC.Id
        Enabled: true
        DefaultRootObject: index.html
        DefaultCacheBehavior:
          ViewerProtocolPolicy: redirect-to-https
          TargetOriginId: S3Origin
          CachePolicyId: 658327ea-f89d-4fab-a63d-7e88639e58f6  # CachingOptimized
          AllowedMethods:
            - GET
            - HEAD
        CustomErrorResponses:
          - ErrorCode: 404
            ResponseCode: 404
            ResponsePagePath: /error.html
        Tags:
          - Key: Project
            Value: CloudPractitionerJourney

  # S3 Bucket Policy allowing CloudFront
  WebsiteBucketPolicy:
    Type: AWS::S3::BucketPolicy
    Properties:
      Bucket: !Ref WebsiteBucket
      PolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Sid: AllowCloudFrontServicePrincipal
            Effect: Allow
            Principal:
              Service: cloudfront.amazonaws.com
            Action: s3:GetObject
            Resource: !Sub '${WebsiteBucket.Arn}/*'
            Condition:
              StringEquals:
                AWS:SourceArn: !Sub 'arn:aws:cloudfront::${AWS::AccountId}:distribution/${WebsiteDistribution}'

  # SNS Topic for Alerts
  AlertTopic:
    Type: AWS::SNS::Topic
    Properties:
      TopicName: WebsiteAlerts
      Subscription:
        - Protocol: email
          Endpoint: !Ref NotificationEmail

  # CloudWatch Alarm for High Error Rate
  ErrorRateAlarm:
    Type: AWS::CloudWatch::Alarm
    Properties:
      AlarmName: WebsiteHighErrorRate
      AlarmDescription: Alert when website 5xx error rate exceeds 5%
      MetricName: 5xxErrorRate
      Namespace: AWS/CloudFront
      Statistic: Average
      Period: 300
      EvaluationPeriods: 2
      Threshold: 5
      ComparisonOperator: GreaterThanThreshold
      Dimensions:
        - Name: DistributionId
          Value: !Ref WebsiteDistribution
        - Name: Region
          Value: Global
      AlarmActions:
        - !Ref AlertTopic

  # CloudWatch Dashboard
  MonitoringDashboard:
    Type: AWS::CloudWatch::Dashboard
    Properties:
      DashboardName: WebsiteMonitoring
      DashboardBody: !Sub |
        {
          "widgets": [
            {
              "type": "metric",
              "properties": {
                "title": "CloudFront Requests",
                "metrics": [["AWS/CloudFront", "Requests", "DistributionId", "${WebsiteDistribution}", "Region", "Global"]],
                "period": 300,
                "stat": "Sum",
                "view": "timeSeries"
              }
            },
            {
              "type": "metric",
              "properties": {
                "title": "Error Rates",
                "metrics": [
                  ["AWS/CloudFront", "4xxErrorRate", "DistributionId", "${WebsiteDistribution}", "Region", "Global"],
                  ["AWS/CloudFront", "5xxErrorRate", "DistributionId", "${WebsiteDistribution}", "Region", "Global"]
                ],
                "period": 300,
                "stat": "Average",
                "view": "timeSeries"
              }
            }
          ]
        }

  # IAM Role for Website Deployment
  DeploymentRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: WebsiteDeploymentRole
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: cloudformation.amazonaws.com
            Action: sts:AssumeRole
      Policies:
        - PolicyName: S3DeployPolicy
          PolicyDocument:
            Version: '2012-10-17'
            Statement:
              - Effect: Allow
                Action:
                  - s3:PutObject
                  - s3:GetObject
                  - s3:ListBucket
                Resource:
                  - !GetAtt WebsiteBucket.Arn
                  - !Sub '${WebsiteBucket.Arn}/*'

Outputs:
  WebsiteURL:
    Description: CloudFront distribution URL for the website
    Value: !Sub 'https://${WebsiteDistribution.DomainName}'
    Export:
      Name: WebsiteURL

  BucketName:
    Description: S3 bucket name
    Value: !Ref WebsiteBucket

  CloudFrontDistributionId:
    Description: CloudFront distribution ID
    Value: !Ref WebsiteDistribution
```

### Deploy the CloudFormation Stack

```bash
# Using AWS CLI:
aws cloudformation create-stack \
  --stack-name aws-journey-website \
  --template-body file://cloudformation/template.yaml \
  --parameters \
    ParameterKey=BucketName,ParameterValue=my-aws-journey-yourname \
    ParameterKey=NotificationEmail,ParameterValue=your@email.com \
  --capabilities CAPABILITY_IAM
```

---

## 🔍 AWS Services Used in This Project

| Service | Role in Project | Day Covered |
|---------|-----------------|-------------|
| **Amazon S3** | Store and serve website files | Day 08 |
| **Amazon CloudFront** | Global CDN for fast delivery | Day 02 (Edge Locations) |
| **AWS IAM** | Secure access with least privilege | Day 04-05 |
| **Amazon CloudWatch** | Monitor metrics and set alarms | Day 16 |
| **AWS CloudFormation** | Infrastructure as code | Day 24 |
| **Amazon SNS** | Email notifications for alarms | Day 22 |

---

## ✅ Project Validation Checklist

Use this checklist to verify your project is complete:

- [ ] S3 bucket created with a globally unique name
- [ ] Website files (index.html, error.html) uploaded to S3
- [ ] Static website hosting enabled on S3 bucket
- [ ] CloudFront distribution created and deployed (Status: Enabled)
- [ ] Website accessible via CloudFront HTTPS URL
- [ ] S3 bucket policy configured for CloudFront-only access
- [ ] IAM role created with least-privilege permissions
- [ ] CloudWatch dashboard created with traffic and error metrics
- [ ] CloudWatch alarm configured for high error rate
- [ ] SNS email notification subscription confirmed
- [ ] CloudFormation template created and working

---

## 🎓 What You Demonstrated

By completing this project, you have demonstrated:

1. **S3 Knowledge** — Creating and configuring a bucket for static hosting
2. **CloudFront Knowledge** — Setting up a global CDN with security best practices
3. **IAM Knowledge** — Creating roles and policies following least privilege
4. **CloudWatch Knowledge** — Building a monitoring dashboard and alarm
5. **CloudFormation Knowledge** — Defining the entire architecture as code
6. **Security Knowledge** — Using OAC instead of public S3 access
7. **Architecture Knowledge** — Combining multiple services into a coherent solution

---

## 🚀 Next Steps

Now that you have completed the 30-day journey:

1. **Schedule your exam** — Book the AWS Certified Cloud Practitioner exam at [aws.amazon.com/certification](https://aws.amazon.com/certification)
2. **Take practice exams** — Use [Tutorials Dojo](https://tutorialsdojo.com) or AWS Skill Builder
3. **Extend this project** — Add a contact form with Lambda + API Gateway + SES
4. **Explore AWS Solutions Architect** — Continue with the Associate level certification
5. **Add your project to your portfolio** — This GitHub repository demonstrates real AWS skills

---

## 🏆 30-Day Journey Complete!

```
Day 01 ✅  Cloud Computing Foundations
Day 02 ✅  AWS Global Infrastructure
Day 03 ✅  AWS Core Services Overview
Day 04 ✅  IAM Basics
Day 05 ✅  IAM Roles and Policies
Day 06 ✅  Amazon EC2
Day 07 ✅  Amazon EBS
Day 08 ✅  Amazon S3
Day 09 ✅  S3 Storage Classes
Day 10 ✅  Amazon RDS
Day 11 ✅  Amazon DynamoDB
Day 12 ✅  AWS VPC Basics
Day 13 ✅  Elastic Load Balancer
Day 14 ✅  Auto Scaling
Day 15 ✅  AWS Lambda
Day 16 ✅  Amazon CloudWatch
Day 17 ✅  AWS CloudTrail
Day 18 ✅  Shared Responsibility Model
Day 19 ✅  Well-Architected Framework
Day 20 ✅  AWS Pricing Model
Day 21 ✅  AWS Free Tier
Day 22 ✅  AWS Security Services
Day 23 ✅  AWS Compliance and Governance
Day 24 ✅  AWS CloudFormation
Day 25 ✅  AWS Organizations
Day 26 ✅  AWS Migration Services
Day 27 ✅  AWS Support Plans
Day 28 ✅  AWS Architecture Basics
Day 29 ✅  Exam Preparation
Day 30 ✅  Final Project — You Built This!
```

**You have completed the AWS Cloud Practitioner 30-Day Learning Journey. Go pass that exam! ☁️**

---

*[⬅️ Previous: Day 29 – Exam Preparation](../Day29-Exam-Preparation/README.md) | 🎉 Journey Complete!*
