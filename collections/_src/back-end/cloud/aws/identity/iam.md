---
layout: page
title: IAM - Identity Access Management
permalink: /aws/iam
---

- TOC
{:toc}

---

# Introduction

What does IAM gives you?
* Allows you to manage users and their level of access to AWS console.
* Centralized control of your aws account
* Shared access to your aws account
* Granular Permissions
* Identity Federation(LDAP, Facebook, LinkedIn etc)
* MFA - Multifactor Authenticator, ex. username-password with token
* Provides temporary access to users.devices and services as necessary
* Allows you to setup your own password rotation policy
* Integrates with many aws services
* Supports PCI DSS Compliance for payment card services

## IAM Tems
* Users - End Users (people)
* Groups - Collection of users under one set of permissions
* Roles - Create roles and assign them to aws resources
* Policies - A document that defines one or more permissions

## Security Status Steps For new account

![iam-dashboard]({{site.cdn}}/aws/iam/iam-dashboard.png)

* Delete your root access keys
    - **Root Account** is the account created at the time of AWS Setup, it has complete admin access.
* Activate MFA on your root account
    - IAM Dashboard --> Activate MFA --> Google Authenticator
* Create individual IAM users
    - AccessKey and Access Secret 
        - For programatic login ie. access via APIs and Command Line.
        - visible only at the time of creation, after that you have to regenerate them in case you lost it.
    - Username and Password - Console login
    - New User have No Permission when first created.
* Use Groups to assign Permissions
    - Create Group --> GroupName --> Search s3 to add s3 read permission
    - User --> Groups Tab --> AssignGroup
* Apply IAM password policy.
    - Password policy --> set of rules
    - Can create custom password rotation policies.

```json
{
    "Version":"212-10-07",
    "Statement":[
        "Effect":"Allow",
        "Action":"*",
        "Resource":"*"
    ]
}
```

> ***IAM is universal***, doesn't apply to regions.

## Roles
* Roles --> Create Roles --> AWS Service --> Assign s3FullAccess permission --> roleName
* Grant permission to Application code running on an EC2 instance.

> ***Groups*** are for User, ***Roles*** are for entities

# Web Identity Federation

- Web Identity Federation gives your user access to AWS resources after they have succesfully authenticated with a web-based identity provider like Amazon, Facebook or Google.
- After successful authentication, user recieves an authentication code from the web identity provider, which they trade for temporary AWS security credentials.

## Amazon Cognito
Provides web identity federation with following features
- Signup and Signin to your apps.
- Access for guest users.
- Acts as an identitiy broker between your application and web id providers, so you don't need to write any additional code.
- Synchronizes user data for multiple devices.
- Recommended for all mobile applications AWS services.

Cognito brokers between your application and FB or Google to provide temporary credentials which map to an IAM role allowing access to the required resources.

No need for application to embed or store AWS credentials locally on the device and it gives users a seamless experience across all mobile devices.

## Cognito User Pools
- User Pools are directories used to manage sign-up and sign-in fucntionality for mobile and web applications.
- Users can signin directly to the User Pool or indirectly via ID Provider. Cognito acts as an identity broker between the ID Provider and AWS. Successful authentication generates number of JWT.
- Identity Pools enable you to create unique identities for your users and authenticate them with identity providers. With and identity, you can obtain temporary. limit-privilege AWS credentials to access other AWS services.

## Push Synchronization
- Cognito tracks the association between user identity and the various different devices they sign-in from.
- To provide seamless user experience for your application, Cognito uses Push Synchronization to push updates and synchronize user data across multiple devices.
- Amazon SNS is used to send a silent push notification to all your devices associated with a given user identity whenever data stored in the cloud changes.

# Types of IAM Policies

IAM (Identity Access Management) is used to define user access permissions within AWS.

There are 3 types of policies
- Managed Policies
- Customer Managed Policies
- Inline Policies

## Managed Policies
- A Managed Policy is an IAM policy which is created and administered by AWS.
- AWS provide Managed Policies for common use cases based on job function eg. AmazonDynamoDBFullAccess, AWSCodeCommitPowerUser, AmazonEC2ReadOnlyAccess etc.
- These aws provided policies allow you to assign appropriate permissions to your users, groups and roles without having to write the policy yourself.
- A Single managed policy can be attached to multiple users, groups or roles within the same AWS account and across different accounts.
- You cannot changes the permimssions defined in an AWS amanged policy.

## Customer Managed Policy
- A standalone policy that you create and administer inside your own aws account. You can attach this policy to multiple users, groups and roles- but within your own account.
- You can copy any managed policy and customize it to fit your organization requirements.
- Recommended for use cases where managed poicies don't meet needs of your environment.

## Inline Policies
- Embedded within the user, group or role to which it applies.
- Strict 1:1 relation between the entity and policy.
- When you delete the user, group or role with embedded policy, the policy will also be deleted.
- AWS recommends Managed Policies over Inline Policies.
- Used when you want to be sure that the permissions in a policy are not inadvertently assigned to any other user, group or role than the one they are intended for.

# STS AssumeRoleWithWebIdentity

- assume-role-with-web-identity is an API provided by STS (Security Token Service).
- Returns temporary security credentials for users authenticated by a mobile or web application or using a Web ID Provider like Amazon, Facebook or Google etc.
- For mobile applications, Cognito is recommended.
- Regular web applications can use STS assume-role-with-web-identity API.

![]({{site.cdn}}/aws/dev-theory/STS-AssumeRoleWithWebIdentity.png)

AWS Systems Manager Parameter Store provides secure, hierarchical storage for configuration data management and secrets management. You can store data such as passwords, database strings, and license codes as parameter values.

# IAM Policy Simulator

- Test the affects of IAM Policies before commiting them to production.
- Validate that the policy works as expected.
- Test policies already attached to existing users - great for troubleshooting an issue which you suspect is IAM related.
- https://policyim.aws.amazon.com
