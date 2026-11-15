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
workgroup: TBD
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
    organization: Full Frontal Nerdity Industries
    email: dean@thesax.es

normative:

informative:
  RFC4226:
  RFC4251:
  RFC5280:
  RFC6238:
  RFC7519:
  RFC8693:
  I-D.ietf-oauth-transaction-tokens:
  RFC9901:
  RFC9577:
  I-D.irtf-cfrg-bbs-signatures:
  I-D.irtf-cfrg-bbs-per-verifier-linkability:
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
  VC-DI-BBS:
    title: "Data Integrity BBS Cryptosuites v1.0"
    target: https://www.w3.org/TR/vc-di-bbs/
    date: 2026-09-10
    author:
      - org: World Wide Web Consortium
    seriesinfo:
      W3C: Candidate Recommendation Draft CRD-vc-di-bbs-20260910
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
  RFC6749:
  RFC6750:
  RFC7515:
  RFC8705:
  RFC9449:
  RFC7523:
  I-D.ietf-oauth-identity-assertion-authz-grant:
  I-D.ietf-oauth-sd-jwt-vc:
  CTAP:
    title: "Client to Authenticator Protocol (CTAP), Version 2.3"
    target: https://fidoalliance.org/specs/fido-v2.3-ps-20260226/fido-client-to-authenticator-protocol-v2.3-ps-20260226.html
    date: 2026-02-26
    author:
      - org: FIDO Alliance
    seriesinfo:
      FIDO Alliance: Proposed Standard
  DBSC:
    title: "Device Bound Session Credentials"
    target: https://www.w3.org/TR/dbsc/
    date: 2025-08-21
    author:
      - org: World Wide Web Consortium
    seriesinfo:
      W3C: First Public Working Draft WD-dbsc-1-20250821
  SPIFFE-X509-SVID:
    title: "The X.509 SPIFFE Verifiable Identity Document"
    target: https://github.com/spiffe/spiffe/blob/main/standards/X509-SVID.md
    author:
      - org: SPIFFE Project
  SPIFFE-JWT-SVID:
    title: "The JWT SPIFFE Verifiable Identity Document"
    target: https://github.com/spiffe/spiffe/blob/main/standards/JWT-SVID.md
    author:
      - org: SPIFFE Project
  PCI-DSS:
    title: "Payment Card Industry Data Security Standard: Requirements and Testing Procedures, Version 4.0.1"
    target: https://www.pcisecuritystandards.org
    date: 2024-06-11
    author:
      - org: PCI Security Standards Council
  CABF-BR:
    title: "Baseline Requirements for the Issuance and Management of Publicly-Trusted TLS Server Certificates, Version 2.3.0"
    target: https://cabforum.org/working-groups/server/baseline-requirements/documents/
    date: 2026-09-07
    author:
      - org: CA/Browser Forum

--- abstract

This document defines a set of properties that explain and differentiate the security characteristics of a credential.

--- middle

# Introduction
A credential is a set of data used to validate, confirm, or establish one or more claims about a named entity. Many diverse types of credential may be used to identify, authenticate, or otherwise validate a subject, and yet there is no specific vocabulary that describes exactly what a given credential should be expected to do, or why exactly it can be called "secure".  To address this shortcoming, this document describes categories of secure credential management and defines _exact_ labels to describe the intended operation of a given credential.  These labels are intended for colloquial use and designed whenever possible to be accessible and intuitive for laypeople. The specification is scoped only to a credential in its common and expected use; properties for secure administration of credentials are not part of this set. Negative uses (attacks, vulnerabilities) are also not in scope.

# Credential Management Security Classes
Properties are organized into areas of scrutiny, with each class containing the minimum set of properties possible to satisfy differences that have clear security value. The property must have a security benefit that is inherent to the credential type.

# Credential Management Security {#credential-management-security}

## Credential Construction Properties

### Substantiation
Substantiation describes credentials containing mechanisms for authoritative statements that can be externally validated. Examples of substantiated credentials include attestations such as SAML assertions {{SAML}} or X.509 certificates {{RFC5280}}.

### Dynamism
Dynamism describes a credential whose inactive (stored or at-rest) and active forms are different. Credentials with no dynamism (or dynamic generativity) such as passwords exhibit no difference between the stored value (in memory, in a password manager, etc.) and the credential sent to the verifier. Dynamic generativity indicates that some function is used to operate on the stored credential such that what is sent over the wire is different than what is stored (e.g. a challenge response protocol like FIDO {{WEBAUTHN}}).  Credentials that do not exhibit dynamism, such as shared secrets, usually exhibit replayability and are definitionally not able to be contained (see {{credential-containment}}).

### Bindability
Bindability describes whether a credential or its presentation can provide verifiable evidence of a relationship between the credential or its claims and one or more entities or contexts. These relationships can involve an issuer, subject, audience, communication channel, or device, and can be established or evaluated during issuance or presentation. When a credential is constructed to be bindable, a receiver of a credential can validate each present binding to mitigate potential threat vectors.

