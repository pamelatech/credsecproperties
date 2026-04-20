# Credential Management Security Properties: A Research Report

**Authors:** Dean H. Saxe, Claude

---

## Abstract

This report proposes a vocabulary and property taxonomy for reasoning about the security characteristics of authentication credentials. Existing frameworks — including the "something you know / something you have / something you are" factor taxonomy and authenticator assurance level (AAL) models — describe credential *types* but not the security *properties* that differentiate credentials within and across types. This work defines eight classes of credential management security properties, each with named sub-properties and discrete values, enabling structured and precise description of what a credential can and cannot resist — independent of how a verifying service is configured.

---

## 1. Motivation

### 1.1 The Factor Taxonomy Problem

The dominant framework for describing authentication credentials derives from NIST Special Publication (SP) 800-63 (all revisions):

> "The three types of authentication factors are something you know, something you have, and something you are. Each authenticator has one or more authentication factors."

This taxonomy describes *types* of credentials but conveys nothing about the security properties that distinguish one credential from another within the same type. A 4-digit personal identification number (PIN) and a 256-bit cryptographic key are both "something you know" — yet their resistance to systematic attack differs by many orders of magnitude.

The taxonomy has also driven a practice of factor-*counting*: 1FA, MFA, and increasingly N-factor requirements. Factor count is not a proxy for security. Two credentials stored in the same password manager, unlocked by the same biometric, do not provide meaningfully independent assurance — yet they count as two factors.

### 1.2 The Assurance Level Problem

NIST SP 800-63B-4 (July 2025) defines three authenticator assurance levels (AAL1, AAL2, AAL3). These collapse distinct security properties into a coarse ordinal scale. At AAL2, both a software time-based one-time password (TOTP) application combined with a password and a hardware-bound WebAuthn credential satisfy the requirement — despite meaningfully different resistance profiles against phishing, malware, and credential theft.

### 1.3 The Illusion of Diversity

A single credential store can simultaneously hold a passkey, a password, a TOTP seed, and recovery codes — all protected by the same master password or biometric. These appear to be multiple independent factors. In practice they share a single boundary: any party who controls the unlock credential controls all of them. The diversity is illusory. A property-based vocabulary makes this visible; factor-counting cannot.

---

## 2. Design Philosophy

### 2.1 Umbrella Structure: Coarse to Fine

This framework is an umbrella. It provides a structured vocabulary for reasoning about credential security properties, organized as a hierarchy:

- **Classes** (large-grained): eight areas of scrutiny, each a distinct dimension of credential security
- **Sub-properties** (fine-grained): specific named properties within each class that capture distinctions with clear security value
- **Values** (finest-grained): the discrete states a sub-property can take, which may be categorical, ordinal, or boolean

Discussion can proceed at any level of the hierarchy. Engaging with the class does not require resolving every sub-property. Engaging with a sub-property does not require using every value. The hierarchy enables appropriate granularity for the audience or use case.

### 2.2 Unit of Analysis: The Credential Held by the User

The unit of analysis is the **credential held by the user — not the service that accepts it.**

This framework describes properties inherent to the credential itself: what an attacker can do with it, where it can go, how it came to exist, and who controls it. It is not about how a relying party (RP) implements verification, how a server stores credential material, or what policies an enterprise enforces at runtime.

A credential does not become more phishing-resistant because a verifier is configured to use channel binding — resistance is a property of the credential mechanism, not the deployment. Properties belonging to the service or deployment context are explicitly out of scope.

### 2.3 Inherent vs. Contextual Properties

- **Inherent properties**: fixed by the credential's construction and type. A 4-digit PIN has low brute force resistance regardless of verifier configuration.
- **Contextual properties**: determined by deployment or management decisions (rate limiting, server-side storage, revocation infrastructure). Out of scope.

When a property is ambiguous, the framework errs toward the inherent classification and notes the ambiguity explicitly.

### 2.4 Accessibility

Labels must be accessible and intuitive for laypeople, not only security specialists. The framework is intended to support regulatory language, relying party requirements, and user-facing communication.

---

## 3. Factor Type Taxonomy

> Source: Dingle, Authenticate 2024, attributed to "IETF RFC 8176 factors + missing terms." RFC 8176 (Jones et al., June 2017) defines Authentication Method Reference (AMR) values for the `amr` claim. Familiarity is a proposed extension.

Factor types form overlapping categories. Some credentials span more than one type.

### 3.1 Knowledge
Credentials where security depends on a secret value the subject knows.

| Credential | AMR code |
|---|---|
| Knowledge-based authentication | `kba` |
| Local PIN | `pin` |
| Central password | `pwd` |

### 3.2 Possession
Credentials where security depends on physical or logical control of a device or channel.

| Credential | AMR code |
|---|---|
| Hardware key (device) | `hwk` |
| Software-secured key | `swk` |
| Smart card | `sc` |
| OTP device | `otp` |
| Out-of-band (OOB) secret | `sms\|email\|otp\|tel` |

### 3.3 Inherence
Credentials where security depends on a biological or behavioral characteristic of the subject.

| Credential | AMR code |
|---|---|
| Local biometric | `face\|fpt` |
| Identifying biometric | `face\|fpt\|iris\|retina\|vbm` |
| Local presence | `tap\|touch` |

### 3.4 Familiarity (Proposed Extension)
Signals that reinforce confidence without uniquely identifying the subject. Not in RFC 8176.

| Signal | Code |
|---|---|
| Policy / geolocation match | `geo` |
| Risk-based authentication match | `rba` |

Familiarity signals cannot substitute for authentication factors. They are risk inputs that add friction when conditions deviate from expected patterns.

### 3.5 Establishment vs. Confirmation Factors

| Role | Description |
|---|---|
| **Establishment factors** | Used to establish a session or identity; the primary credential in a flow |
| **Confirmation factors** | Used to confirm a previously established session; cannot independently establish identity |

Familiarity signals and local presence are confirmation factors. This distinction replaces the discredited "first factor / second factor" ordinal framing.

---

## 4. The Eight Classes: Overview

| # | Class | Key Question |
|---|---|---|
| 1 | Credential Boundary | Where can this credential go (or not go)? |
| 2 | Credential Recovery | Who helps when things go wrong? |
| 3 | Credential Containment and Unlock | Does a secure element or TPM play a role? |
| 4 | Credential Reuse | Can the same credential exist for two resources? |
| 5 | Credential Enrollment | What are the prerequisites to this credential existing? |
| 6 | Credential Provider Provenance | Does trust in the authenticator or provider matter? |
| 7 | Credential Compliance | What rules govern the credential's composition or management? |
| 8 | Credential Brute Force Resistance | How hard is it to discover this credential's value by systematic enumeration? |

> Source: Dingle / Saxe, Authenticate 2024 (slide 17) and `draft-dingle-sec-credproperties`.

---

## 5. Class 1: Credential Boundary

**Key question:** Where can this credential go (or not go)?

Boundary properties describe the limits placed on the location of a credential in its intended use. The goal is to describe where a credential *is expected* to be found and used during normal operation — not to enumerate every possible attack. Unexpected location is itself a security signal; the framework describes the baseline expectation.

### 5.1 Transference

**Definition:** Can the credential be given away and then *persistently* used by the recipient?

The "persistently" qualifier distinguishes transference from one-time phishing interception. A credential is transferable if another party can receive it and use it at will going forward, not merely intercept it once.

#### Values

