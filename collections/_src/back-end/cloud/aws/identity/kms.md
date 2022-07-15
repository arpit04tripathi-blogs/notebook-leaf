---
layout: page
title: KMS - Key Management System - Encryption
permalink: /aws/kms
---

- TOC
{:toc}

---

# Introduction

- KMS - Key Management System
- Managed service to create and control the encryption keys used to encrypt your data
- Integrates with EBS, S3, RedShift, Elastic Transcoder, WorkMail, RDS etc.
- Encryption Keys are Regional.

It is a good practice to create 2 different users
- KMSManager - who creates and manages the key
- KMSEncryptor - who has the ability to encrypt and decrypt4

![]({{site.cdn}}/aws/kms/kms-iam-dashboard.png)

# CMK - Customer Master Key

- Customer Master Key
  - alias
  - create date
  - description
  - key state
  - key material(either customer provided or AWS provided)
- can never be exported
  - need to use cloud HSM
- KMS uses multitenancy hardware, cloud HSM is dedicated to you.

## Setup a CMK
- Create alias and descritpion
- Choose Key Material Option - KMS or external
- Define Key Administrative Permissions
  - IAM Users/Roles that can administer(but not use) the Key through the KMS API.
- Define Key Usage Permissions
  - IAM Users/Roles that can use the key to encrypt/decrypt data.

# KMS API Calls

```
aws kms encrypt --key-id <YourKeyId> --plaintext fileb://secret.txt --output text --query CiphertextBlob | base64 --decode > encryptedsecret.txt
```
```
aws kms decrypt --ciphertext-blob fileb://encryptedsecret.txt --output text --query Plaintext | base64 --decode > decryptedsecret.txt
```
```
aws kms re-encrypt --destination-key-id <YourKeyId> --ciphertext-blob fileb://encryptedsecret.txt | base64 > newencryptedsecret.txt
```
```
aws kms enable-key-rotation --key-id <YourKeyId>
```

# Envelope Encryption

Customer Master Key
- used to decrypt the data key (envelope key)
- evelope key is used to decrypt the data

Deleting KMS CMK will take anywhere between 7-30 days as per selection made by user.

![]({{site.cdn}}/aws/kms/envelope-encryption.png)