### Tamper Proofness
A mechanism for credential integrity is built into the credential ensuring that the data within the credential is verifiably unchanged by external parties.

### Chainability
The credential is capable of including links to or content of other credentials.

### Audience Restriction
A mechanism that specifies which destination consumers of the credential are valid.  Examples include `id_token` values {{OIDC-CORE}} or origin bindings of FIDO tokens.  Consumers of the credential should be responsible for validating the audience restriction before using an audience-restricted credential.

### Validity Window
A credential becomes invalid outside of a specified time boundary.  An example would be a SAML assertion or a TOTP {{RFC6238}}.

### Selective Disclosure {#selective-disclosure}
A credential is capable of selective disclosure if some or all of the contents within a credential can be made available or unavailable under circumstances determined at presentation time. Values can be: none, per-claim, or predicate.

* None: the credential is presented whole, or not at all.
* Per-claim: individual claims can be revealed or withheld at presentation time. The mechanism may be a salted hash over each claim, as in an SD-JWT {{RFC9901}} or an ISO mdoc {{ISO18013-5}}, or a zero-knowledge proof over the issuer's signature, as in a credential signed with the BBS signature scheme {{I-D.irtf-cfrg-bbs-signatures}}.
* Predicate: a statement about a claim can be proven without revealing the claim itself, such as proving that an age exceeds a threshold rather than disclosing a date of birth. Predicates require a proof construction beyond selective disclosure alone, such as a range proof; the BBS signature scheme selectively discloses claims but does not itself prove predicates.

Selective disclosure describes what a presentation reveals. Whether presentations can be correlated with each other is a separate property, Unlinkability ({{unlinkability}}); a credential may selectively disclose and still be fully linkable.

## Credential Presentation
Credential presentation properties describe ways in which the use of a credential is functionally restricted.

### Usage Count Limit
A credential is usage count limited if it becomes invalid after a specified number of successful presentations by a legitimate presenter. An example would be a temporary password that can only be used 5 times, or a one-time password.

### Replayability
Credentials are replayable when they can be captured by an adversary and represented to an authentication service resulting in successful authentication. Credentials that are presented directly, such as shared secrets (passwords) or bearer tokens, are the canonical example of replayable credentials.  Challenge response protocols are considered non-replayable.

OTPs represent an interesting class of crentials when describing replayability.  Deployed at a global scale, there is a small window of opportunity to present a HOTP {{RFC4226}} or TOTP multiple times within its validity window.  Therefore, replayability is not a strictly binary scale.

### Unlinkability {#unlinkability}
Unlinkability describes whether two presentations of a credential can be correlated with each other, or with the issuance of the credential, by the parties that observe them. A presentation that carries a static value such as an issuer signature, a certificate serial number, or a public key is linkable by any party that sees that value twice. {{RFC9901}} Section 10.1 distinguishes unlinkability between presentations, between verifiers, and between issuer and verifier, and observes that salted hash selective disclosure cannot achieve the last of these because the issuer-signed credential is presented directly to the verifier. The following table defines possible values.

| Value | Who Can Correlate | Characteristics |
|--------------|----------------------------|------------------------------|
| Linkable | Any observer | Presentations carry a static correlator. Examples include X.509 certificates, bearer tokens, SD-JWTs, and ISO mdocs, each of which presents the issuer's signature verbatim. |
| Verifier-unlinkable | Issuer together with a verifier | Verifiers cannot correlate presentations with each other, whether at one verifier or across verifiers, but each presentation still carries a value the issuer saw at issuance, so an issuer that compares notes with a verifier can link a presentation to its issuance. Batch issuance of single-use SD-JWTs with distinct salts and Key Binding keys achieves this {{RFC9901}}. |
| Issuer-unlinkable | No party | Each presentation is a freshly derived proof carrying no value that was visible at issuance, so even a colluding issuer and verifier cannot link a presentation to its issuance. Examples include a credential signed with the BBS signature scheme {{I-D.irtf-cfrg-bbs-signatures}} and a Privacy Pass token {{RFC9577}}. |

An issuer-unlinkable credential may be deliberately linkable within a single verifier when the holder derives a pseudonym that is stable for one verifier and unlinkable across verifiers {{I-D.irtf-cfrg-bbs-per-verifier-linkability}}. The values above describe the credential mechanism only; disclosed claim values, identifiers, and transport metadata can correlate presentations regardless of the mechanism, as described in Section 8 of {{VC-DATA-MODEL}}.

Unlinkability is independent of Referential Identity Posture. Posture describes whose identity is asserted; unlinkability describes whether presentations can be correlated. A credential with a Direct posture can be issuer-unlinkable, and a credential with a Pseudonymous posture is linkable whenever the same pseudonym is presented each time.

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