| Value | Description |
|---|---|
| `non-transferable` | Cannot be used by any party other than the enrolled holder by design; physical or cryptographic binding prevents use by others |
| `constrained-transferable` | Can be shared within a limited population or time window; transfer is possible but the credential cannot be used indefinitely by an arbitrary third party |
| `freely-transferable` | Can be given to any party who can then use it persistently without detection or limitation |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware-bound key | `non-transferable` | Private key never leaves the hardware; the device must be physically handed over for any transfer |
| Synced passkey (managed provider) | `constrained-transferable` | Sync fabric restricted by enterprise policy to managed devices or accounts; transfer is possible but bounded to the managed population |
| Synced passkey (consumer provider) | `freely-transferable` | Credential provider allows sharing to any account (e.g., share-to-anyone export features); any recipient can use it persistently |
| TOTP OTP | `constrained-transferable` | The output is usable by any party within the validity window (~30s); persistent use requires access to the seed |
| Password | `freely-transferable` | Any party with the value can authenticate indefinitely |
| SMS OTP | `constrained-transferable` | Single output interceptable within validity window; persistent use requires SIM control |

### 5.2 Exportability

**Definition:** Can the user intentionally extract the credential from its current platform and import it into a different, unrelated platform or credential provider?

Exportability describes cross-platform portability — moving a credential from one credential provider to a different one (e.g., from iCloud Keychain to Google Password Manager). This is distinct from within-ecosystem sync, which is captured by Platform Sync (§5.5). Exportability is about deliberate, user-initiated transfer across platform boundaries.

The FIDO Alliance Credential Exchange Format (CXF v1.0 Proposed Standard, August 14, 2025) and Credential Exchange Protocol (CXP v1.0 Working Draft, October 3, 2024) define a standardized mechanism for credential portability. `platform-exportable` credentials are those whose export is feasible in principle, whether or not a given platform has implemented CXF/CXP.

Note: device-bound passkeys with hardware-enforced non-exportable keys cannot be exported even if the platform supports CXF/CXP; the key material cannot be extracted.

#### Values

| Value | Description |
|---|---|
| `non-exportable` | Credential material cannot leave its platform by design; the user cannot extract it even with explicit intent (e.g., hardware-bound key stored in a TPM or SE) |
| `platform-exportable` | Can be exported from the platform to a different credential provider using a credential exchange protocol (e.g., FIDO CXF/CXP) |
| `freely-exportable` | Can be moved to any arbitrary destination without restriction or protocol requirement; format is inherently portable (e.g., copy-paste, QR scan) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware security key (TPM/SE) | `non-exportable` | Private key generated in hardware; extraction is prevented by design |
| Synced passkey (software-backed) | `platform-exportable` | Key material can be exported cross-platform via FIDO CXF/CXP; not hardware-bound |
| TOTP seed | `freely-exportable` | QR code / base32 string can be entered into any authenticator app without protocol |
| Password | `freely-exportable` | Can be written, typed, pasted, or exported to any system without restriction |

### 5.3 Boundary Binding

**Definition:** What is the defined operational boundary of the credential in normal use?

Boundary binding describes the expected *scope* of a credential's existence — the set of locations or conditions under which it operates by design. It is categorical, not ordinal; different binding types are qualitatively distinct, not better or worse than each other.

#### Values

| Value | Description |
|---|---|
| `unbound` | No defined boundary; the credential has no inherent location or scope constraint |
| `person-bound` | Bound to a biological characteristic of a specific individual |
| `device-bound` | Bound to a specific physical device; credential does not leave that device |
| `platform-bound` | Bound to a platform or ecosystem; credential may move across devices within the platform |
| `channel-bound` | Bound to a communication channel (e.g., a phone number, a delivery address) |
| `shared-secret` | Boundary is the knowledge of the secret itself; accessible to any party who knows the value |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Identifying biometric | `person-bound` | Bound to the biometric characteristics of the enrolled individual |
| Hardware security key | `device-bound` | Key material never leaves the physical device |
| Synced passkey | `platform-bound` | Travels with the user across devices within one sync ecosystem |
| SMS OTP | `channel-bound` | Delivered to a specific phone number / SIM |
| Password | `shared-secret` | Accessible to anyone who knows the string |
| TOTP | `shared-secret` | Seed is a shared secret; any party with the seed generates valid OTPs |

### 5.4 Boundary Enforcement

**Definition:** What mechanism inherent to the credential type restricts its use to the defined operational boundary?

Enforcement describes what prevents the credential from escaping its defined boundary by design — not deployment-time controls. Rate limiting and account lockout are not boundary enforcement; they reduce attack velocity but do not change where the credential can go.

#### Values

| Value | Description |
|---|---|
| `none` | No enforcement mechanism inherent to the credential type; reliance on user compliance or convention |
| `policy-based` | Rules constrain the credential's scope, but enforcement depends on party compliance (e.g., complexity rules that affect guessability) |
| `cryptographic` | Cryptographic binding limits use to the defined boundary; the credential mathematically cannot authenticate to a verifier outside its scope |
| `hardware-enforced` | Hardware prevents the credential from leaving its defined boundary; even the operating system or privileged software cannot extract it |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password | `none` / `policy-based` | Nothing prevents sharing; complexity rules affect guessability but not boundary |
| WebAuthn credential | `cryptographic` | Origin binding (WebAuthn §7.1) prevents use at a different domain by cryptographic design |
| Hardware security key | `hardware-enforced` | SE/TEE prevents key extraction; boundary is enforced at the silicon level |
| TOTP | `none` | Seed can be extracted and used anywhere; OTP output transferable within validity window |
| Identifying biometric | `cryptographic` + `person-bound` | Matching against an enrolled template; cannot be directly replayed |

### 5.5 Platform Sync

**Definition:** Does the credential synchronize across devices within a single platform ecosystem, and if so, what governs the scope of that sync?

Platform sync is distinct from exportability. Exportability is about leaving the platform entirely (cross-provider transfer). Sync is about the credential's presence across multiple devices *within* a provider's ecosystem — for example, a passkey stored in iCloud Keychain appearing on all devices signed into the same Apple ID.

Sync is an inherent design property of some credential types (synced passkey vs. device-bound passkey). For other types (passwords), sync is a management choice and is noted as such.

#### Values

| Value | Description |
|---|---|
| `no-sync` | Credential does not synchronize; it exists only on the device or hardware where it was created |
| `ecosystem-sync` | Credential synchronizes automatically across devices within a single platform ecosystem (e.g., iCloud Keychain, Google Password Manager, Microsoft account); sync scope is controlled by the ecosystem provider |
| `management-dependent` | Whether the credential syncs depends on where and how it is stored (e.g., a password stored in a local file vs. in a syncing password manager); sync is a management property, not inherent to the credential type |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware security key | `no-sync` | Key material is device-bound by hardware design; cannot sync |
| Device-bound passkey | `no-sync` | Explicitly created as non-syncable; remains on the originating device |
| Synced passkey (iCloud) | `ecosystem-sync` | Automatically available on all Apple devices signed into the same Apple ID |
| Synced passkey (Google) | `ecosystem-sync` | Automatically available across Android/Chrome on the same Google account |
| Password | `management-dependent` | Syncs if stored in a syncing password manager; does not sync if stored locally |
| TOTP seed | `management-dependent` | Syncs if the authenticator app has cloud backup; does not sync otherwise |
| Biometric template | `no-sync` | Enrolled locally; biometric templates are not transmitted or synchronized by design |

### 5.6 Class 1 Summary Table

| Sub-property | Values |
|---|---|
| **Transference** | `non-transferable` · `constrained-transferable` · `freely-transferable` |
| **Exportability** | `non-exportable` · `platform-exportable` · `freely-exportable` |
| **Platform Sync** | `no-sync` · `ecosystem-sync` · `management-dependent` |
| **Boundary Binding** | `unbound` · `person-bound` · `device-bound` · `platform-bound` · `channel-bound` · `shared-secret` |
| **Boundary Enforcement** | `none` · `policy-based` · `cryptographic` · `hardware-enforced` |

