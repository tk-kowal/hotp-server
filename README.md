# HOTP Workshop [Server]
-----------------------------------

## About

This server was built to be used as part of a workshop on the HOTP algorithm defined in [RFC 4226](https://tools.ietf.org/html/rfc4226).

Given everything in the [HOTP-workshop-client](https://github.com/tk-kowal/hotp-workshop-client) repository, participants are tasked with implementing the algorithm so that they can authenticate with this server and get the secret word.

Authentication in this case is just a simple `if` statement in the `/auth` endpoint - in no way meant to serve as an example of how any sort of authentication should be implemented.

The server expects three pieces of information in the `POST` to `/auth`

```
{
  "user": "admin",
  "pass": "pass",
  "otp": "123456"
}
```
where `"123456"` is the current valid one time password.
