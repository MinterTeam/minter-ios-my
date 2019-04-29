//
//  AuthManagerTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class AuthManagerTestsSpec: QuickSpec {
	
	let username = "testuser1"
	let password = "49dc52e6bf2abe5ef6e2bb5b0f1ee2d765b922ae6cc8b95d39dc06c21c848f8c"
	
	
	let http = APIClient()
	var manager: AuthManager! = AuthManager.default
	
	override func spec() {
		
		describe("AuthManagerTestsSpec") {
			
			it("AuthManager can be initialized") {
				let manager = AuthManager(httpClient: self.http)
				expect(manager).toNot(beNil())
			}
			
			it("AuthManager can't auth with wrong login/password") {
				self.manager = AuthManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.login(username: "wrong", password: "credentials", completion: { (res1, res2, user, error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("AuthManager can't register with incorrect data") {
				self.manager = AuthManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				let acc = Account(id: 1, encryptedBy: .me, address: "")
				
				waitUntil(timeout: 10.0) { done in
					self.manager.register(username: "-", password: "", email: "", phone: "", account: acc, completion: { (res, error) in
						expect(error).toNot(beNil())
						expect(res).to(beNil())
						
						done()
					})
				}
				
			}
			
			it("AuthManager can't change password without credentials") {
				self.manager = AuthManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					try? self.manager.changePassword(oldEncryptedMnemoics: [], encryptionKey: "data".data(using: .utf8)!, newPassword: "123", completion: { (res, error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("AuthManager can auth with login/password") {
				self.manager = AuthManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.login(username: self.username, password: self.password, completion: { (res1, res2, user, error) in
						expect(error).to(beNil())
						
						expect(res1).toNot(beNil())
						expect(res2).toNot(beNil())
						expect(user).toNot(beNil())
						
						done()
					})
				}
			}
			
		}
	}
}