#### Credential Type Reference

| Credential | Transference | Exportability | Platform Sync | Boundary Binding | Boundary Enforcement |
|---|---|---|---|---|---|
| Password | `freely-transferable` | `freely-exportable` | `management-dependent` | `shared-secret` | `none` / `policy-based` |
| TOTP | `constrained-transferable` | `freely-exportable` | `management-dependent` | `shared-secret` | `none` |
| SMS OTP | `constrained-transferable` | `non-exportable` (channel-inherent) | `no-sync` | `channel-bound` | `none` |
| Device-bound passkey | `non-transferable` | `non-exportable` | `no-sync` | `device-bound` | `hardware-enforced` |
| Synced passkey (consumer provider) | `freely-transferable` | `platform-exportable` | `ecosystem-sync` | `platform-bound` | `cryptographic` |
| Synced passkey (managed provider) | `constrained-transferable` | `platform-exportable` | `ecosystem-sync` | `platform-bound` | `cryptographic` |
| Identifying biometric | `non-transferable` | `non-exportable` | `no-sync` | `person-bound` | `cryptographic` |

---

## 6. Class 2: Credential Recovery

**Key question:** Who helps when things go wrong?

Recovery properties describe limitations on who can reset a credential or how a credential can be reset after loss, device failure, or compromise. Recovery is a security-significant property: the assurance of a recovered credential is bounded by the assurance of the recovery event itself. A high-assurance credential recovered via an email link is, at the moment of recovery, only as strong as that email link.

Some credentials should intentionally be non-recoverable — reestablishment from scratch via an administrative process (e.g., in-person identity verification) may be the correct design choice. The framework must represent both recoverable and non-recoverable credentials without implying either is a failure mode.

### 6.1 Recoverability

**Definition:** Can access to the credential be restored after loss without full re-enrollment from scratch?

#### Values

| Value | Description |
|---|---|
| `non-recoverable` | Loss of the credential requires complete re-enrollment; no recovery path exists |
| `automatically-recoverable` | Recovery is automatic by design; the credential restores itself via synchronization infrastructure without user action |
| `self-recoverable` | The credential holder can recover without assistance, using a previously established recovery artifact |
| `assisted-recoverable` | Recovery requires assistance from a designated party, enterprise administrator, or provider |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware security key (no backup) | `non-recoverable` | Key material generated on-device; loss of device = loss of credential |
| Synced passkey | `automatically-recoverable` | Credential restores on new device upon sign-in to sync account |
| Password manager (with backup) | `self-recoverable` | User recovers via backup codes or emergency kit |
| Enterprise SSO credential | `assisted-recoverable` | IT administrator resets; no self-service path |
| TOTP (seed backed up) | `self-recoverable` | User can re-import seed to new authenticator app |

### 6.2 Recovery Agent

**Definition:** Who or what entity can initiate and execute the recovery process?

#### Values

| Value | Description |
|---|---|
| `none` | No recovery agent; credential is non-recoverable |
| `holder-only` | Only the credential holder can recover, using artifacts they previously established |
| `provider` | The credential platform or service provider manages recovery |
| `enterprise-admin` | An authorized enterprise administrator can recover or reset the credential |
| `designated-third-party` | Recovery delegated to a named trusted party chosen by the holder |
| `external-authority` | Recovery controlled by an external party outside the holder's or enterprise's control (e.g., mobile carrier for SIM-based credentials) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware key (no backup) | `none` | Non-recoverable; no agent |
| Backup codes | `holder-only` | Only the holder has the codes |
| Synced passkey | `provider` | Apple/Google/Microsoft manages sync and recovery |
| Enterprise password reset | `enterprise-admin` | IT resets via directory service |
| SMS OTP | `external-authority` | SIM swap recovery is controlled by the mobile carrier, outside enterprise control |

### 6.3 Recovery Mechanism

**Definition:** What process or artifact enables recovery of the credential?

#### Values

| Value | Description |
|---|---|
| `none` | No recovery mechanism; non-recoverable |
| `automatic-sync` | Recovery via synchronization infrastructure; the credential restores automatically on sign-in to the sync account |
| `backup-artifact` | A pre-generated artifact (backup codes, emergency kit, seed export) enables recovery |
| `channel-verification` | Recovery authenticated via a communication channel (e.g., email link, SMS OTP) |
| `credential-authentication` | Recovery gated on authenticating with a separate credential |
| `in-person-verification` | Recovery requires physical presence and identity verification |
| `administrative-reset` | Recovery executed by a system administrator |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Synced passkey | `automatic-sync` | Restores via iCloud / Google account on new device |
| TOTP (backed up) | `backup-artifact` | Seed can be re-imported |
| Online account | `channel-verification` | "Forgot password" emails a reset link |
| PIV-gated credential | `credential-authentication` | Must present PIV to re-enroll |
| Government eID | `in-person-verification` | Must appear at issuing office |
| Enterprise SSO | `administrative-reset` | IT admin resets in directory |

### 6.4 Recovery Assurance

**Definition:** What is the assurance level of the identity verification performed during the recovery event itself?

This sub-property captures the security of the recovery *event*, not the security of the recovered credential. The recovery event establishes the new enrollment assurance floor.

#### Values (ordinal — higher = stronger recovery assurance)

| Value | Description |
|---|---|
| `none` | No identity verification at recovery; recovery is Trust on First Use (TOFU) |
| `low` | Recovery authenticated by a low-assurance mechanism (e.g., email link, SMS OTP) |
| `medium` | Recovery requires a second factor or multiple verification steps |
| `high` | Recovery requires high-assurance authentication (in-person verification, PIV/smart card) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password reset via email | `low` | Email link provides minimal assurance |
| Synced passkey recovery | `medium` | Requires sign-in to sync account (typically password + OTP) |
| Enterprise credential reset | `medium`–`high` | Varies by enterprise policy; often requires manager approval + identity check |
| Government-issued credential re-issuance | `high` | In-person identity verification required |

### 6.5 Class 2 Summary Table

| Sub-property | Values |
|---|---|
| **Recoverability** | `non-recoverable` · `automatically-recoverable` · `self-recoverable` · `assisted-recoverable` |
| **Recovery Agent** | `none` · `holder-only` · `provider` · `enterprise-admin` · `designated-third-party` · `external-authority` |
| **Recovery Mechanism** | `none` · `automatic-sync` · `backup-artifact` · `channel-verification` · `credential-authentication` · `in-person-verification` · `administrative-reset` |
| **Recovery Assurance** | `none` · `low` · `medium` · `high` |

#### Credential Type Reference

| Credential | Recoverability | Recovery Agent | Recovery Mechanism | Recovery Assurance |
|---|---|---|---|---|
| Hardware key (no backup) | `non-recoverable` | `none` | `none` | N/A |
| Synced passkey | `automatically-recoverable` | `provider` | `automatic-sync` | `medium` |
| Password + email reset | `assisted-recoverable` | `provider` | `channel-verification` | `low` |
| TOTP (seed backed up) | `self-recoverable` | `holder-only` | `backup-artifact` | `none` |
| SMS OTP | `assisted-recoverable` | `external-authority` | `channel-verification` | `low` |
| Enterprise SSO | `assisted-recoverable` | `enterprise-admin` | `administrative-reset` | `medium`–`high` |

---

## 7. Class 3: Credential Containment and Unlock

**Key question:** Does a secure element or TPM play a role?

