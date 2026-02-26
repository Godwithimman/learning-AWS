# 🤝 Contributing Guide

Welcome! This project is great for learning. Here's how to contribute.

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork: `git clone https://github.com/YOUR_USERNAME/aws-iam-project`
3. **Create a branch**: `git checkout -b feature/add-data-science-role`
4. **Make changes**, test them, commit
5. **Push** to your fork: `git push origin feature/add-data-science-role`
6. Open a **Pull Request** on GitHub

## Ideas for Contributions

- 🧑‍💻 Add a new user group (e.g., `data-science`, `ml-engineers`)
- 🎭 Add a new IAM role (e.g., `glue-etl-role`, `sagemaker-role`)
- 📋 Add a new custom policy
- 📚 Improve documentation and comments
- 🐛 Fix a bug or typo
- 🧪 Add example tests with `terraform validate`

## Code Style

- Always add comments explaining **what** and **why**
- Use `terraform fmt` before committing: `terraform fmt -recursive`
- Follow naming convention: `${project_name}-resource-type-purpose`
- Keep policies following least-privilege principle

## Commit Message Format

```
feat: add data science group with SageMaker access
fix: correct Lambda role missing DynamoDB permission
docs: add explanation for cross-account role
refactor: simplify user-group membership locals
```

## Questions?

Open a GitHub Issue — no question is too basic for a fresher! 🌱
