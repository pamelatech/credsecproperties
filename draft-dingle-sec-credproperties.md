title: "Credential Management Security properties"
abbrev: "credproperties"
category: info

docname: draft-dingle-sec-credproperties
submissiontype: IETF  # also: "independent", "editorial", "IAB", or "IRTF"
number:
date:
consensus: true
v: 3
# area: sec
# workgroup: WG Working Group
keyword:
 - credentials
 - credential management
 - multifactor authentication
 - mfa
venue:
#  group: WG
#  type: Working Group
#  mail: WG@example.com
#  arch: https://example.com/WG
  github: "pamelatech/credsecproperties"
  latest: "https://pamelatech.github.io/credsecproperties/draft-dingle-sec-credproperties.html"

author:
 -
    fullname: Pamela Dingle
    organization: Microsoft
    email: pamela.dingle@microsoft.com
 -
    fullname: Dean Saxe
    organization: Beyond Identity
    email: dean.saxe@beyondidentity.com
normative:

informative:


--- abstract

This document defines a set of properties which explain and differentiate unique security characteristics of an authentication method. 

--- middle

# Introduction
Every credential used to identify, authenticate, or otherwise validate a subject is different, and yet there is no specific vocabulary that describes exacty what a given credential should be expected to do, or why exactly it can be called "secure".  To address this shortcoming, this document describes categories of secure credential management and within defines exact labels to describe the intended operation of a given credential.  These labels are intended for colloquial use and designed whenever possible to be accessible and intuitive for laypeople. The specification is scoped only to a credential in its common and expected use; properties for secure administration of credentials are not part of this set. Negative uses (attacks, vulnerabilities) are also not in scope.

# Credential Management Security Classes
Properties are organized into areas of scrutiny, with each class containing the minimum set of properties possible to satisfy differences that have clear security value. The property must have a security benefit that is inherent to the credential type.

# Credential Management Security Properties

## Credential Boundary
Credential boundary properties describe ways in which limits are placed on the storage location of a credential in its intended use. 
### Boundary Binding
Boundary bindings describe the operational rules or limitations that limit where the secret portion of a credential could be stored. 
### Boundary Enforcement
The boundary enforcement property describes the mechanisms which ensure that operational rules are followed. Boundary enforcements can be proactive or reactive.  An example of a proactive boundary enforcement include binding the credential to the device. An example of a reactive boundary enforcement includes credential scanning of source code repositories. 
### Exportability
Exportability is the ability for the end user to move the credential secret to a new operational boundary. 
### Transference
Transference is the ability for an end user to give the credential away to another user such that durable ongoing use is possible by two different entities.
### Dynamism
Dynamism describes the ability to . Credentials with no generation characteristics such as passwords contain one single indicates that there is no difference between the stored and sent credential.  Dynamic generativity indicates that some function is used to operate on the stored credential such that what is sent over the wire is different than what is stored.

## Presentation Limits
Credential reuse properties describe ways in which the use of a credential is functionally restricted.
### Validity Count
A credential becomes invalid after a specified number of successful presentations. An example would be a temporary password that can only be used 5 times, or a one-time password.

### Validity Window
A credential becomes invalid outside of a specified time boundary.  An example would be a SAML assertion or a TOTP.

### Selective Disclosure
A mechanism by which some or all of the contents within a credential are unavailable at presentation time. Example is an SD-JWT or a ZKP.

### Audience Restriction
A mechanism that specifies which destination consumers of the credential are valid.  Examples include id_tokens or origin bindings of FIDO tokens.

## Credential Containment & Unlock
Credential containment and unlock properties describe ways in which a secure element, TPM, or other secure storage facility could play a security role in an observable way at operation time.

### Containment (see FIDO security requirements for sync fabric)
The creation or generation of a credential or signature occurs within the boundary of a cryptographically supervised service or hardware element.  An SSH private key stored in an HSM would exhibhit the containment property, while an SSH private key stored on a disk drive would not.

### Activation
A credential becomes available for an operation only when a local user gesture is performed. This user gesture may also be called an activation factor (see 800-63-4). Only a credential that is contained can be activated. A FIDO2 private key on a hardware security device that requires a PIN is an example of an activated credential. A biometric that unlocks a TPM on a laptop is another example of an activated credential.  Presence Activation is a case where locality is required but confirmation of a secret or biometric is not required. Individual Activation is a case where only one human can trigger the container to unlock.  


## Credential Enrollment
Credential enrollment properties describe requirements placed on a credential as it is created. 

## Credential Provider Trustworthiness
Credential provider trustworhiness properties describe the requirements placed on the issuer or provider of a credential. 

## Credential Compliance
Credential provider compliance properties describe requirements on composition or management dictated by regulatory bodies.

## Credential Recovery
Credential Recovery properties describe limitations of who can reset the credential or how a credential can be reset.



# Conventions and Definitions

{::boilerplate bcp14-tagged}

TODO define two parts of credential (secret, generated)

# Security Considerations

TODO Security


# IANA Considerations

This document has no IANA actions.


--- back

# Acknowledgments
{:numbered="false"}

TODO acknowledge.