Examples of delegated referential identity posture include on-behalf-of (OBO) token interactions {{RFC8693}}, where both the identity of the end user and client software are communicated. Token exchange draws the same distinction normatively: a delegated actor retains its own identity while acting as an agent for another party, whereas an impersonating actor gains the rights of the party it impersonates and is indistinguishable from it. Examples of impersonated referential identity posture might include privileged access management workflows, where an administrative process sets either the identifier or the credential (or both) based on a backing identity. Examples of a partitioned referential identity posture could include openclaw agents acting with separate accounts and email addresses but loosely affiliated to individuals. Examples of a chained referential identity posture include transaction tokens {{I-D.ietf-oauth-transaction-tokens}}, which preserve the identity of the original caller as a request traverses a call chain of workloads, and which require the chain of workloads that requested a token to be carried forward each time that token is replaced. Token exchange expresses the same structure directly through nested actor claims, where the outermost actor is the current party and each nested actor a prior one. Examples of a pseudonymous referential identity posture include a credential presented under a per-verifier pseudonym {{I-D.irtf-cfrg-bbs-per-verifier-linkability}}, where the issuer holds a backing identity that the pseudonym conceals from the verifier. Examples of an anonymous referential identity posture include a Privacy Pass token {{RFC9577}}, which proves that an issuer vouched for the holder without identifying the holder, and a BBS proof that discloses only non-identifying claims, where the issuer attests a fact about the holder that no party can trace back to an individual.

## Credential Containment & Unlock {#credential-containment}
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
Credentials may be unlocked once with an activation factor (e.g. entering a PIN or biometric to activate a hardware security key), or the activation factor may be presented seconds to minutes before use (e.g. a credential vault remains unlocked for 5 minutes after use, allowing presentation of credentials from the vault without further activation).

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

**Credential:** Information or a mechanism used by a subject to prove a claim to a verifier. Depending on the credential type, it may include a stored secret or key, a value generated from that secret or key for presentation, or an assertion issued by another party. The stored and presented forms may be identical or different, as described by {{dynamism}}.

# Security Considerations

This document has no security considerations.

# IANA Considerations

This document has no IANA actions.

--- back

# Applying the Properties to Common Credential Types

This appendix illustrates how the properties defined in this document apply to a range of common credential types, to validate that the property set is expressive enough to differentiate them. Each class of properties defined in {{credential-management-security}} is presented as a table whose rows are credential types and whose columns are the properties of that class.

The credential types examined are:

- **Password / API key / client credential** — a shared secret presented directly to the verifier with no transformation.
- **Synced passkey (consumer)** — a WebAuthn credential synchronized across devices by a consumer credential manager such as a platform provider or password manager.
- **Device-bound passkey on FIDO L2 Certified security key** — a WebAuthn credential generated on and bound to a hardware authenticator implementing CTAP {{CTAP}} and certified at FIDO L2 or above.
- **SPIFFE X.509-SVID** — a workload identity issued as an X.509 certificate following attestation of the workload, presented via mutual TLS. See {{SPIFFE-X509-SVID}}.
- **SPIFFE JWT-SVID** — the same workload identity expressed as a signed JWT {{RFC7519}} and presented as a bearer token {{RFC6750}} to services that cannot terminate mutual TLS. See {{SPIFFE-JWT-SVID}}.
- **mTLS certificate** — a client certificate issued by a Web PKI or private CA outside of any SPIFFE trust domain, presented during the TLS handshake.
- **OAuth access token** — an access token {{RFC6749}} presented to a resource server, either as a signed JWT (bearer token) or as an opaque handle (reference token) the resource server validates by introspection.
- **Sender-constrained access token** — the same access token bound to a client key, so that presentation additionally requires proof of possession of that key, whether by DPoP {{RFC9449}} or by mutual TLS certificate binding {{RFC8705}}.  By adding proof of possession, the token no longer displays the properties of bearer tokens, it is bound to the key holder.
- **ID-JAG** — an Identity Assertion JWT Authorization Grant {{I-D.ietf-oauth-identity-assertion-authz-grant}}, a JWT issued by an enterprise identity provider when a client exchanges its ID token or SAML assertion for one, and presented by that client to a resource application's authorization server as a JWT authorization grant {{RFC7523}} to obtain an access token.
- **HOTP** — an HMAC-based counter-derived one-time password.
- **TOTP** — a time-derived one-time password.
- **SMS OTP** — a one-time code generated by the verifier and delivered out of band over the public telephone network.
- **SD-JWT VC** — a verifiable credential expressed as a selectively disclosable JWT {{I-D.ietf-oauth-sd-jwt-vc}}, built on the SD-JWT construction, optionally bound to a holder key.
- **ISO mdoc** — an ISO/IEC 18013-5 mobile document such as a mobile driving licence, comprising an issuer-signed Mobile Security Object and a device-signed response.
- **BBS verifiable credential** — a verifiable credential {{VC-DATA-MODEL}} secured with the BBS signature scheme {{I-D.irtf-cfrg-bbs-signatures}} through the Data Integrity BBS cryptosuite {{VC-DI-BBS}}, so that each presentation is a freshly derived zero-knowledge proof over the selectively disclosed claims rather than the issuer's signature itself.
- **DBSC** — Device Bound Session Credentials {{DBSC}}, a browser session credential bound to a non-exportable device key and periodically refreshed by proof of possession.

