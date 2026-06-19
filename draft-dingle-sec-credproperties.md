---
title: "Credential Management Security properties"
abbrev: "credproperties"
category: info

docname: draft-dingle-sec-credproperties-latest
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
    fullname: Dean H. Saxe
    organization: Remitly
    email: deans@remitly.com
normative:

informative:


--- abstract

This document defines a set of properties which explain and differentiate unique security characteristics of an authentication method.

--- middle

# Introduction
Every credential used to identify, authenticate, or otherwise validate a subject is different, and yet there is no specific vocabulary that describes exactly what a given credential should be expected to do, or why exactly it can be called "secure".  To address this shortcoming, this document describes categories of secure credential management and within defines _exact_ labels to describe the intended operation of a given credential.  These labels are intended for colloquial use and designed whenever possible to be accessible and intuitive for laypeople. The specification is scoped only to a credential in its common and expected use; properties for secure administration of credentials are not part of this set. Negative uses (attacks, vulnerabilities) are also not in scope.

# Credential Management Security Classes
Properties are organized into areas of scrutiny, with each class containing the minimum set of properties possible to satisfy differences that have clear security value. The property must have a security benefit that is inherent to the credential type.

# Credential Management Security Properties

## Presentation Limits
Credential reuse properties describe ways in which the use of a credential is functionally restricted.

### Validity Count
A credential becomes invalid after a specified number of successful presentations. An example would be a temporary password that can only be used 5 times, or a one-time password.

### Validity Window
A credential becomes invalid outside of a specified time boundary.  An example would be a SAML assertion or a TOTP.

### Selective Disclosure
A mechanism by which some or all of the contents within a credential are unavailable at presentation time. Example is an SD-JWT or a ZKP.

### Audience Restriction
A mechanism that specifies which destination consumers of the credential are valid.  Examples include `id_tokens` or origin bindings of FIDO tokens.

## Credential Containment & Unlock
Credential containment describes the at-rest state of a credential and its storage location(s). Unlock properties describe how the contained credential is made available for use at runtime and how the containment facility, if any, can play a security role in an observable way at operation time.

### Containment (TODO: see FIDO security requirements for sync fabric)
Describes how the creation, storage, and usage of a credential is managed. At one extreme, containment be within the boundary of a cryptographically supervised service or hardware element, e.g. an SSH private key stored in an HSM.  At the other extreme, the credential may be uncontained, e.g. a manually generated password.  A SSH private key stored on volatile media sits between these extremes, it is contained by access to the media on which it resides but it is not permanently bound to the media (see Boundary Binding, below).

### Boundary Binding
Boundary bindings describe the operational rules or limitations that limit where the secret portion of a credential could be stored. In the prior examples, the HSM bound SSH private key may not be extractable from the HSM, the HSM provides the boundary binding.  The password is unbounded, there are no limits on how the password may be moved or shared. The SSH key stored on volatile media is also unbound, since it may be copied and moved freely, e.g. it is exportable.

### Boundary Enforcement
The boundary enforcement property describes the mechanisms which ensure that operational rules are followed. Boundary enforcements can be proactive or reactive.  An example of a proactive boundary enforcement include binding the credential to the device, e.g. the SSH key generated and stored in an HSM. An example of a reactive boundary enforcement includes credential scanning of source code repositories.

### Transference
Transference is the ability for an end user to give the credential away to another user such that durable ongoing use is possible by two different entities.  This transference may be within the enforced boundary (e.g. sharing a synced passkey via a credential manager) or outside of the boundary (e.g. user copies a password from a credential manager to a file which is emailed to another user).

### Dynamism
Dynamism describes a credential whose stored and active forms are different. Credentials with no dynamism (or dynamic genarativity) such as passwords exibit no difference between the stored (in memory, in a password manager, etc.) and the credential sent to the verifier. Dynamic generativity indicates that some function is used to operate on the stored credential such that what is sent over the wire is different than what is stored (e.g. a challenge response protocol like FIDO).  Credentials that do not exhibit dynamism, such as shared secrets, are definitionally not able to be contained.

