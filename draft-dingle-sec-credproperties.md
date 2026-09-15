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
    email: dean@thesax.es
normative:

informative:
  RFC4226:
  RFC4251:
  RFC5280:
  RFC6238:
  RFC7519:
  RFC8693:
  RFC9901:
  SAML:
    title: "Assertions and Protocols for the OASIS Security Assertion Markup Language (SAML) V2.0"
    target: https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf
    date: 2005-03-15
    author:
      - org: Organization for the Advancement of Structured Information Standards
    seriesinfo:
      OASIS: Standard saml-core-2.0-os
  OIDC-CORE:
    title: "OpenID Connect Core 1.0 incorporating errata set 2"
    target: https://openid.net/specs/openid-connect-core-1_0.html
    date: 2023-12-15
    author:
      - org: OpenID Foundation
  WEBAUTHN:
    title: "Web Authentication: An API for accessing Public Key Credentials - Level 3"
    target: https://www.w3.org/TR/webauthn-3/
    date: 2026-08-25
    author:
      - org: World Wide Web Consortium
    seriesinfo:
      W3C: Recommendation REC-webauthn-3-20260825
  VC-DATA-MODEL:
    title: "Verifiable Credentials Data Model v2.0"
    target: https://www.w3.org/TR/vc-data-model-2.0/
    date: 2025-05-15
    author:
      - org: World Wide Web Consortium
    seriesinfo:
      W3C: Recommendation REC-vc-data-model-2.0-20250515
  ISO18013-5:
    title: "Personal identification - ISO-compliant driving licence - Part 5: Mobile driving licence (mDL) application"
    target: https://www.iso.org/standard/69084.html
    date: 2021-09
    author:
      - org: International Organization for Standardization
    seriesinfo:
      ISO/IEC: 18013-5:2021
  SP800-63A-rev4:
    title: "Digital Identity Guidelines: Identity Proofing and Enrollment"
    target: https://doi.org/10.6028/NIST.SP.800-63A-4
    date: 2025-07
    author:
      - org: National Institute of Standards and Technology
    seriesinfo:
      NIST: Special Publication 800-63A-4
  SP800-63B-rev4:
    title: "Digital Identity Guidelines: Authentication and Authenticator Management"
    target: https://doi.org/10.6028/NIST.SP.800-63B-4
    date: 2025-07
    author:
      - org: National Institute of Standards and Technology
    seriesinfo:
      NIST: Special Publication 800-63B-4


--- abstract

This document defines a set of properties which explain and differentiate unique security characteristics of an authentication method.

--- middle

# Introduction
Every credential used to identify, authenticate, or otherwise validate a subject is different, and yet there is no specific vocabulary that describes exactly what a given credential should be expected to do, or why exactly it can be called "secure".  To address this shortcoming, this document describes categories of secure credential management and within defines _exact_ labels to describe the intended operation of a given credential.  These labels are intended for colloquial use and designed whenever possible to be accessible and intuitive for laypeople. The specification is scoped only to a credential in its common and expected use; properties for secure administration of credentials are not part of this set. Negative uses (attacks, vulnerabilities) are also not in scope.

# Credential Management Security Classes
Properties are organized into areas of scrutiny, with each class containing the minimum set of properties possible to satisfy differences that have clear security value. The property must have a security benefit that is inherent to the credential type.

# Credential Management Security Properties

## Credential Construction Properties
### Substantiation
Substantiation describes credentials containing mechanisms for authoritative statements that can be externally validated. Examples of substantiated credentials include attestations such as SAML assertions {{SAML}} or X.509 certificates {{RFC5280}}.

### Dynamism
Dynamism describes a credential whose stored and active forms are different. Credentials with no dynamism (or dynamic genarativity) such as passwords exibit no difference between the stored (in memory, in a password manager, etc.) and the credential sent to the verifier. Dynamic generatvity indicates that some function is used to operate on the stored credential such that what is sent over the wire is different than what is stored (e.g. a challenge response protocol like FIDO {{WEBAUTHN}}).  Credentials that do not exhibit dynamism, such as shared secrets, usually exhibit replayability and are definitionally not able to be contained.

### Identifier Binding
The primary content of a credential is cryptographically bound to an identifier. Examples of credentials that include bound identifiers include SAML assertions, JSON Web Tokens (JWTs) {{RFC7519}}, X.509 certificates, ISO 18013 mobile driving licence objects {{ISO18013-5}} and verifiable credentials {{VC-DATA-MODEL}}

### Tamper Proofness
A mechanism for credential integrity is built into the credential ensuring that the data within the credential is verifiably unchanged by external parties.

### Chainability
The credential is capable of including links to or content of other credentials.

### Audience Restriction
A mechanism that specifies which destination consumers of the credential are valid.  Examples include `id_token` values {{OIDC-CORE}} or origin bindings of FIDO tokens.

### Validity Window
A credential becomes invalid outside of a specified time boundary.  An example would be a SAML assertion or a TOTP {{RFC6238}}.