## Credential Construction

The following properties describe how a credential asserts and protects its content.

| Credential Type | Substantiation | Dynamism | Bindability | Tamper Proofness |
| --- | --- | --- | --- | --- |
| Password / API key | No | None; the stored and presented forms are identical | No; the value alone proves no relationship to an entity or context | No |
| Synced passkey | No; attestation is typically not conveyed | Dynamic; challenge-response | Yes; the signed assertion proves possession of a registered key for the relying party | Yes; signed assertion |
| Device-bound passkey | Yes; attestation statement conveys authenticator provenance if requested & validated by the RP | Dynamic; challenge-response | Yes; the signed assertion proves possession of the registered authenticator key for the relying party | Yes; signed assertion |
| SPIFFE X.509-SVID | Yes; CA-signed after workload attestation | Dynamic; the private key is never transmitted | Yes; issuer and SPIFFE subject are represented in the certificate, with key possession proven in TLS | Yes; CA signature |
| SPIFFE JWT-SVID | Yes; signed by the trust domain authority | None; presented verbatim as a bearer token | Yes; issuer, SPIFFE subject in `sub`, and audience are verifiable | Yes; JWS signature {{RFC7515}} |
| mTLS certificate | Yes; CA-signed | Dynamic; the private key is never transmitted | Yes; issuer and subject are represented in the certificate, with key possession proven in TLS | Yes; CA signature |
| OAuth bearer access token | Yes when the token is a JWT signed by the authorization server; No for an opaque token, which the resource server validates by introspection | None; presented verbatim | Yes; issuer, subject, and client relationships are carried by a JWT or established by introspection for an opaque token | Yes for a signed JWT; for an opaque token integrity rests on the issuer datastore rather than on the credential |
| Sender-constrained access token | Yes; issuer-signed | Dynamic; the token is static but each presentation requires a freshly signed proof of possession or the bound TLS client certificate | Yes; issuer and subject are asserted by the token, and proof of possession binds the presentation to the client key | Yes; signed by the authorization server |
| HOTP | No | Dynamic; counter-based derivation from the stored seed | Yes; the verifier associates the shared seed with an account during enrollment and verifies codes against it | No |
| TOTP | No | Dynamic; time-based derivation from the stored seed | Yes; the verifier associates the shared seed with an account during enrollment and verifies codes against it | No |
| SMS OTP | No | None; the verifier-generated value is presented verbatim | Yes; the verifier associates the destination phone number with an account and delivers the code to that number | No |
| SD-JWT VC | Yes; issuer-signed | None for the issuer-signed JWT; Dynamic when Key Binding is used | Yes; issuer and claims are signed, with an optional holder key in `cnf` when Key Binding is used | Yes; JWS signature over salted disclosure digests |
| ISO mdoc | Yes; issuer-signed Mobile Security Object | Dynamic; device signature or MAC over the session transcript | Yes; issuer claims are signed and the DeviceKey is bound in the MSO | Yes; per-data-element digests in the MSO |
| BBS verifiable credential | Yes; issuer-signed, though the signature is proven rather than shown | Dynamic; each presentation is a freshly derived proof, never the stored signature | Yes; issuer claims are proven, and a holder secret can be bound at issuance without being revealed at presentation, termed anonymous holder binding {{VC-DI-BBS}} | Yes; the proof verifies against the issuer's public key and fails if any disclosed claim is altered |
| DBSC | No | Mixed; the session cookie is static, the refresh proof is challenge-response | Yes; the session identifier and refresh proof are bound to the device key | No for the cookie; Yes for the signed refresh proof |

The following properties describe how a credential scopes and structures its content.

