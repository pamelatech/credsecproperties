---
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

Every credential used to identify, authenticate, or otherwise validate a subject is different, and yet there is no specific vocabulary that describes exacty what a given credential should be expected to do, or why exactly it can be called "secure".  To address this shortcoming, this document describes categories of secure credential management and within defines exact labels to describe the intended operation of a given credential.  These labels are intended for colloquial use and designed whenever possible to be accessible and intuitive for laypeople. The specification is scoped only to a credential in its common and expected use; properties for secure administration of credentials are not part of this set. 


# Conventions and Definitions

{::boilerplate bcp14-tagged}


# Security Considerations

TODO Security


# IANA Considerations

This document has no IANA actions.


--- back

# Acknowledgments
{:numbered="false"}

TODO acknowledge.
