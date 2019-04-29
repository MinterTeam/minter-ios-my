//
//  InfoManagerTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class InfoManagerTestsSpec: QuickSpec {
	
	
	let http = APIClient()
	var manager: InfoManager!
	
	override func spec() {
		
		describe("InfoManagerTestsSpec") {
			
			it("InfoManager can be initialized") {
				let manager = InfoManager(httpClient: self.http)
				expect(manager).toNot(beNil())
			}
			
			it("Can retreive info") {
				self.manager = InfoManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.address(completion: { (res, user, error) in
						expect(error).toNot(beNil())
						done()
					})
				}
			}
			
			it("Can retreive info") {
				self.manager = InfoManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.address(username: "ody344", email: nil, completion: { (res, user, error) in
						expect(error).to(beNil())
						expect(res).toNot(beNil())
						expect(user).toNot(beNil())
						
						done()
					})
				}
			}
			
			it("Can retreive info") {
				self.manager = InfoManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.info(by: ["Mx184ac726059e43643e67290666f7b3195093f870"], completion: { (res, error) in
						expect(error).to(beNil())
						expect(res).toNot(beNil())
						
						done()
					})
				}
			}
			
		}
	}
}
