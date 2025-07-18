# GitHub Workflow - Role to Assume - OpenID Identity Provider

Guide for setting up AWS role to deploy from GitHub (link to official GitHub guide: [https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services))

```yaml
- name: Configure aws credentials
  uses: aws-actions/configure-aws-credentials@master
  with:
    role-to-assume: arn:aws:iam::XXXXXXX:role/GitHub_Deploy
    aws-region: region
```

## Step-by-Step Instructions

### Step 1: Create Identity Provider
- Access IAM (Identity and Access Management)
- Go to **Identity providers** section → **Add provider**
- Add "https://token.actions.githubusercontent.com" as the provider URL
- Add "sts.amazonaws.com" as the Audience
- Finalize the creation

![Identity Provider Setup](https://res.craft.do/user/full/24481d4b-5e0c-1d56-4e56-1d611a78fe8b/4F9A6AA3-DE78-4394-8130-3196A2DD98AB_2/OwiW4M3SdW9khsGvQCSVL1FoDYuarNOYCLvCxZb3uN4z/Screenshot%202024-05-02%20alle%2016.38.04.png)

### Step 2: Create Role
- After creating the new identity provider, still within IAM, navigate to **Roles → create role**
- Select "custom trust policy" and use the following JSON policy:

```json
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::00000000000:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:{your-github-profile}/{your-repository}:*"
                }
            }
        }
    ]
}
```

**Note:** Replace the ARN with your OpenID provider ARN created in the previous step, and update the repository reference to match your GitHub repository.

### Step 3: Configure Permissions
- In the "Add permission" section, select **"Administrator access"**
- Enter the role name → `GitHub_Deploy` and finalize

## Important Notes

> **NOTE:** This configuration is done once per account. Once the role linked to the identity provider is created, you only need to add a new object to the "Statement" array within the policy, identical to the others, changing the reference to the repository name you want to connect.

### Adding Multiple Repositories

To add more repositories to the same role, simply add a new statement object to the "Statement" array within the trust policy, changing only the repository reference in the condition.