| Credential Type | Chainability | Audience Restriction | Validity Window | Selective Disclosure |
| --- | --- | --- | --- | --- |
| Password / API key | No | No | Policy-imposed only; not carried in the credential | None |
| Synced passkey | No | Yes; RP ID and origin binding | No; freshness is established by the challenge | None |
| Device-bound passkey | No | Yes; RP ID and origin binding | No; freshness is established by the challenge | None |
| SPIFFE X.509-SVID | Yes; X.509 chain to the trust domain CA | Partial; scoped to the trust domain and federated trust domains rather than a named service | Yes; short-lived and automatically rotated | None |
| SPIFFE JWT-SVID | No; single signer, no embedded chain | Yes; `aud` names the target service | Yes; short-lived | None |
| mTLS certificate | Yes; X.509 chain | No; accepted by any relying party trusting the CA | Yes; typically months to years | None |
| OAuth bearer access token | Yes; token exchange derives a token from a subject token and can record intermediate actors | Yes; the audience names the resource server | Yes; typically minutes to hours | None; scope constrains authorization rather than disclosure of credential content |
| Sender-constrained access token | Yes; token exchange applies, with the bound key re-established for the derived token | Yes; the audience names the resource server | Yes; typically minutes to hours | None |
| ID-JAG | Yes; derived by token exchange from an ID token or SAML assertion, itself exchanged for an access token, and may carry an `act` claim | Yes; `aud` names the resource application's authorization server | Yes; `exp`, with short lifetimes recommended | None; `scope` constrains the requested authorization rather than disclosure |
| HOTP | No | No | No; valid until the counter advances | None |
| TOTP | No | No | Yes; one time step plus drift tolerance | None |
| SMS OTP | No | No | Yes; issuer-set, typically minutes | None |
| SD-JWT VC | Yes; may reference or embed other credentials | Yes with a Key Binding JWT `aud`; No for the bare issuer-signed credential | Yes; `exp` and `nbf` | Per-claim |
| ISO mdoc | Yes; issuer certificate chain to the IACA | Partial; bound to the reader session transcript rather than a named audience | Yes; MSO `validityInfo` | Per-claim; per data element |
| BBS verifiable credential | Yes; may reference or embed other credentials | Yes when the presentation header carries the verifier's challenge or domain; No for the bare issuer-signed credential | Yes; validity claims must be disclosed, or proven by predicate, for the verifier to check them | Per-claim; predicates require a range proof beyond the base scheme |
| DBSC | No | Yes; scoped to the registrable domain | Yes; short-lived cookie, refreshed on expiry | None |

## Credential Presentation

| Credential Type | Validity Count | Replayability | Unlinkability | Referential Identity Posture |
| --- | --- | --- | --- | --- |
| Password / API key | Unlimited until rotated | Replayable | Linkable; the same secret is presented each time | Direct |
| Synced passkey | Unlimited | Not replayable | Linkable within an RP by credential ID; a distinct key pair per RP prevents correlation across RPs | Direct |
| Device-bound passkey | Unlimited | Not replayable | Linkable within an RP by credential ID; a distinct key pair per RP and batch-shared attestation certificates limit correlation across RPs | Direct |
| SPIFFE X.509-SVID | Unlimited within the validity window | Not replayable | Linkable; the certificate and SPIFFE ID are presented verbatim | Direct; Delegated when carrying on-behalf-of context |
| SPIFFE JWT-SVID | Unlimited within the validity window | Replayable within the validity window | Linkable; the signed token is presented verbatim | Direct; Delegated when carrying end-user context |
| mTLS certificate | Unlimited within the validity window | Not replayable | Linkable; the certificate is presented verbatim at every handshake | Direct |
| OAuth bearer access token | Unlimited within the validity window | Replayable; any party that captures the token can present it | Linkable; the same token is presented each time | Delegated when the token conveys both client and resource owner; Impersonated when it conveys only the resource owner |
| Sender-constrained access token | Unlimited within the validity window | Not replayable; a captured token is unusable without the bound private key | Linkable; the token and the bound key are stable for the token lifetime | Delegated; the client is identified by its bound key alongside the resource owner |
| ID-JAG | Unlimited within the validity window; the resource authorization server may enforce single use by tracking `jti` | Replayable within the validity window unless bound to a client key by a `cnf` claim; without binding, client authentication at the token endpoint is the only check against presentation by another party | Linkable; the issuer-signed JWT is presented verbatim, and `sub` is stable for a given resource authorization server | Delegated; the grant conveys both the user and the requesting client. Chained when an `act` claim records intermediate actors |
| HOTP | One; the counter advances on acceptance | Bounded; single use, but the code remains valid until the counter advances | Linkable; the code carries no correlator but is presented against an enrolled account identifier | Direct |
| TOTP | One per time step | Bounded; replayable within the time step and drift window | Linkable; presented against an enrolled account identifier | Direct |
| SMS OTP | One | Bounded; replayable within the issuer's window, and interceptable in transit | Linkable; presented against an enrolled account identifier | Direct |
| SD-JWT VC | Unlimited unless constrained by the issuer | Replayable without Key Binding; not replayable with a Key Binding JWT | Linkable; the issuer signature is presented verbatim. Verifier-unlinkable with batch issuance of single-use credentials carrying distinct salts and Key Binding keys {{RFC9901}} | Direct; Partitioned or Pseudonymous depending on the disclosed claim set |
| ISO mdoc | Unlimited within the validity window | Not replayable; the device signature covers the session transcript | Linkable; the issuer-signed MSO and the DeviceKey are presented verbatim | Direct; Partitioned when a subset of data elements is released |
| BBS verifiable credential | Unlimited unless constrained by the issuer | Not replayable when the presentation header carries a verifier challenge; a proof generated without one can be replayed | Issuer-unlinkable; deliberately linkable at a single verifier when presented under a per-verifier pseudonym | Direct; Pseudonymous under a per-verifier pseudonym; Anonymous when only non-identifying claims are disclosed |
| DBSC | Unlimited within the cookie lifetime | Bounded; the cookie is replayable within its short lifetime, the device key binding is not | Linkable; the session identifier and device key are stable for the session | Direct |

## Credential Containment & Unlock

