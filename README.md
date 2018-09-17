<p align="center" background="black"><img src="minter-logo.svg" width="400"></p>
<p align="center">
<a href="https://github.com/MinterTeam/minter-ios-my/releases/latest"><img src="https://img.shields.io/github/tag/MinterTeam/minter-ios-my.svg" alt="Version"></a>
<a href="https://travis-ci.org/MinterTeam/minter-ios-my"><img src="http://img.shields.io/travis/MinterTeam/minter-ios-my.svg?style=flat" alt="CI Status"></a> 
<a href="http://cocoapods.org/pods/MinterMy"><img src="https://img.shields.io/cocoapods/v/MinterMy.svg?style=flat" alt="Version"></a>
<a href="http://cocoapods.org/pods/MinterMy"><img src="https://img.shields.io/cocoapods/p/MinterMy.svg?style=flat" alt="Platform"></a>
<a href="https://github.com/MinterTeam/minter-ios-my/blob/master/LICENSE"><img src="https://img.shields.io/github/license/MinterTeam/minter-ios-my.svg" alt="License"></a>
<a href="https://github.com/MinterTeam/minter-ios-my/commits/master"><img src="https://img.shields.io/github/last-commit/MinterTeam/minter-ios-my.svg" alt="Last commit"></a>
</p>


# MinterMy

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MinterMy is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MinterMy'
```

## How-to

**Check if username taken**
```swift
/// Initialize HTTP client
let httpClient = APIClient.shared
/// Initialize manager
let authManager = AuthManager(httpClient: httpClient)

authManager.isTaken(username: "ody344", completion: { [weak self] (respoonse, error) in
  print(respoonse)
  print(error)
})
```

**Login user**
```swift
import CryptoSwift

let username = "ody344"
let rawUserPassword = "123456"
let accounPassword = AuthManager.authPassword(from: rawUserPassword) 
authManager.login(username: username, password: accounPassword) { [weak self] (accessToken, refreshToken, user, error) in
  print(accessToken)
  print(refreshToken)
  print(user)
  print(error)
}
```

**Register user**
```swift
import CryptoSwift

func encryptedMnemonic(mnemonic: String, password: Data) -> Data? {
  let aes = try AES(key: password.bytes, blockMode: CBC(iv: self.iv!.bytes))
  let ciphertext = try aes.encrypt(Array(mnemonic.utf8))

  guard ciphertext.count > 0 else {
    assert(true)
		return nil
  }
	return Data(bytes: ciphertext)
}

let mnemonic = "size holiday develop vibrant chicken renew dad excess acid where ugly license"
let username = "ody344"
let rawUserPassword = "123456"
let accounPassword = AuthManager.authPassword(from: rawUserPassword)

let email = "email@&gmail.com"
let address = "Mx5g57b689ec01k09r26436f3o08e3eb5c08bfarp5"
let account = Account(id: id, encryptedBy: .me, address: address)

let encryptionKey: Data? = rawUserPassword.bytes.sha256()
let encrypted = encryptedMnemonic(mnemonic: mnemonic, password: encryptionKey!)

authManager.register(username: username, password: accountPassword, email: email, phone: nil, account: account, encrypted: encrypted) { [weak self] (isRegistered, error) in
  print(isRegistered)
  print(error)
}
```
**User info by address**
```swift
let addresses = ["Mx5g57b689ec01k09r26436f3o08e3eb5c08bfarp5"]
infoManager.info(by: addresses, completion: { (response, error) in
  print(response)
  print(error)
}
```
**Address info by email or username**
```swift
infoManager.address(email: "email&@gmail.com") { [weak self] (address, user, error) in
  print(address)
  print(user)
  print(error)
}
```
**Get user profile**
```swift
let accessToken = "Your access token"
let client = APIClient(headers: ["Authorization" : "Bearer " + accessToken])
let profileManager = ProfileManager(httpClient: client)

profileManager.profile(completion: { [weak self] (user, error) in
  print(user)
  print(error)
})
```
**Update user profile**
```swift
let accessToken = "Your access token"
let client = APIClient(headers: ["Authorization" : "Bearer " + accessToken])
let profileManager = ProfileManager(httpClient: client)

let user = User()
user.username = "newUsername"

profileManager.updateProfile(user: user, completion: { [weak self] (updated, error) in
  print(updated)
  print(error)
})
```
**Update user avatar**
```swift
let accessToken = "Your access token"
let client = APIClient(headers: ["Authorization" : "Bearer " + accessToken])
let profileManager = ProfileManager(httpClient: client)

let base64 = "base64ImageString"

profileManager.uploadAvatar(imageBase64: base64, completion: { (succeed, url, error) in
  print(succeed)
  print(url)
  print(error)
})
```
**Delete user avatar**
```swift
profileManager?.deleteAvatar(with: { (error) in
  print(error)
})
```


## Author

sidorov.panda, ody344@gmail.com

## License

MinterMy is available under the MIT license. See the LICENSE file for more info.