### Selective Disclosure
A mechanism by which some or all of the contents within a credential can be made available or unavailable under circumstances determined at presentation time. Example is an SD-JWT {{RFC9901}} or a ZKP.

## Credential Presentation Properties
Credential reuse properties describe ways in which the use of a credential is functionally restricted.

### Validity Count
A credential becomes invalid after a specified number of successful presentations. An example would be a temporary password that can only be used 5 times, or a one-time password.

### Replayability
Credentials are replayable when they can be captured by an adversary and represented to an authentication service resulting in successful authentication. Credentials that are presented directly, such as shared secrets (passwords) or bearer tokens, are the canonical example of replayable credentials.  Challenge response protocols are considered non-replayable.

OTPs represent an interesting class of crentials when describing replayability.  Deployed at a global scale, there is a small window of opportunity to present a HOTP {{RFC4226}} or TOTP multiple times within its validity window.  Therefore, replayability is not a strictly binary scale.

### Referential Identity Posture
Referential Identity Posture describes the nature of the relationship between a claimed identity validated as part of an identity transaction and any backing identity that might explicitly or implicitly exist in a larger security context. That larger context may or may not be known to the party validating the credential and represents environmental detail that could be used in security, risk, or governance activities if known. The following table defines possible postures.

| Posture | Backing Identity Visibility | Relationship Characteristics |
|--------------|----------------------------|------------------------------|
| Direct | Explicit | Claimed identity and backing identity are the same entity. |
| Delegated | Explicit | Claimed identity is distinct from the backing identity, and the relationship is explicitly communicated. |
| Impersonated | Implicit | Claimed identity is presented as the backing identity; the underlying relationship exists but is external, inferred, or hidden. |
| Partitioned | Partial | Claimed identity represents a constrained portion or view of a backing identity; the linkage is incomplete or only partially disclosed. |
| Pseudonymous | Obfuscated | A backing identity exists, but the relationship between the claimed identity and backing identity is intentionally concealed or only recoverable by an authorized authority. |
| Chained | Recursive | Claimed identity derives from a backing identity through one or more intermediate referential identities, forming a transitive chain of relationships. |
| Anonymous | Detached | Claimed identity is visibly severed from any backing identity with no opportunity to recover. |

Examples of delegated referential identity posture include on-behalf-of (OBO) token interactions {{RFC8693}}, where both the identity of the end user and client software are communicated. Examples of impersonated referential identity posture might include privileged access management workflows, where an administrative process sets either the identifier or the credential (or both) based on a backing identity. Examples of a partitioned referential identity posture could include openclaw agents acting with separate accounts and email addresses but loosely affiliated to individuals.

## Credential Containment & Unlock Properties
Credential containment describes the at-rest state of a credential and its storage location(s). Unlock properties describe how the contained credential is made available for use at runtime and how the containment facility, if any, can play a security role in an observable way at operation time.

### Containment
Describes how the creation, storage, and usage of a credential is managed. At one extreme, containment be within the boundary of a cryptographically supervised service or hardware element, e.g. an SSH private key {{RFC4251}} stored in an HSM.  At the other extreme, the credential may be uncontained, e.g. a manually generated password.  A SSH private key stored on volatile media sits between these extremes, it is contained by access to the media on which it resides but it is not permanently bound to the media (see Boundary Binding, below).

### Boundary Binding
Boundary bindings describe the operational rules or limitations that limit where the secret portion of a credential could be stored. In the prior examples, the HSM bound SSH private key may not be extractable from the HSM, the HSM provides the boundary binding.  The password is unbounded, there are no limits on how the password may be moved or shared. The SSH key stored on volatile media is also unbound, since it may be copied and moved freely, e.g. it is exportable.

### Boundary Enforcement
The boundary enforcement property describes the mechanisms which ensure that operational rules are followed. Boundary enforcements can be proactive or reactive.  An example of a proactive boundary enforcement include binding the credential to the device, e.g. the SSH key generated and stored in an HSM. An example of a reactive boundary enforcement includes credential scanning of source code repositories.

### Transference
Transference is the ability for an end user to give the credential away to another user such that durable ongoing use is possible by two different entities.  This transference may be within the enforced boundary (e.g. sharing a synced passkey via a credential manager) or outside of the boundary (e.g. user copies a password from a credential manager to a file which is emailed to another user).

### Activation
A credential becomes available for an operation only when a local user gesture is performed. This user gesture may also be called an activation factor {{SP800-63B-rev4}}. Only a credential that is contained can be activated. A FIDO2 private key on a hardware security device that requires a PIN is an example of an activated credential. A biometric that unlocks a TPM on a laptop is another example of an activated credential.  Presence Activation is a case where locality is required but confirmation of a secret or biometric is not required. Individual Activation is a case where only one human can trigger the container to unlock.

### Unlock Scope
A credential may be unlocked by different parties which defines the scope of which entities can unlock credential for use.  The owner of a credential is always expected to be able to unlock their own credential. Credentials on shared devices may be unlocked by all users sharing the device. Similarly, credentials in a shared enterprise vault may be unlocked by a vault administrator.  Unlock scope is related to an instance of a credential and is distinct from the Credential Management Security Properties.