### Activation
A credential becomes available for an operation only when a local user gesture is performed. This user gesture may also be called an activation factor (see 800-63-4). Only a credential that is contained can be activated. A FIDO2 private key on a hardware security device that requires a PIN is an example of an activated credential. A biometric that unlocks a TPM on a laptop is another example of an activated credential.  Presence Activation is a case where locality is required but confirmation of a secret or biometric is not required. Individual Activation is a case where only one human can trigger the container to unlock.

### Unlock Scope
A credential may be unlocked by different parties which defines the scope of which entities can unlock credential for use.  The owner of a credential is always expected to be able to unlock their own credential. Credentials on shared devices may be unlocked by all users sharing the device. Similarly, credentials in a shared enterprise vault may be unlocked by a vault administrator.  Unlock scope is related to an instance of a credential and is distinct from the Credential Management Security Properties.

### Unlock Persistence
Credentials may be unlocked once with an activation factor (e.g. using a hardware security key), or the activation factor may be presented seconds to minutes before use (e.g. a credential vault remains unlocked for 5 minutes after use).

## Credential Enrollment
Credential enrollment properties describe requirements required to be met before a credential is created.

### Enrollment Assurance
Enrollment assurance describes the identity verification assurance level (todo, this feels like it points at NIST!) at the time the credential was created.

### Vouching
A vouched credential is one whose enrollment was enabled by the subject first authenticating with a separate, pre-existing credential. The prior credential acts as a gate on the enrollment event but does not contribute its key material to the new credential. After enrollment, the vouched credential is fully independent.  A user may present a passport as a proof of citizenship to be granted a state digital identity.

### Enrollment Binding
Enrollment binding describes the mechanism that binds the credential to the enrolled identity.

## Substantiation
Substantiation describes how a credential might derive security properties from an authority or other third party entity such as an issuer, provenance chain, or cryptographic signature.

### Identifier Binding
The primary content of a credential is cryptographically bound to an identifier. Examples of credentials that include bound identifiers include SAML assertions, JSON Web Tokens (jwts), X.509 certificates, ISO 18013 mobile drivers license objects and verifiable credentials

### Integrity
Integrity describes mechanisms built into the credential that ensure that the data within the credential can not be tampered with.

### Authoritative Relationship
Authority reputation describes any entities that the credential may derive security from, such as issuers, attestation authorities, delegators, or trust frameworks.

### Chainability
The credential is capable of including links to or content of other credentials.


## Credential Compliance
Credential provider compliance properties describe requirements on composition or management dictated by regulatory bodies.

### Composition Rules
Composition rules describe regulatory or standards-based requirements on how the credential must be constructed such as acceptable cryptographic algorithms.

### Lifecycle Rules
Lifecycle rules describe regulatory or standards-based requirements on credential rotation, expiry, or revocation.

### Regulatory Framework
Regulatory framework describes which regulatory framework or frameworks impose requirements on this credential type. Multiple values may apply simultaneously.


## Credential Recovery
Credential Recovery properties describe limitations of who can reset a credential or how a credential can be reset.  

### Recoverability
Recoverability is a binary property that describes whether access to a valid credential can be restored after loss.  Not all systems support recoverability.

### Recovery Agent
Recovery agent describes the entity, such as the user or an administrator, that can initiate and execute the recovery process.  A recovery agent MAY be null, e.g. when _Recoverability_ is "no".  Multiple recovery agents MAY be supported, e.g. when both the user and an administrator are required for recovery.

### Recovery Mechanism
Recovery mechanism describes the processes that enables recovery of a credential.  Example mechanisms may include SMS OTP, remote identity proofing, in-person identity proofing with a trusted referee, vouching, etc.  

### Recovery Artifact
Recovery artifacts are items used as part of the recovery mechanism. For example, a remote identity proofing session may be dependent upon an identity document such as a passport and a selfie video. Not all recovery mechanisms will use recovery artifacts, e.g. SMS or email OTP.

### Recovery Assurance
TODO - determine whether this can be defined in concrete terms vs. abstract terms

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
