//
//  ProfileManagerTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class ProfileManagerTestsSpec: QuickSpec {
	
	
	let http = APIClient()
	var manager: ProfileManager!
	
	override func spec() {
		
		describe("ProfileManagerTestsSpec") {
			
			it("ProfileManager can be initialized") {
				let manager = ProfileManager(httpClient: self.http)
				expect(manager).toNot(beNil())
			}
			
			it("ProfileManager can't remove avatar with no credentials") {
				self.manager = ProfileManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.deleteAvatar(with: { (error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("ProfileManager can't upload avatar with no credentials") {
				self.manager = ProfileManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.uploadAvatar(imageBase64: "something".data(using: .utf8)!.base64EncodedString(), completion: { (res, url, error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("ProfileManager can't get profile with no credentials") {
				self.manager = ProfileManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.profile(completion: { (user, error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("ProfileManager can't update profile with no credentials") {
				self.manager = ProfileManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				let user = User()
				
				waitUntil(timeout: 10.0) { done in
					self.manager.updateProfile(user: user, completion: { (res, error) in
						expect(error).toNot(beNil())
						
						done()
					})
				}
			}
			
		}
	}
}