Containment and unlock properties describe the mechanisms that protect credential material at rest and govern access to it. The *container* — not the enterprise — determines these properties. A hardware security key's containment is defined by the secure element in the device, not by the policy of the relying party that accepts it.

The unlock sub-properties are distinct from the containment sub-properties: containment describes what protects the credential; unlock describes what the user must do to access it. These interact: a poorly chosen unlock mechanism (e.g., a 4-digit PIN with no attempt limits) can undermine strong containment.

### 7.1 Containment Type

**Definition:** What mechanism protects the credential material at rest and prevents unauthorized extraction?

#### Values (loosely ordered by protection strength)

| Value | Description |
|---|---|
| `none` | No containment; credential exists in plaintext or minimally protected storage accessible to any process |
| `software-keystore` | OS-level key storage without hardware backing; protected by software access controls only |
| `sync-fabric` | Credential stored in a cloud-synchronized keychain (e.g., iCloud Keychain, Google Password Manager); protected by cloud account security |
| `platform-tpm` | Platform trusted platform module (TPM) with OS integration; hardware-backed but shared with the platform |
| `trusted-execution-environment` | TEE providing isolated execution environment separate from the main OS (e.g., ARM TrustZone) |
| `secure-element` | Dedicated hardware secure element (SE) with tamper resistance; keys generated and stored within the SE |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password in browser | `none` / `software-keystore` | Stored in browser profile or OS credential store; software-protected |
| Synced passkey | `sync-fabric` | Credential material held in cloud keychain; protection depends on account security |
| Windows Hello (software) | `software-keystore` | Software-backed credential |
| Windows Hello (TPM) | `platform-tpm` | Key backed by platform TPM |
| Hardware security key | `secure-element` | Key generated and held within SE; never leaves hardware |
| Apple Secure Enclave passkey | `trusted-execution-environment` | Key held in Secure Enclave; isolated from main OS |

### 7.2 Unlock Factor Type

**Definition:** What type of credential or action is required to access the contained credential for use?

#### Values

