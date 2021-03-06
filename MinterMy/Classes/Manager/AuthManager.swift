//
//  AuthManager.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 20/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation
import MinterCore
import ObjectMapper

/// AuthManager
public class AuthManager : BaseManager {
	
	
	/**
	Method checks if the username is taken
	- SeeAlso: https://my.beta.minter.network/help/index.html
	- Parameters:
	- username: username should satisfy the following regexp "^[a-zA-Z0-9_]{5,16}"
	- completion: Method which will be called after request finishes
	*/
	public func isTaken(username: String, completion: ((Bool?, Error?) -> ())?) {
		let url = MinterMyAPIURL.username(username: username).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var res: Bool = true
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let result = response.data as? [String : Any] {
				res = !((result["is_available"] as? Bool) ?? false)
				return
			}
		}
	}
	
	public enum AuthManagerRegisterError : Error {
		case custom(code: Int?, message: String?)
	}
	
	/**
	Method checks if the username is taken
	- SeeAlso: https://my.beta.minter.network/help/index.html
	- Parameters:
	- username: username should satisfy the following regexp "^[a-zA-Z0-9_]{5,16}"
	- password: password should be longer or equal 6 symbols
	- email: optional
	- phone: optional
	- account: Account model
	- encrypted: encrypted mnemonic to be saved on the MyMinter server (used to sync between wallets)
	- completion: Method which will be called after request finishes
	*/
	public func register(username: String, password: String, email: String = "", phone: String = "", account: Account, encrypted: String? = "", completion: ((Bool?, AuthManagerRegisterError?) -> ())?) {
		let url = MinterMyAPIURL.register.url()
		
		let mainAddress : [String : Any] = ["address" : "Mx" + account.address, "isMain" : true, "isServerSecured" : true, "encrypted" : encrypted ?? ""]
		var params: [String : Any] = ["username" : username, "password" : password, "mainAddress" : mainAddress]
		
//		if phone != "" {
//			params["phone"] = phone
//		}
		
		if email != "" {
			params["email"] = email
		}
		
		self.httpClient.postRequest(url, parameters: params) { (response, error) in
			
			var res: Bool?
			var err: AuthManagerRegisterError?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				
				if let error = error as? HTTPClientError {
					var code = -1
					if let aCode = error.userData?["code"] as? Int {
						code = aCode
					}
					var errorMessage = ""
					if let anErrorMessage = error.userData?["message"] as? String {
						errorMessage = anErrorMessage
					}
					err = AuthManagerRegisterError.custom(code: code, message: errorMessage)
				}
				else {
					err = AuthManagerRegisterError.custom(code: -1, message: nil)
				}
				return
			}
		}
	}
	
	public enum AuthManagerLoginError : Error {
		case custom(code: Int?, message: String?)
		case invalidCredentials
	}
	
	/**
	Method logs in to MyMinter
	- SeeAlso: https://my.beta.minter.network/help/index.html
	- Parameters:
	- username: username should satisfy the following regexp "^[a-zA-Z0-9_]{5,16}"
	- password: password should be longer or equal 6 symbols
	- completion: Method which will be called after request finishes
	*/
	public func login(username: String, password: String, completion: ((String?, String?, User?, AuthManagerLoginError?) -> ())?) {
		
		let url = MinterMyAPIURL.login.url()
		
		self.httpClient.postRequest(url, parameters: ["username" : username, "password" : password]) { (response, error) in
			
			var accessToken: String?
			var refreshToken: String?
			var user: User?
			var err: AuthManagerLoginError?
			
			defer {
				completion?(accessToken, refreshToken, user, err)
			}
			
			guard error == nil,
				let data = response.data as? [String : Any],
				let tokenPayload = data["token"] as? [String : Any],
				let userPayload = data["user"] as? [String : Any] else {
					
					//TODO: change after server fix
					if let error = error as? HTTPClientError {
						var code = -1
						if let aCode = error.userData?["code"] as? Int {
							code = aCode
						}
						var errorMessage = ""
						if let anErrorMessage = error.userData?["message"] as? String {
							errorMessage = anErrorMessage
						}
						err = AuthManagerLoginError.custom(code: code, message: errorMessage)
					}
					else {
						err = AuthManagerLoginError.custom(code: -1, message: nil)
					}
					return
			}
			
			if let token = tokenPayload["accessToken"] as? String {
				accessToken = token
			}
			if let refresh = tokenPayload["refreshToken"] as? String {
				refreshToken = refresh
			}
			
			user = Mapper<UserMappable>().map(JSON: userPayload)
			
		}
	}
	
	/**
	Method changes password to MyMinter
	- SeeAlso: https://my.beta.minter.network/help/index.html
	- Parameters:
	- newPassword: new password to be saved to MyMinter
	- encryptedMnemonics: re-encrypted mnemonics
	- completion: Method which will be called after request finishes
	*/
	public func changePassword(oldEncryptedMnemoics: [(id: Int, mnemonic: String)], encryptionKey: Data, newPassword: String, completion: ((Bool?, Error?) -> ())?) throws {
		
		enum ChangePasswordError : Error {
			case encryptionError
			case noMnemonics
		}
		
		let mnemonicHelper = MnemonicHelper()
		
		let url = MinterMyAPIURL.password.url()
		
		let originalMnemonics = oldEncryptedMnemoics.map { (val) -> (id: Int, mnemonic: String)? in
			
			let data = Data(hex: val.mnemonic)
			
			let decrypted = mnemonicHelper.decryptMnemonic(encrypted: data, password: encryptionKey)
			
			guard decrypted != nil else {
				return nil
			}
			
			return (id: val.id, mnemonic: decrypted!)
		}.filter { (val) -> Bool in
			return val != nil
		} as! [(id: Int, mnemonic: String)]
		
		let newEncryptionKey = newPassword.bytes.sha256()
		
		let newMnemonics = try? originalMnemonics.map { (val) -> (id: Int, mnemonic: String) in
			
			var encrypted: Data?
			do {
				encrypted = try mnemonicHelper.encryptedMnemonic(mnemonic: val.mnemonic, password: Data(bytes: newEncryptionKey))
			}
			catch {
				throw ChangePasswordError.encryptionError
			}
			
			guard encrypted != nil else {
				throw ChangePasswordError.encryptionError
			}
			
			return (id: val.id, mnemonic: encrypted!.toHexString())
		}
		
		guard let encrypterMnemonicsParam = newMnemonics?.map({ (val) -> [String : Any] in
			return ["id" : val.id, "encrypted": val.mnemonic]
		}) else {
			throw ChangePasswordError.noMnemonics
		}
		
		self.httpClient.postRequest(url, parameters: ["newPassword" : AuthManager.authPassword(from: newPassword), "addressesEncryptedData" : encrypterMnemonicsParam]) { (response, error) in

			var res = false
			var err: Error?

			defer {
				completion?(res, err)
			}

			guard error == nil else {
				err = error
				return
			}

			res = true
		}
	}
	
	/// Method generates raw MyMinter password
	public class func authPassword(from: String) -> String {
		return from.sha256().sha256()
	}

}