The following properties describe containment of the credential at rest.

| Credential Type | Containment | Boundary Binding | Boundary Enforcement |
| --- | --- | --- | --- |
| Password / API key | Uncontained | Unbounded | Reactive; breach corpus matching and secret scanning |
| Synced passkey | Partially contained by the credential provider | Bound to the passkey provider; specifics depend on the provider | Managed by the passkey provider |
| Device-bound passkey | Contained | Bound to the hardware authenticator; non-exportable; verifiable through attestation at registration | Proactive; enforced by hardware |
| SPIFFE X.509-SVID | Contained when the key is TPM-bound; otherwise resident in workload memory | Bound to the TPM when hardware-backed; otherwise to the attested node and workload | Proactive when hardware-backed; otherwise enforced by the node attestor and workload API |
| SPIFFE JWT-SVID | Uncontained once issued; a bearer token | Unbounded after issuance | Reactive; mitigated by short lifetime |
| mTLS certificate | Contained in an HSM or TPM; uncontained as a key file | Bound to the HSM or TPM when hardware-backed; unbounded as an exportable file or PKCS#12 | Proactive when hardware-backed; otherwise reactive |
| OAuth bearer access token | Uncontained; a bearer string held in client memory, logs and intermediaries | Unbounded | Reactive; short lifetime, revocation and anomaly detection |
| Sender-constrained access token | The token is uncontained but unusable alone; the bound private key is contained and may be hardware-backed | Bound to the client proof-of-possession key | Proactive; the resource server rejects any presentation lacking a valid proof of possession |
| ID-JAG | Uncontained; a bearer assertion held in client memory until exchanged. The bound private key is contained when a `cnf` claim is used | Unbounded after issuance; bound to the client proof-of-possession key when sender-constrained | Reactive for the bare assertion; short lifetime and the client authentication check at the token endpoint. Proactive when sender-constrained |
| HOTP | Contained in a hardware token; uncontained as a soft seed | Bound to the hardware token; unbounded as a soft seed that can be re-enrolled from the provisioning URI | Proactive for hardware tokens; otherwise none |
| TOTP | Contained in a hardware token; uncontained as a soft seed | Bound to the hardware token; unbounded as a soft seed | Proactive for hardware tokens; otherwise none |
| SMS OTP | Uncontained; delivered in clear text and readable from the notification surface | Bound to control of the phone number, not to a device | Reactive; carrier-side controls against SIM swap and port-out |
| SD-JWT VC | Contained when the Key Binding key is in a secure element; the credential itself is data at rest in the wallet | Bound to the wallet key store when Key Binding is used; unbounded otherwise | Proactive when hardware-backed; otherwise none |
| ISO mdoc | Contained; DeviceKey resides in the device secure area | Bound to the device secure area | Proactive; enforced by hardware |
| BBS verifiable credential | The signed credential is data at rest in the wallet; the holder secret is contained only as far as the wallet software protects it, since proof generation consumes the secret directly and is not typically offered by hardware secure elements | Bound to the wallet key store when a holder secret is bound at issuance; unbounded otherwise | Reactive; enforced by wallet software |
| DBSC | Contained if the session key resides in the TPM or secure enclave; Partially contained for software based implementations | Bound to the device TPM or secure element where hardware backed, and non-exportable; partially bound for software based implementations | Proactive; enforced by hardware or software |

The following properties describe how a contained credential is released for use.

| Credential Type | Transference | Activation | Unlock Scope | Unlock Persistence |
| --- | --- | --- | --- | --- |
| Password / API key | Yes; freely copied | No | N/A | N/A |
| Synced passkey | Within the boundary via provider sharing; across providers via credential exchange where supported | Yes; biometric gesture or provider unlock | All users of the provider account, on every device the account syncs to | Configurable by the provider |
| Device-bound passkey | None | Yes; PIN or biometric gesture | The holder who can satisfy the PIN or biometric | Per-operation, or per-session where user verification caching applies |
| SPIFFE X.509-SVID | None | No | The attested workload | Life of the SVID, then re-issued |
| SPIFFE JWT-SVID | Yes; any holder can present it | No | Any holder of the token | Life of the token |
| mTLS certificate | None when hardware-bound; Yes when exportable | Optional; PIN on a smart card or HSM | The holder of the key store | Per-operation for smart cards; life of the process otherwise |
| OAuth bearer access token | Yes; the token is usable by any bearer | No | Any holder of the token | Life of the token |
| Sender-constrained access token | None unless the bound private key is transferred with the token | No; presentation is automated and requires no user gesture | The client that holds the bound private key | Life of the token; the bound key persists independently |
| ID-JAG | Yes for the bare assertion, though unusable by a party that cannot authenticate as the named client; None when bound to a hardware-backed client key | No; obtained and exchanged by the client with no user gesture after the initial sign-in | Any holder of the assertion that can authenticate as the named client | Life of the assertion; intended to be exchanged promptly rather than cached |
| HOTP | None for hardware tokens; Yes for soft seeds, which can be enrolled on multiple devices | Button press on some hardware tokens; otherwise No | The holder of the token or seed | N/A |
| TOTP | None for hardware tokens; Yes for soft seeds | Typically No | The holder of the token or seed | N/A |
| SMS OTP | Yes; the code can be read aloud or forwarded, which is the mechanism exploited by OTP phishing | No | Anyone with access to the device notification surface or the number | N/A |
| SD-JWT VC | Yes without Key Binding; None with a hardware-bound Key Binding key | Yes; wallet unlock gesture where required | The holder who can unlock the wallet | Configurable by the wallet |
| ISO mdoc | None; the DeviceKey is non-exportable | Yes; wallet unlock and per-presentation consent | The holder who can unlock the wallet | Per-presentation |
| BBS verifiable credential | Yes; the signed credential and the holder secret can be copied together when held in software | Yes; wallet unlock gesture where required | The holder who can unlock the wallet | Configurable by the wallet |
| DBSC | None for the key; the short-lived cookie can be copied | No; refresh is automatic with no user gesture | The browser profile on the bound device | Life of the session, with automatic cookie refresh |

