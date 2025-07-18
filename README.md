# Serverless Dart for AWS Lambda template

A sample template for bootstrapping [Dart Runtime for AWS Lambda](https://github.com/awslabs/aws-lambda-dart-runtime) applications with Serverless Framework v4.

## 📦 Install

Install the [Serverless Framework](https://www.serverless.com/framework/docs/getting-started/) CLI.

```bash
npm install -g serverless
```

## 🔑 Serverless Access Key Configuration

This template uses Serverless Framework v4, which requires a Serverless Access Key for deployment. You'll need to:

1. Create a Serverless account at [https://app.serverless.com](https://app.serverless.com)
2. Generate an access key from your Serverless dashboard
4. Store your `SERVERLESS_ACCESS_KEY` used for deployment in your repository's secrets at https://github.com/{username}/{repoName}/settings/secrets


## 🛵 Deployment

This template includes an example [GitHub Actions](https://github.com/features/actions) [configuration file](.github/workflows/main.yml) which can unlock a virtuous cycle of continuous integration and deployment
(Every push to main branch results in a deployment).


## 🔑 AWS Deployment Role

The GitHub Actions workflow uses OpenID Connect (OIDC) to securely authenticate with AWS without storing long-term credentials. The "GitHub_Deploy" role is an IAM role configured with OIDC trust relationship that allows GitHub Actions to assume it using short-lived credentials.

In this part of the workflow file, you can find a reference to the "GitHub_Deploy" role:

```yaml
       - name: Configure AWS credentials
         uses: aws-actions/configure-aws-credentials@v4
         with:
           role-to-assume: arn:aws:iam::XXXXXXXX:role/GitHub_Deploy
           aws-region: your-aws-region
```
[HERE](github_role_guide.md) you can find a guide to configure the IAM role

## ℹ️ Additional Information

* See the [serverless-dart plugin's documentation](https://github.com/katallaxie/serverless-dart) for more information on plugin usage.
* See the [Dart Runtime for AWS Lambda](https://github.com/awslabs/aws-lambda-dart-runtime) for more information on writing Dart Lambda functions
