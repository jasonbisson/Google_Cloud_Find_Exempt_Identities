# Find Exempted Users in Cloud Audit Logging

## Purpose
Our new org policy constraint, "Disable Audit Logging exemption," raised a question. How do I find the "invisible" identities already exempt from admin read, data write, or data read events? This simple bash script will loop through the organization to find identities exempt. I'm crossing my fingers that your search comes up empty or you validate the reason why the identity is exempt! 

## Prerequisites

### Install gcloud
Download the latest gcloud SDK
https://cloud.google.com/sdk/docs/

### Require permissions 
```
resourcemanager.organizations.getIamPolicy
resourcemanager.folders.get
resourcemanager.folders.getIamPolicy
resourcemanager.projects.get
resourcemanager.projects.getIamPolicy
```

###  Set required organization id 
```
#Set variable with your organization id
$ export org_id=123456789
```
## Implementation

### Run script to find exempt identities in the organization,folder,and projects layers
```
$ ./find_exempt_identity.sh

```
### External Documentation
[Disabling Exempted Users in Cloud Audit Logging](https://cloud.google.com/blog/topics/developers-practitioners/disabling-exempted-users-cloud-audit-logging)

[Terraform Module for Organization Policy Constraints](https://github.com/terraform-google-modules/terraform-google-org-policy)
