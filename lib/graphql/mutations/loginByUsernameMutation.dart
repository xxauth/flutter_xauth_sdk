const String loginByUsernameMutation = r'''
mutation loginByUsername($input: LoginByUsernameInput!) {
  loginByUsername(input: $input) {
    id
    arn
    userPoolId
    username
    email
    emailVerified
    phone
    phoneVerified
    unionid
    openid
    identities {
      openid
      userIdInIdp
      userId
      connectionId
      isSocial
      provider
      userPoolId
    }
    nickname
    registerSource
    photo
    password
    oauth
    token
    tokenExpiredAt
    loginsCount
    lastLogin
    lastIP
    signedUp
    blocked
    isDeleted
    device
    browser
    company
    name
    givenName
    familyName
    middleName
    profile
    preferredUsername
    website
    gender
    birthdate
    zoneinfo
    locale
    address
    formatted
    streetAddress
    locality
    region
    postalCode
    country
    createdAt
    updatedAt
    customData
  }
}
''';