### Unlock Persistence
Credentials may be unlocked once with an activation factor (e.g. using a hardware security key), or the activation factor may be presented seconds to minutes before use (e.g. a credential vault remains unlocked for 5 minutes after use).

## Credential Enrollment
Credential enrollment properties describe requirements required to be met before a credential is created.

### Enrollment Assurance
Enrollment assurance describes the identity verification assurance level, such as the identity assurance levels defined in {{SP800-63A-rev4}}, at the time the credential was created.

### Vouching
A vouched credential is one whose enrollment was enabled by the subject first authenticating with a separate, pre-existing credential. The prior credential acts as a gate on the enrollment event but does not contribute its key material to the new credential. After enrollment, the vouched credential is fully independent.  A user may present a passport as a proof of citizenship to be granted a state digital identity.

### Enrollment Binding
Enrollment binding describes the mechanism that binds the credential to the enrolled identity.

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
Recoverability describes remediation capabilities that enable or re-enable access to a valid credential after loss or compromise. Values can be: issuer-driven, container-driven,or account-driven.
 * Issuer-driven: remediation is enabled by a direct party to the creation of the credential. Examples include credentials with multiple configured signing certificates, synced passkeys protected by a consumer trust layer, or hardware keys created with matching/derived seed values.
 * Container-driven: remediation enabled by a direct party to containment or unlock of the credential with pre-established administrative trust. Examples include PAM (privileged access management) systems or corporate password managers.
 * Account-driven: the credential cannot be restored, it can only be removed and replaced, often through a process that requires presentation of an unrelated alternate credential.

# Conventions and Definitions

{::boilerplate bcp14-tagged}

TODO define two parts of credential (secret, generated)

# Security Considerations

This document has no security considerations.

# IANA Considerations

This document has no IANA actions.

--- back

# Applying the Properties to Common Credential Types

This appendix illustrates how the properties defined in this document apply to several common credential types, to validate that the property set is expressive enough to differentiate them:

- **Password** — A shared secret.
- **Synced passkey - consumer** — a FIDO2/WebAuthn credential synchronized across devices by a credential manager such as 1Password or BitWarden. Consumer focused use case.
- **Device-bound passkey (hardware key) - enterprise** — a FIDO2/WebAuthn credential generated on and bound to a hardware security key managed by an enterprise.
- **SPIFFE X.509-SVID** — A workload identity and credentials issued as an X.509 certificate to the workload following attestation of the state of the workload. Credential is presented via mTLS to downstream services.

## Presentation Limits

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Validity Count | | | | |
| Validity Window | | | | Short term validity, SVIDs are rotated every 5 minutes.|
| Selective Disclosure | No | No | No | No |
| Audience Restriction | No | Yes (FIDO origin binding) | Yes (FIDO origin binding) | Yes (services within the trust domain or federated trust domains)|

## Credential Containment & Unlock

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Containment | Uncontained | Partially Contained | Contained | Contained when bound to a TPM |
| Boundary Binding | Unbounded | Bound to the passkey provider.  Specifics are dependent upon the provider. | Bound to the hardware key | Bound to a TPM |
| Boundary Enforcement | Reactive (identification in prior breaches, identified in clear text) | Managed by the passkey provider. | Enforced by hardware. | Enforced by hardware. |
| Transference | Yes | Within boundary via passkey provider sharing. Mechanisms depend on provider.  Export to another passkey provider via credential exchange protocol may be available. | None | None |
| Dynamism | None (static shared secret) | Dynamic (challenge-response) | Dynamic (challenge-response) | Dynamic (TLS) |
| Activation | No | Yes (biometric gesture or password/passphrase unlock) | Yes (PIN/biometric gesture) | No |
| Unlock Scope | N/A | All users on a shared device. |  | Workload |
| Unlock Persistence | N/A | Configurable by passkey provider. | Per-operation (unlock once) | Life of the workload |

## Credential Enrollment

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Enrollment Assurance | | | | |
| Vouching | | | | |
| Enrollment Binding | | | | |

## Substantiation

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Identifier Binding | | | | Yes (SPIFFE ID bound in X.509) |
| Integrity | | | | |
| Authoritative Relationship | | | | |
| Chainability | | | | |

## Credential Compliance

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Composition Rules | Length & composition may be enforced | | | |
| Lifecycle Rules | May be enforced | | | |
| Regulatory Framework | PCI, NIST SP800-63rev4 Part B | | | |

## Credential Recovery

| Property | Password / API key / client credential | Synced passkey | Device-bound passkey (hardware key) | SPIFFE X.509-SVID |
| --- | --- | --- | --- | --- |
| Recoverability | | | | |
| Recovery Agent | | | | |
| Recovery Mechanism | | | | |
| Recovery Artifact | | | | |
| Recovery Assurance | | | | |

# Acknowledgments
{:numbered="false"}

The authors would like to acknowledge the following individuals for their thoughful feedback: George Fletcher, Andrew Hughes, Justin Richer, and the attendees of the Internet Identity Workshop 42 and OAuth Security Workshop 2025.