| Value | Description |
|---|---|
| `none` | No unlock required; credential is always accessible once containment is accessed |
| `knowledge` | Unlocked by a knowledge factor (PIN or password) |
| `biometric` | Unlocked by a biometric (fingerprint, face recognition) |
| `presence` | Unlocked by a presence signal (touch, tap); confirms physical access but does not authenticate identity |
| `external-credential` | Unlocked by presenting a separate credential (e.g., smart card PIN unlocks the card's private key) |
| `combined` | Multiple unlock factor types are required |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware security key (PIN-protected) | `knowledge` | PIN required to authorize each operation |
| Hardware security key (touch-only) | `presence` | Touch confirms physical presence; no identity assertion |
| Touch ID-protected passkey | `biometric` | Face or fingerprint required |
| Smart card | `external-credential` | PIN unlocks the card; PIN is itself a knowledge factor operating on a distinct containment |
| Windows Hello (face + PIN fallback) | `combined` | Face primary; PIN fallback |

### 7.3 Unlock Scope

**Definition:** What is the population of principals who can successfully unlock the credential?

This is an inherent property of the credential's containment configuration. A shared biometric enrollment is a property of the credential at setup time, not a deployment policy.

#### Values

| Value | Description |
|---|---|
| `sole-holder` | Only the enrolled individual's biometrics, PIN, or credentials unlock the credential |
| `shared` | Multiple principals can unlock (multiple biometrics enrolled; shared PIN known to multiple parties) |
| `enterprise-managed` | Unlock policy is controlled externally (e.g., device management policy controls PIN length and fallback options) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware key with owner PIN | `sole-holder` | Only the PIN holder can unlock |
| Family-shared iOS device passkey | `shared` | Multiple Face IDs enrolled; any enrolled face unlocks |
| MDM-managed Windows Hello | `enterprise-managed` | Enterprise policy defines acceptable unlock factors and requirements |

### 7.4 Unlock Persistence

**Definition:** How long does a successful unlock event grant access to the credential?

This captures the duration of access granted by a single unlock event, which determines how much exposure a single compromised unlock event creates.

#### Values (ordinal — lower = more secure)

| Value | Description |
|---|---|
| `per-operation` | Each use of the credential requires a fresh unlock event |
| `per-session` | Unlock persists for a user session; session boundaries defined by the platform |
| `time-limited` | Unlock persists for a defined time period |
| `persistent` | Once unlocked, the credential remains accessible indefinitely until explicitly locked |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Hardware key (touch-required per op) | `per-operation` | Touch required for each signing operation |
| Smart card (PIN cached in session) | `per-session` | PIN prompted once per card insertion |
| Software passkey (biometric cached) | `time-limited` | Platform may cache biometric approval for a period |
| Password stored in browser | `persistent` | Available to the browser until explicitly cleared |

### 7.5 Class 3 Summary Table

| Sub-property | Values |
|---|---|
| **Containment Type** | `none` · `software-keystore` · `sync-fabric` · `platform-tpm` · `trusted-execution-environment` · `secure-element` |
| **Unlock Factor Type** | `none` · `knowledge` · `biometric` · `presence` · `external-credential` · `combined` |
| **Unlock Scope** | `sole-holder` · `shared` · `enterprise-managed` |
| **Unlock Persistence** | `per-operation` · `per-session` · `time-limited` · `persistent` |

#### Credential Type Reference

| Credential | Containment Type | Unlock Factor Type | Unlock Scope | Unlock Persistence |
|---|---|---|---|---|
| Password in browser | `software-keystore` | `none` | `sole-holder` (typically) | `persistent` |
| TOTP app | `software-keystore` | `biometric` / `knowledge` | `sole-holder` / `shared` | `per-session` |
| Synced passkey | `sync-fabric` | `biometric` / `knowledge` | `sole-holder` / `shared` | `time-limited` |
| Hardware key (touch) | `secure-element` | `presence` | `shared` (physically) | `per-operation` |
| Hardware key (PIN+touch) | `secure-element` | `combined` | `sole-holder` | `per-operation` |
| Smart card | `secure-element` | `external-credential` | `sole-holder` | `per-session` |

---

## 8. Class 4: Credential Reuse

**Key question:** Can the same credential exist for two resources?

Reuse properties describe the degree to which a credential's value or output can be replayed, shared across services, or bound to a specific context. Reuse is a multi-dimensional property: a credential may be cross-site reusable but temporally single-use, or site-specific but persistent within that site.

### 8.1 Cross-Site Reuse

**Definition:** Can the same credential value or output be presented to multiple distinct verifiers?

#### Values (ordinal — lower = less reuse, stronger isolation)

| Value | Description |
|---|---|
| `prevented` | By cryptographic design the credential value cannot be presented to a different verifier; each verifier receives a verifier-specific credential |
| `constrained` | The credential can be used at a limited set of verifiers defined by design (e.g., sharing a trust anchor or PKI) |
| `unrestricted` | The same credential value can be presented to any verifier |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| WebAuthn / FIDO credential | `prevented` | Each RP receives a unique key pair (WebAuthn §7.1); the credential cannot authenticate to a different RP |
| Smart card (PKI) | `constrained` | Usable at any RP that trusts the issuing CA; bounded by PKI trust scope |
| Password | `unrestricted` | Same string authenticates at any verifier that accepts it |
| TOTP | `unrestricted` | Same OTP output is valid at any verifier that knows the seed |

### 8.2 Temporal Reuse

**Definition:** Can the same credential output be replayed within a time window?

This property captures whether a credential's output, once observed, can be used again. This is distinct from cross-site reuse: a single-use OTP cannot be replayed at the same verifier but may be usable at another if the seed is shared.

#### Values (ordinal — lower = less reuse)

| Value | Description |
|---|---|
| `single-use` | Each credential output is valid for one presentation only; replay is rejected |
| `time-limited` | The credential output is valid within a defined time window; defined by the credential type, not deployment configuration |
| `persistent` | The credential output is valid indefinitely until the credential is changed or revoked |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Look-up secret / backup code | `single-use` | Each code is consumed on use |
| TOTP | `time-limited` | Output changes every 30 seconds (RFC 6238 §5.2); same output invalid after window |
| WebAuthn assertion | `single-use` | Challenge-response; each assertion is unique and bound to a server-generated challenge |
| Password | `persistent` | Valid until changed |
| SMS OTP | `time-limited` | Validity window defined by delivery mechanism and issuer |

### 8.3 Scope Binding

**Definition:** Is the credential cryptographically or structurally bound to a specific verifier, service, or session?

Scope binding determines whether a credential that escapes its intended boundary retains any authentication value at an unintended verifier.

#### Values

| Value | Description |
|---|---|
| `unbound` | No binding to any specific verifier, service, or session; usable anywhere the credential value is accepted |
| `origin-bound` | Cryptographically bound to a specific origin (scheme + domain + port); the credential cannot authenticate to a different origin by design |
| `pki-scope-bound` | Usable at any verifier within the trust scope defined by the issuing PKI |
| `session-bound` | Bound to a specific session identifier; usable only within that session context |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password | `unbound` | No binding; works wherever accepted |
| WebAuthn credential | `origin-bound` | RP ID binding (WebAuthn §7.1) prevents use at a different origin |
| Smart card (PKI) | `pki-scope-bound` | Usable at any relying party that trusts the issuing CA |
| Session token | `session-bound` | Valid only for the session it was issued to |

### 8.4 Class 4 Summary Table

| Sub-property | Values |
|---|---|
| **Cross-Site Reuse** | `prevented` · `constrained` · `unrestricted` |
| **Temporal Reuse** | `single-use` · `time-limited` · `persistent` |
| **Scope Binding** | `unbound` · `origin-bound` · `pki-scope-bound` · `session-bound` |

#### Credential Type Reference

| Credential | Cross-Site Reuse | Temporal Reuse | Scope Binding |
|---|---|---|---|
| Password | `unrestricted` | `persistent` | `unbound` |
| TOTP | `unrestricted` | `time-limited` | `unbound` |
| Look-up secret | `unrestricted` | `single-use` | `unbound` |
| SMS OTP | `unrestricted` | `time-limited` | `unbound` |
| Smart card (PKI) | `constrained` | `persistent` | `pki-scope-bound` |
| WebAuthn / passkey | `prevented` | `single-use` | `origin-bound` |

---

## 9. Class 5: Credential Enrollment

**Key question:** What are the prerequisites to this credential existing?

Enrollment properties describe the conditions and requirements that governed a credential's creation. These are fixed at the time of enrollment and describe the assurance of the enrollment event, the prerequisites that were satisfied, and whether the credential's existence was gated on another credential.

### 9.1 Enrollment Assurance

**Definition:** What was the assurance level of the identity verification that occurred at enrollment time?

Enrollment assurance establishes the upper bound on how much trust can be placed in the binding between the credential and the identity it represents.

#### Values (ordinal — higher = stronger enrollment assurance)

| Value | Description |
|---|---|
| `none` | No identity verification at enrollment; credential created with no prior check (Trust on First Use) |
| `self-asserted` | Subject provided identity claims that were not independently verified |
| `remote-verified` | Identity verified remotely using trusted documentation, existing verified accounts, or binding to a previously verified identity |
| `in-person-verified` | Identity verified through physical presence and document inspection |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Consumer account sign-up | `none` / `self-asserted` | Email address unverified at sign-up; often TOFU |
| Email-verified passkey | `self-asserted` | Email address verified but not the identity behind it |
| Bank-issued credential (KYC) | `remote-verified` | Identity documents verified during account opening |
| Government eID | `in-person-verified` | Physical presence required at issuing authority |
| PIV / CAC | `in-person-verified` | Identity proofed in person per NIST SP 800-79 |

### 9.2 Enrollment Prerequisite

**Definition:** What condition must be satisfied before the credential can be enrolled?

#### Values

| Value | Description |
|---|---|
| `none` | No prerequisite; credential can be created without any prior condition (TOFU) |
| `account-existence` | A pre-existing account is required but no authentication is needed |
| `prior-authentication` | Successful authentication with an existing credential is required before enrollment |
| `ial-verified-identity` | A verified identity at a specific identity assurance level (IAL) is required |
| `administrative-authorization` | An administrator must explicitly authorize the enrollment event |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Consumer sign-up passkey | `none` | Created at first interaction |
| Second-device passkey | `prior-authentication` | Must authenticate with existing passkey before adding new device |
| PIV-derived mobile credential | `prior-authentication` + `ial-verified-identity` | PIV authentication required; identity already proofed |
| Enterprise hardware key | `administrative-authorization` | IT admin must provision before use |

### 9.3 Vouching

**Definition:** Was this credential's enrollment gated on successfully authenticating with a separate, pre-existing credential?

A **vouched credential** is one whose enrollment was enabled by the subject first authenticating with a separate, pre-existing credential. The prior credential does not contribute its key material to the new one — it acts as a gate on the enrollment event. After enrollment, the vouched credential is fully independent.

**Why not "derived"?** NIST SP 800-157 uses "derived PIV credential" to describe a credential cryptographically produced from PIV key material — a term with a specific technical meaning narrower than the general enrollment-gate concept. Using "derived" here creates ambiguity with that established definition.

**Why "vouched"?** The prior credential *vouches for* the legitimacy of the enrollment event. This is intuitive to laypeople, not technically loaded in any major authentication standard (OAuth, OIDC, FIDO, NIST 800-63), and suitable for precise definition in an IETF draft.

#### Values

| Value | Description |
|---|---|
| `not-vouched` | Enrollment was not gated on authenticating with a prior credential |
| `vouched` | Enrollment required prior successful authentication with a separate credential; the vouching credential type and assurance are additional attributes |

When `vouched`, two additional attributes apply:

| Attribute | Description |
|---|---|
| **Vouching credential class** | Knowledge / Possession / Inherence (factor type of the vouching credential) |
| **Vouching credential assurance** | The enrollment assurance level of the vouching credential (maps to §9.1 values) |

#### Examples by Credential Type

| Credential | Value | Vouching class | Vouching assurance |
|---|---|---|---|
| Consumer sign-up passkey | `not-vouched` | — | — |
| Second-device passkey (added via existing passkey) | `vouched` | Possession | remote-verified |
| PIV-gated mobile authenticator | `vouched` | Possession | in-person-verified |
| Enterprise key (provisioned via SSO) | `vouched` | Knowledge + Possession | remote-verified |

**IAL relationship:** The assurance level of the vouching credential establishes an upper bound on the enrollment assurance of the vouched credential. A credential vouched by a TOFU credential carries weaker enrollment assurance than one vouched by a hardware-bound cryptographic credential.

**Provenance relationship:** A vouched credential inherits none of the vouching credential's provenance properties. The vouching event establishes enrollment authorization only; the new credential's provenance is determined by its own issuer and construction.

### 9.4 Enrollment Binding

**Definition:** What mechanism binds the credential to the enrolling identity at enrollment time?

#### Values

| Value | Description |
|---|---|
| `none` | No binding; credential is not linked to a verified identity |
| `account-association` | Credential associated with an account record in a data store |
| `cryptographic-proof` | Enrollment includes cryptographic proof of key possession (e.g., signed registration request) |
| `attestation` | Credential is attested by a trusted third party at enrollment, cryptographically certifying its provenance and properties |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password | `account-association` | Stored as hash against account record |
| WebAuthn credential | `cryptographic-proof` | Registration response proves possession of private key |
| FIDO credential with attestation | `cryptographic-proof` + `attestation` | Key proof plus manufacturer attestation |
| PIV credential | `attestation` + `cryptographic-proof` | Certificate chain attests issuer; key proof at issuance |

### 9.5 Class 5 Summary Table

| Sub-property | Values |
|---|---|
| **Enrollment Assurance** | `none` · `self-asserted` · `remote-verified` · `in-person-verified` |
| **Enrollment Prerequisite** | `none` · `account-existence` · `prior-authentication` · `ial-verified-identity` · `administrative-authorization` |
| **Vouching** | `not-vouched` · `vouched` (+ vouching class and assurance attributes) |
| **Enrollment Binding** | `none` · `account-association` · `cryptographic-proof` · `attestation` |

#### Credential Type Reference

| Credential | Enrollment Assurance | Prerequisite | Vouching | Enrollment Binding |
|---|---|---|---|---|
| Consumer passkey (TOFU) | `none` | `none` | `not-vouched` | `account-association` |
| Second-device passkey | `remote-verified` (inherited) | `prior-authentication` | `vouched` | `cryptographic-proof` |
| FIDO2 key (with attestation) | `remote-verified` | `account-existence` | `not-vouched` | `cryptographic-proof` + `attestation` |
| PIV credential | `in-person-verified` | `ial-verified-identity` | `not-vouched` | `attestation` + `cryptographic-proof` |
| PIV-derived mobile credential | `in-person-verified` (bounded by PIV) | `prior-authentication` | `vouched` | `cryptographic-proof` |

---

## 10. Class 6: Credential Provider Provenance

**Key question:** Does trust in the authenticator or provider matter?

Provenance properties describe what is known about the entity that issued or generated the credential. Some use cases require verifying that a credential was produced by a specific class of provider meeting specific criteria. The mechanism by which provenance can be verified is itself a property of the credential type — it is inherent to how the credential was constructed, not to how the verifier is configured.

### 10.1 Provider Type

**Definition:** What category of entity issues or generates the credential?

#### Values

| Value | Description |
|---|---|
| `self` | Credential created by the user without a distinct provider (e.g., user-chosen password) |
| `platform` | Credential managed by the device operating system or platform (e.g., passkey managed by OS keychain) |
| `enterprise` | Credential issued by an employer or organizational entity |
| `third-party-service` | Credential issued or managed by an independent service provider (e.g., authenticator app, password manager) |
| `hardware-manufacturer` | Credential generated by a hardware device at manufacture or provisioning (e.g., hardware security key) |
| `government` | Credential issued by a government authority (e.g., PIV, national eID) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| User-created password | `self` | No external provider |
| iCloud Keychain passkey | `platform` | Apple manages the sync fabric and key operations |
| Enterprise SSO credential | `enterprise` | Issued and managed by employer |
| Google Authenticator TOTP | `third-party-service` | Third-party app manages TOTP generation |
| YubiKey | `hardware-manufacturer` | Key generated on Yubico hardware |
| PIV / CAC | `government` | Issued by US government |

### 10.2 Provenance Verifiability

**Definition:** Can the provider's identity and properties be independently verified at credential registration or use time?

#### Values (ordinal — higher = more verifiable)

| Value | Description |
|---|---|
| `not-verifiable` | No mechanism exists to verify the provider's identity or claimed properties |
| `self-attested` | Provider asserts its properties but cannot be independently verified |
| `third-party-certified` | Provider's properties verified by an independent certification body |
| `hardware-attested` | Provider's properties cryptographically attested by hardware at credential creation, verifiable via an attestation chain |
| `government-certified` | Provider certified by a government authority; certification verifiable via official registry |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password | `not-verifiable` | No attestation of provider properties |
| Third-party TOTP app | `self-attested` | App claims security properties; not independently verifiable |
| FIDO-certified authenticator (no attestation) | `third-party-certified` | FIDO Alliance certification verifiable in MDS |
| FIDO2 authenticator (with attestation) | `hardware-attested` | Attestation chain verifiable to hardware root at registration |
| PIV credential | `government-certified` | Certified under FIPS 201 and NIST SP 800-79 |

### 10.3 Certification Level

**Definition:** What formal certifications apply to the credential's provider or hardware?

Multiple values may apply simultaneously.

#### Values

| Value | Description |
|---|---|
| `none` | No formal certifications |
| `fido-l1` | FIDO Alliance Level 1 certification (software-based implementation) |
| `fido-l2` | FIDO Alliance Level 2 certification (hardware-protected key) |
| `fido-l3` | FIDO Alliance Level 3 certification (tamper-resistant hardware) |
| `fips-140-3` | FIPS 140-3 cryptographic module validation |
| `common-criteria` | Common Criteria evaluation |
| `government-issued` | Issued by or on behalf of a government authority under a recognized program |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Software TOTP | `none` | No formal certification |
| Consumer FIDO key | `fido-l1` / `fido-l2` | Varies by device |
| YubiKey 5 FIPS | `fido-l2` + `fips-140-3` | FIDO certified and FIPS validated |
| PIV smartcard | `fips-140-3` + `government-issued` | Per FIPS 201 requirements |

### 10.4 Class 6 Summary Table

| Sub-property | Values |
|---|---|
| **Provider Type** | `self` · `platform` · `enterprise` · `third-party-service` · `hardware-manufacturer` · `government` |
| **Provenance Verifiability** | `not-verifiable` · `self-attested` · `third-party-certified` · `hardware-attested` · `government-certified` |
| **Certification Level** | `none` · `fido-l1` · `fido-l2` · `fido-l3` · `fips-140-3` · `common-criteria` · `government-issued` |

#### Credential Type Reference

| Credential | Provider Type | Provenance Verifiability | Certification Level |
|---|---|---|---|
| User password | `self` | `not-verifiable` | `none` |
| Platform passkey (iOS) | `platform` | `hardware-attested` | `fido-l2` (Secure Enclave) |
| Third-party TOTP | `third-party-service` | `self-attested` | `none` |
| Hardware security key (FIDO) | `hardware-manufacturer` | `hardware-attested` | `fido-l2` (typical) |
| YubiKey FIPS | `hardware-manufacturer` | `hardware-attested` + `government-certified` | `fido-l2` + `fips-140-3` |
| PIV / CAC | `government` | `government-certified` | `fips-140-3` + `government-issued` |

---

## 11. Class 7: Credential Compliance

**Key question:** What rules govern the credential's composition or management?

Compliance properties describe requirements imposed by regulatory bodies, industry standards, or organizational mandates that govern how a credential must be constructed or managed. These requirements exist independent of their inherent security merit and may coexist with or supersede otherwise optimal security properties.

As the credential property language matures, its goal is to enable regulators to specify *properties* (e.g., phishing-resistant, hardware-bound, non-exportable) rather than *mechanisms* (e.g., "use two factors," "rotate passwords every 90 days"). Compliance properties exist in the framework to represent current regulatory reality while that transition occurs.

### 11.1 Composition Rules

**Definition:** Are there regulatory or standards-based requirements on how the credential must be constructed?

#### Values

| Value | Description |
|---|---|
| `none` | No composition requirements imposed by compliance |
| `minimum-length` | Minimum character or bit-length requirement |
| `character-complexity` | Character class requirements (uppercase, numeric, special characters) |
| `randomness-requirement` | Required entropy or generation method standard |
| `approved-algorithm` | Must use a specified cryptographic algorithm or algorithm family |

#### Examples

| Rule source | Value | Example |
|---|---|---|
| PCI DSS 4.0 §8.3.6 | `minimum-length` | Passwords must be ≥ 12 characters |
| Legacy NIST SP 800-63B (pre-rev4) | `character-complexity` | Uppercase + numeric + special character requirements |
| FIPS 140-3 | `randomness-requirement` + `approved-algorithm` | Cryptographic keys generated by approved RNG; approved algorithms only |

### 11.2 Lifecycle Rules

**Definition:** Are there regulatory or standards-based requirements on credential rotation, expiry, or revocation?

#### Values

| Value | Description |
|---|---|
| `none` | No lifecycle requirements imposed by compliance |
| `time-based-rotation` | Credential must be replaced on a defined schedule regardless of compromise |
| `event-based-rotation` | Credential must be replaced on specific triggering events (suspected compromise, role change) |
| `usage-limits` | Credential valid for a limited number of uses before replacement |
| `revocability-required` | Credential must support revocation within a defined time window |
| `maximum-lifetime` | Credential has a maximum valid lifetime after which it expires |

#### Examples

| Rule source | Value | Example |
|---|---|---|
| PCI DSS 3.x §8.2.4 | `time-based-rotation` | Passwords rotated every 90 days |
| NIST SP 800-63B-4 §3.2.7 | `event-based-rotation` | Change on evidence of compromise |
| FIPS 201 (PIV) | `maximum-lifetime` | PIV certificates have defined validity periods |

### 11.3 Regulatory Framework

**Definition:** Which regulatory framework(s) impose requirements on this credential type?

Multiple values may apply simultaneously.

#### Values

| Value | Description |
|---|---|
| `none` | No specific regulatory requirements |
| `pci-dss` | Payment Card Industry Data Security Standard |
| `hipaa` | Health Insurance Portability and Accountability Act |
| `nydfs-500` | NYDFS Cybersecurity Regulation (23 NYCRR 500) |
| `fedramp` | Federal Risk and Authorization Management Program |
| `fips-201` | FIPS 201 (Personal Identity Verification) |
| `eidas2` | EU eIDAS 2.0 / EUDI Wallet regulation |
| `custom` | Organization-specific requirements not mapped to a named framework |

### 11.4 Class 7 Summary Table

| Sub-property | Values |
|---|---|
| **Composition Rules** | `none` · `minimum-length` · `character-complexity` · `randomness-requirement` · `approved-algorithm` |
| **Lifecycle Rules** | `none` · `time-based-rotation` · `event-based-rotation` · `usage-limits` · `revocability-required` · `maximum-lifetime` |
| **Regulatory Framework** | `none` · `pci-dss` · `hipaa` · `nydfs-500` · `fedramp` · `fips-201` · `eidas2` · `custom` |

#### Credential Type Reference

| Credential | Composition Rules | Lifecycle Rules | Regulatory Framework |
|---|---|---|---|
| Consumer password (PCI scope) | `minimum-length` + `character-complexity` | `time-based-rotation` | `pci-dss` |
| FIPS cryptographic key | `randomness-requirement` + `approved-algorithm` | `maximum-lifetime` | `fedramp` / `fips-201` |
| Healthcare system password | `minimum-length` | `event-based-rotation` | `hipaa` |
| PIV credential | `randomness-requirement` + `approved-algorithm` | `maximum-lifetime` + `revocability-required` | `fips-201` |
| General consumer passkey | `none` | `none` | `none` |

---

## 12. Class 8: Credential Brute Force Resistance

**Key question:** How hard is it to discover this credential's value through systematic enumeration?

Brute force resistance describes the degree of effort required to discover a credential's value through systematic enumeration, based solely on the credential's inherent construction — its effective entropy, the size of its value space, and any structural constraints that reduce the practical search space below its theoretical maximum.

This class addresses properties fixed at construction time. Deployment-time controls (rate limiting, account lockout, hardware attempt enforcement) are out of scope — they reduce attack velocity but do not change where the credential's inherent resistance sits. For composite credentials (e.g., a passkey unlocked by a PIN), the effective resistance is the minimum across components; the credential chain is only as strong as its weakest link.

### 12.1 Resistance Level

**Definition:** The overall degree of effort required to exhaust the credential's effective value space through systematic enumeration. This is an ordinal scale.

#### Values

| Value | Definition |
|---|---|
| `none` | Trivially exhaustible; keyspace so small that enumeration requires negligible computational effort |
| `very-low` | Small keyspace or severe construction constraints make exhaustion straightforward with modest resources |
| `low` | Construction constraints significantly reduce effective entropy below the theoretical keyspace; exhaustion requires meaningful effort but is achievable |
| `moderate` | Sufficient entropy to require substantial effort; or an inherent validity window (e.g., TOTP per RFC 6238 §5.2) tightly constrains the attack window |
| `high` | Large, unconstrained keyspace requiring significant resources to exhaust; not feasible without substantial investment |
| `very-high` | Cryptographically strong; exhaustion is not feasible with current or foreseeable resources |
| `not-applicable` | Credential type is not subject to value-space enumeration; a different attack model applies (see §12.4) |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| 4-digit PIN | `none` | 10^4 = 10,000 values; exhaustible with negligible effort |
| User-chosen password | `very-low` – `low` | Effective entropy far below theoretical maximum; varies significantly by user behavior and composition policy |
| 6-digit TOTP | `moderate` | 10^6 value space; 30s validity window (RFC 6238 §5.2) constrains the attack to a narrow time window |
| SMS OTP (6-digit) | `moderate` | Same value space; delivery latency further constrains attack window |
| System-generated passphrase | `high` | Approaches theoretical keyspace; no user-choice construction constraints |
| Hardware-bound asymmetric key | `very-high` | Effective security strength ≥ 112 bits (SP 800-131A) |
| Synced passkey | `very-high` (key) / varies (unlock) | Asymmetric key is infeasible; effective resistance is the weaker of the key and the unlock credential |
| Biometric | `not-applicable` | Enumeration is not the applicable attack model; see §12.4 |

### 12.2 Effective Keyspace

**Definition:** The practical number of distinct values an attacker must search to exhaust the credential's value space, accounting for all construction constraints. The effective keyspace may be substantially smaller than the theoretical maximum when construction rules, user behavior patterns, or format requirements reduce it.

#### Values

| Value | Description |
|---|---|
| `trivial` | Fewer than 10^5 distinct values (e.g., 4-digit PIN: 10^4) |
| `small` | 10^5 to 10^8 values (e.g., 6-digit OTP: 10^6; 8-character alphanumeric: ~2×10^14 theoretical but far less in practice) |
| `large` | 10^8 to 2^80 values, unconstrained; exhaustion requires significant resources |
| `cryptographic` | ≥ 2^112 values (SP 800-131A minimum security strength); computationally infeasible |
| `not-applicable` | No discrete enumerable value space exists for this credential type |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| 4-digit PIN | `trivial` | 10,000 possible values |
| 6-digit TOTP | `small` | 1,000,000 values; further constrained by time window |
| User-chosen password (8+ chars, common policies) | `small` | User choice biases, common words, and predictable substitutions shrink effective keyspace well below theoretical maximum |
| System-generated random passphrase (4+ words) | `large` | ~10^20 values with standard wordlists; no construction constraints |
| Asymmetric private key (RSA-2048, P-256) | `cryptographic` | Security strength ≥ 112 bits (SP 800-131A) |
| Biometric | `not-applicable` | No enumerable discrete value space |

### 12.3 Construction Constraints

**Definition:** Structural patterns or rules inherent to the credential type that reduce the effective keyspace below its theoretical maximum. These constraints are fixed by the credential's design, not by any particular deployment.

#### Values

| Value | Description |
|---|---|
| `none` | No constraints; credential values are drawn uniformly from the full theoretical keyspace |
| `format-constrained` | Structure or format requirements (e.g., digit-only, fixed length) reduce the space but values are otherwise random |
| `user-choice-biased` | Values are chosen by humans and exhibit predictable patterns (common words, keyboard walks, names, dates) that make effective entropy far lower than theoretical |
| `dictionary-vulnerable` | Values are drawn from or strongly correlated with a finite, known set (e.g., natural language words, common passwords) |
| `not-applicable` | Credential type has no enumerable value space to which construction constraints apply |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| TOTP output | `format-constrained` | Fixed 6-digit decimal; values are uniform within the space |
| User-chosen password | `user-choice-biased` | Human selection strongly skews toward predictable patterns |
| Security questions / KBA | `dictionary-vulnerable` | Answers drawn from a small real-world space (mother's maiden name, city of birth) |
| System-generated random token | `none` | Drawn uniformly from the full keyspace by a cryptographic random number generator |
| Asymmetric key pair | `none` | Generated uniformly at cryptographic strength; no construction constraints |
| Biometric | `not-applicable` | No enumerable value space |

### 12.4 Temporal Validity

**Definition:** Whether the credential's validity is bounded by an inherent time window that limits the effective attack duration. A shorter inherent validity window means an attacker must succeed within that window or the credential expires. This is an inherent property of the credential type, not a deployment-time expiry policy.

#### Values

| Value | Description |
|---|---|
| `unbounded` | No inherent time limit; a captured or guessed credential remains valid until explicitly revoked or rotated |
| `session-bounded` | Valid only within a session established at issuance; expires when the session ends |
| `short-lived` | Has a fixed, short validity window inherent to its construction (e.g., TOTP: 30s per RFC 6238 §5.2; SMS OTP: delivery latency constrains attack window) |
| `single-use` | Valid for exactly one use; any attempt consumes the credential (e.g., look-up secrets) |
| `not-applicable` | Temporal validity is not a meaningful property for this credential type |

#### Examples by Credential Type

| Credential | Value | Rationale |
|---|---|---|
| Password | `unbounded` | Valid until rotated or revoked; no inherent expiry |
| TOTP output | `short-lived` | 30s window per RFC 6238 §5.2 (with implementation tolerance for clock skew) |
| SMS OTP | `short-lived` | Delivery latency and sender-side expiry constrain the window; inherent to the delivery mechanism |
| Look-up secret | `single-use` | Each code is consumed on use; subsequent attempts require a different code |
| Hardware-bound asymmetric key | `unbounded` | The key itself does not expire; credential lifetime is a management property (Class 7) |
| Biometric | `not-applicable` | No temporal validity applies to the biometric template |

### 12.5 Note on Biometrics and Presentation Attack Resistance

Biometrics are assigned `not-applicable` on enumeration-based sub-properties because systematic value-space exhaustion is not the relevant attack model. The applicable attack model for biometrics is **presentation attack** — submitting an artifact (photograph, silicone fingerprint, 3D model) that impersonates the enrolled subject.

Presentation attack resistance (PAR) is a distinct property not captured by this class. It is characterized by the false match rate (FMR) — which SHALL be ≤ 1 in 10,000 per NIST SP 800-63B-4 §3.2.3.1 — and liveness detection capability. A parallel property definition for presentation attack resistance is deferred to future work.

---

### Class 8 Summary

**Sub-properties and values:**

| Sub-property | Values |
|---|---|
| **Resistance Level** | `none` · `very-low` · `low` · `moderate` · `high` · `very-high` · `not-applicable` |
| **Effective Keyspace** | `trivial` · `small` · `large` · `cryptographic` · `not-applicable` |
| **Construction Constraints** | `none` · `format-constrained` · `user-choice-biased` · `dictionary-vulnerable` · `not-applicable` |
| **Temporal Validity** | `unbounded` · `session-bounded` · `short-lived` · `single-use` · `not-applicable` |

**Credential type reference:**

| Credential | Resistance Level | Effective Keyspace | Construction Constraints | Temporal Validity |
|---|---|---|---|---|
| 4-digit PIN | `none` | `trivial` | `format-constrained` | `unbounded` |
| User-chosen password | `very-low` – `low` | `small` | `user-choice-biased` | `unbounded` |
| 6-digit TOTP | `moderate` | `small` | `format-constrained` | `short-lived` |
| SMS OTP | `moderate` | `small` | `format-constrained` | `short-lived` |
| Look-up secret | `moderate` | `small` | `format-constrained` | `single-use` |
| System-generated passphrase | `high` | `large` | `none` | `unbounded` |
| Hardware-bound asymmetric key | `very-high` | `cryptographic` | `none` | `unbounded` |
| Synced passkey | `very-high` (key) / varies (unlock) | `cryptographic` (key) / varies (unlock) | `none` (key) / varies (unlock) | `unbounded` |
| Biometric | `not-applicable` | `not-applicable` | `not-applicable` | `not-applicable` |

---

## 13. Terminology

| Term | Definition |
|---|---|
| **Credential** | A value or mechanism used to authenticate a subject |
| **Class** | A top-level area of scrutiny in the credential management security property hierarchy |
| **Sub-property** | A named property within a class that captures a specific, security-relevant distinction |
| **Value** | A discrete state a sub-property can take |
| **Inherent property** | A property fixed by the credential's construction and type; independent of verifier configuration or deployment policy |
| **Contextual property** | A property determined by deployment or management decisions; out of scope for this framework |
| **Vouched credential** | A credential whose enrollment was gated on the subject first successfully authenticating with a separate, pre-existing credential |
| **Establishment factor** | A factor used to establish a session or identity |
| **Confirmation factor** | A factor used to confirm a previously established session; cannot independently establish identity |
| **Effective keyspace** | The practical set of distinct values an attacker must enumerate, accounting for construction constraints |
| **Brute force resistance** | The degree of effort required to discover a credential's value through systematic enumeration, based on inherent construction only |
| **Enrollment assurance** | The assurance level of the identity verification that occurred when a credential was created |

---

## 14. Sources

| Source | Description |
|---|---|
| Saxe / Dingle, Identiverse (https://www.youtube.com/watch?v=_McEdUKZKL0) | Foundational presentation; core thesis, eight classes, boundary sub-properties |
| Dingle, Authenticate 2024 (slides 16–19) | Canonical factor taxonomy (RFC 8176 basis), boundary definitions, boundary properties in use matrix |
| `draft-dingle-sec-credproperties` (Dingle + Saxe) | IETF draft; eight class definitions, scope statement |
| NIST SP 800-63B-4 (July 2025) | AAL definitions; authenticator type properties; motivating example of coarse ordinal assurance model |
| NIST SP 800-63-4 (August 2025) | IAL / AAL / FAL disaggregation [§3.3] |
| NIST SP 800-157 | "Derived PIV credential" — term that "vouched credential" deliberately avoids |
| NIST SP 800-79 | PIV in-person identity proofing requirements |
| RFC 8176 (Jones et al., June 2017) | Authentication Method Reference (AMR) values; basis for factor type taxonomy and codes |
| RFC 6238 (TOTP) | TOTP validity window (§5.2); informative for temporal validity classification |
| RFC 4226 (HOTP) | HMAC-based OTP; basis for TOTP |
| SP 800-131A | 112-bit minimum security strength; basis for `very-high` brute force resistance classification |
| WebAuthn Level 2 (W3C) | Origin binding (§7.1); basis for `origin-bound` scope binding and `cryptographic` boundary enforcement |
| FIPS 201-3 | PIV credential requirements |
| FIPS 140-3 | Cryptographic module validation standard |