## Credential Enrollment

| Credential Type | Enrollment Assurance | Vouching | Enrollment Binding |
| --- | --- | --- | --- |
| Password / API key | Varies; typically none beyond an existing account context | Sometimes; set during a vouched registration or reset flow | Association with the account record held by the verifier |
| Synced passkey | Inherits the assurance of the session that created it | Yes; enrollment is gated by a pre-existing credential | WebAuthn registration ceremony binds the public key to the user handle |
| Device-bound passkey | Enterprise-controlled; may require in-person proofing | Yes; typically gated by an enterprise credential or supervised enrollment | WebAuthn registration ceremony binds the public key to the user handle |
| SPIFFE X.509-SVID | Derived from node and workload attestation rather than human proofing | Yes; node attestation acts as the prior gate | Attestors bind the SPIFFE ID to the attested workload |
| SPIFFE JWT-SVID | Derived from node and workload attestation | Yes; node attestation acts as the prior gate | Attestors bind the SPIFFE ID to the attested workload |
| mTLS certificate | Varies by CA policy, from domain validation to in-person proofing | Often; CSR submission is gated by an existing credential | The CA binds the subject and SAN to the public key in the CSR |
| OAuth bearer access token | Inherits the assurance of the authorization grant and of the resource owner authentication behind it | Yes; issuance is gated by an authorization grant, itself gated by a pre-existing credential | The authorization server binds the token to client, resource owner, scope and audience at issuance |
| Sender-constrained access token | Inherits the assurance of the authorization grant and of the resource owner authentication behind it | Yes; issuance is gated by an authorization grant, itself gated by a pre-existing credential | As for a bearer token, and additionally binds the client proof-of-possession key into the token |
| ID-JAG | Inherits the assurance of the identity provider authentication behind the ID token or SAML assertion exchanged for it | Yes; issuance is gated by a prior ID token or SAML assertion presented in token exchange, and by identity provider policy for the client and resource application | The identity provider binds subject, requesting client, audience and scope into the signed grant at issuance |
| HOTP | Inherits the assurance of the session that enrolled it | Yes; enrollment is gated by a pre-existing credential | Seed shared between authenticator and verifier and recorded against the account |
| TOTP | Inherits the assurance of the session that enrolled it | Yes; enrollment is gated by a pre-existing credential | Seed shared between authenticator and verifier and recorded against the account |
| SMS OTP | Phone number possession only; no identity proofing | Yes; the number is registered during a vouched session | The verifier binds the phone number to the account record |
| SD-JWT VC | Set by issuer policy; may require high-assurance proofing | Yes; issuance is gated by prior credentials or in-person proofing | The issuer binds claims to the holder's `cnf` key |
| ISO mdoc | Set by the issuing authority; typically in-person proofing for an mDL | Yes; gated by the underlying document issuance process | The issuer binds the DeviceKey into the signed MSO |
| BBS verifiable credential | Set by issuer policy; may require high-assurance proofing | Yes; issuance is gated by prior credentials or in-person proofing | The issuer signs the claims together with a committed holder secret that it does not learn {{VC-DI-BBS}} |
| DBSC | Inherits the assurance of the sign-in that established the session | Yes; the session is established by a prior authentication | The browser binds the session identifier to a freshly generated device key |

## Credential Compliance

