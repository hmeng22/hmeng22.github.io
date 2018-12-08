---
title: "Auth"
date: 2017-07-27T18:14:42-04:00
draft: false
---

# Authentication & Authorization

Authorization First, return a token object if the credentials are valid.

Authentication is handled by passing a token to the user after successful login, which will be sent to the server with every request from then. As soon as a user makes a call to one of our API endpoints, we redirect the request to the authentication middleware. This middleware is responsible for authenticating the client by first processing the token. If the token is not present/invalid or expired, it will throw a 401 HTTP status code. If the request has a valid token and is not yet expired, we will invoke the next middleware in the stack.

## JSON Web Token (JWT)

JSON Web Token is an authentication protocol. It is a strict set of instructions for issuing and validation of signed access tokens. The tokens limit the access to APIs.

The token is base64url encoded contains header.payload.signature

```
Header
{
  "alg" : "SHA256",
  "typ" : "JWT"
}

Payload
{
  "data" : data
}

Signature
The signature is generated using a private key to hash the Header and Payload.
```

jwt-simple will demonstrate how to encode & decode JWT.
jsonwebtoken is a popular implementation.

```
Sign Up, Sign In
    passport, passport Local

Token
    jsonwebtoken : sign(encode) & verify(decode)
    passport-jwt : passport strategy validates JSONWebTokens. (decode)

Token & Middleware
    express-jwt : middleware validates JSONWebTokens and sets req.user. (decode)
```

Pros:

- The server side storage issues are gone
- The client side code is easy

Cons:

- The JWT size could be larger. It could affect network performance since it is included with each HTTP request
- The data stored in the JWT is readable by the clint, might be an issue
  - It needs a revocation list to revoke a JWT before it expires.



## OAuth2

OAuth2 has detailed guideline for letting users and applications authorize specific permissions to other applications in both private and public setting.

Identity delegation allows a resource provider (such as Facebook) to be informed of the face that a resource owner (a particular user in Facebook) allows a third-party (some other applications) to access and/or change the data belonging to the resource owner that is stored with the resource provider (such as allowing the third-party applicaiton to update the user's Facebook status).

```
Bearer Token : /[A-Za-z0-9\-\._~\+\/]+=*/

1. Header
Authorization: Bearer token

2. Request Body
Content-Type: application/x-www-form-urlencoded

access_token = token

3. URI
../api/v1?access_token=token

OAuth 2.0 的 access token
{
  "access_token":"token",
  "token_type":"Bearer",
  "expires_in":3600,
  "refresh_token":"token2"
}
```

## Openssl private.key

```
$ openssl genrsa -out secret.key 4096
```
