---
layout: page
title: OWASP
permalink: /owasp
---

1. TOC
{:toc}

---

# References
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/){:target="_blank"}
- [OWASP Cheat Sheet Series](https://owasp.org/www-project-cheat-sheets/){:target="_blank"}
- [OWASP Web Security Testing Guide](https://owasp.org/www-project-web-security-testing-guide/){:target="_blank"}
- [OWASP Code Review Guide](https://owasp.org/www-project-code-review-guide/){:target="_blank"}
- [OWASP Application Security Verification Standard](https://owasp.org/www-project-application-security-verification-standard/){:target="_blank"}
- [OWASP Software Assurance Maturity Model](https://www.opensamm.org/){:target="_blank"}
- [OWASP Risk Assessment Framework](https://owasp.org/www-project-risk-assessment-framework/){:target="_blank"}

# OWASP (Open Web Application Security Project)
- Making security visible and effective within web-based applications.
- Created Principles, Standards and Framework for secure web application programming.

# Injection Flaws
- Anyone who can send untrusted data to the system including external users, internal users and admins.
- Injection Flaws occur when an attacker sends hostile data to an interpreter.
- Injection vulnerability are often found in 
  - SQL, NoSQL Queries, ORM queries
  - OS commands
  - XML Parsers, SMTP headers
  - LDAP, XPath
  - expression language (EL) Object Graph Navigation Library (OGNL)
- Scanners and Fuzzers can help attackers find injection flaws.

```
http://example.com/app/account?id=' or '1'='1

select * from accounts where custId='' or '1'='1'
```

### Remedy
Source code review and automated testing of
- URL, Parameters, Headers, Cookies
- JSON, XML, SOAP

By separating untrusted data from command or query
- Use safe APIs that provide parameterized interface to avoid the use of interpreters
- If parameterized API not available, Be sure to escape special characters using the specific escape syntax for that interpreter.
- Use limit and other sql controls within queries to prevent mass disclosure of records in case of SQl injection.

# Broken Authentication
Attackers have access to combinations of valid usenames and passwords for
- Credential Stuffing
- Default administrative account lists.
- Automated brute force.
- Dictionary attack tools.

Can result into
- Money Laundering
- Social security fraud
- Identity theft
- Disclose legally protected highly sensitive information

Authentication weakness is present if application
- Permits automated attacks such as credential stuffing
- Permits brute force or automated attacks
- Permit default, weak or well known passwords - Password1 or admin/admin
- Uses weak or ineffective credential recovery and forgot password processes such as knowledge based answers which cannot be made safe.
- Uses plain text, encrypted or weakly hashed passwords.
- Has missing or ineffective multi-factor authentication.
- Exposes session IDs in URL eg. URL rewriting
- Does not rotate session IDs after successful login
- Does not properly invalidate Session IDs on logout or a period of inactivity (timeout). eg. tab closed instead of logout click.
- Same password used for very long time. (No password rotation policy)

# Sensitive Data Protection
Sensitive Data
- Personally Identifiable Information (PII)
- Personal Health Information (PHI)
- Propietary Data

Sensitive data can be stored as
- Data at rest
- Data at transit (HTTP, FTP, SMTP)
- Values in Customers browsers
- Logs

Attackers don't typically attack the crypto, they steal keys by executing man in the middle attacks.
Can be avaoided by encrypting the data. Do not serialize sensitive data.

### Fix
- Key rotation and management
- use SSL and TLS for all pages.

# XEE - XML External Entities

XML documents modified by attacker for XML Processors.

This attack can result into
- used to extract data
- execute remote requests from the server
- scan internal systems
- perform denial-of-service attack

# Broken Access Control
- Elevation of permission (Simple user acting as Admin)

### Fix
- Access Control check
- Deny by default
- min CORS usage
- log access control failures, notify admins when required
- invalidate jwt on logout

# Security Misconfiguration

- Default credentials
- unprotected files access
- cloud services misconfig
- error handlking exposes stack trace

# XSS - Cross-Site Security

- 3 forms of XSS
  - Reflected XSS - moderate impact, executes arbitrary html and js in victims browser
  - DOM XSS - moderate impact, JS frameworks, APIs and SPA that dynamically include attacker-controllable data.
  - Stored XSS - severe impact, stored unsanitized user inputs stored to viewed later by admin

Reults in 
- Session stealing
- Account takeover
- MFA bypass
- DOM node replacement or defacement (such as trojan login panels)
- Attacks against the user's browser (such as malicious software downloads)
- Key logging
- other client-site attacks

Fix
- Separation of untrusted data from active browser content
  - Using frameworks that automatically escape XSS by design like Ruby on Rails, react js
- Escaping untrusted Http request data based on the context in HTML output (body, attribute, js, css, url) will resolve XSS (reflected and stored), refer owasp cheat-sheet XSS prevention
- Enabling a content security policy

# Insecure Deserialization
- Application and APIs deserialize hostile or tampered objects supplied by an attacker.
- Results in Object and Data Structure related attacks.
- Serialization maybe used in application for
  - Remote and Inter-process communication (RPC/IPC)
  - Wire Protocols, web services, message brokers
  - Caching/Persistence
  - Databases, Cache Servers, file systems
  - Http Cookies, HTML form params, API authentication tokens

Fixes
- Implement integrity checks such as digital signatures on any serialized objects to prevent hostile object creation or data tampering.
- Enforce strict type constraints during deserialization
- Logging deserialization Exceptions and failures, incoming type is not same as expected type.

# Using Components with known vulnerabilities

# Insufficient Logging and Monitoring