| Credential Type | Composition Rules | Lifecycle Rules | Regulatory Framework |
| --- | --- | --- | --- |
| Password / API key | Length and character composition may be enforced | Rotation, expiry, and reuse limits may be enforced |; {{PCI-DSS}} |
| Synced passkey | Algorithm set constrained by WebAuthn and COSE | Revocation by deregistration; no rotation concept | NIST SP 800-63B|
| Device-bound passkey | Algorithm set constrained by WebAuthn and COSE; authenticator certification level | Deregistration; key lifetime tied to the authenticator | NIST SP 800-63B up to AAL3; FIDO Alliance certification |
| SPIFFE X.509-SVID | Certificate profile and algorithms fixed by the SPIFFE X.509-SVID specification | Mandatory short lifetime with automatic rotation | SPIFFE specifications; deployment policy |
| SPIFFE JWT-SVID | JWS algorithms fixed by the SPIFFE JWT-SVID specification | Short lifetime; expiry only, no revocation | SPIFFE specifications; deployment policy |
| mTLS certificate | {{CABF-BR}} for the Web PKI; internal policy otherwise | Maximum validity period; revocation via CRL or OCSP | CA/Browser Forum Baseline Requirements; PKI operator policy |
| OAuth bearer access token | Format unconstrained by OAuth itself; the JWT profile applies where used | Short expiry; renewal and revocation controlled by the authorization server | Deployment policy; sector profiles may impose additional constraints |
| Sender-constrained access token | Proof-of-possession mechanism fixed by the binding profile in use | Short expiry; the bound key rotates independently of token lifetime | Deployment policy; financial-grade profiles require sender-constrained tokens |
| ID-JAG | JWT profile, `typ` value and signing algorithms fixed by the ID-JAG specification | Short expiry recommended; clients are directed to request a new grant rather than cache one | Deployment policy; the enterprise identity provider governs which clients may obtain grants for which resource applications |
| HOTP | HMAC algorithm and code length fixed by the HOTP specification | Seed rotation on re-enrollment; counter resynchronization | NIST SP 800-63B; PCI DSS |
| TOTP | Algorithm, time step, and code length fixed by the TOTP specification | Seed rotation on re-enrollment; time-step policy | NIST SP 800-63B; PCI DSS |
| SMS OTP | Code length and character set set by the verifier | Short expiry; per-attempt rate limiting | NIST SP 800-63B, which constrains out-of-band authenticators using the public telephone network; PCI DSS |
| SD-JWT VC | Disclosure construction and algorithms fixed by the SD-JWT specification | Issuer-set expiry; status list revocation | Issuer policy; wallet ecosystem governance frameworks |
| ISO mdoc | Cryptographic suites fixed by ISO/IEC 18013-5 | Issuer-set validity; MSO update and revocation | ISO/IEC 18013-5; issuing authority policy |
| BBS verifiable credential | Proof construction and pairing-friendly curve fixed by the BBS signature scheme and the cryptosuite | Issuer-set expiry; revocation requires a status mechanism that does not itself correlate presentations | Issuer policy; wallet ecosystem governance frameworks |
| DBSC | Key type constrained by the DBSC specification and platform TPM support | Session lifetime and refresh cadence set by the origin | None specific; inherits the session management requirements of the deploying framework |

## Credential Recovery

| Credential Type | Recoverability |
| --- | --- |
| Password / API key | Account-driven; reset via an alternate credential, the prior secret is not restored |
| Synced passkey | Issuer-driven; the provider's account recovery restores the synced credential |
| Device-bound passkey | Account-driven; a lost authenticator cannot be restored, a replacement must be enrolled against a backup credential |
| SPIFFE X.509-SVID | Issuer-driven; re-attestation yields a new SVID, recovery of the prior key is neither needed nor possible |
| SPIFFE JWT-SVID | Issuer-driven; re-attestation yields a new SVID |
| mTLS certificate | Issuer-driven where the CA supports key escrow or re-issuance; Account-driven otherwise, by revoking and re-enrolling |
| OAuth bearer access token | Issuer-driven; a new token is requested with a refresh token or a fresh authorization grant. The token itself is never recovered |
| Sender-constrained access token | Issuer-driven; a new token is requested and bound to a current key. Loss of the bound key requires a new key and a new token |
| ID-JAG | Issuer-driven; a new grant is requested from the identity provider by token exchange. The grant itself is never recovered |
| HOTP | Container-driven where an authenticator application backup restores the seed; Account-driven otherwise, by enrolling a new seed |
| TOTP | Container-driven where an authenticator application backup restores the seed; Account-driven otherwise, by enrolling a new seed |
| SMS OTP | Account-driven; recovery consists of regaining control of the phone number, typically through the carrier |
| SD-JWT VC | Issuer-driven; the holder re-requests issuance. A wallet backup may restore the credential but not a hardware-bound Key Binding key |
| ISO mdoc | Issuer-driven; reissuance by the issuing authority, the DeviceKey cannot be recovered |
| BBS verifiable credential | Issuer-driven; the holder re-requests issuance. A wallet backup may restore the credential and, where held in software, the holder secret |
| DBSC | Account-driven; the session is re-established by re-authenticating and the device key is regenerated |

# Acknowledgments
{:numbered="false"}

The authors would like to acknowledge the following individuals for their thoughtful feedback: George Fletcher, Elizabeth Garber, Ian Glazer, Andrew Hughes, Justin Richer, Jonathan Sander, Nick Steele, and the attendees of the Internet Identity Workshop 42, OAuth Security Workshop 2025, and Authenticate 2026.
