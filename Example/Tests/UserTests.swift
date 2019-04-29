//
//  UserTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
import ObjectMapper
@testable import MinterMy


class UsersTestsSpec: QuickSpec {
	
	
	override func spec() {
		
		describe("UsersTestsSpec") {
			
			it("Users can be initialized") {
				
				let json = "{\"id\":1,\"username\":\"username\",\"name\":\"name\",\"email\":\"email@email.com\",\"language\":\"en\"}"
				let user = Mapper<UserMappable>().map(JSONString: json)
				
				expect(user).toNot(beNil())
				expect(user?.id).to(equal(1))
				expect(user?.username).to(equal("username"))
				expect(user?.name).to(equal("name"))
				expect(user?.email).to(equal("email@email.com"))
				expect(user?.language).to(equal("en"))
			}
		}
	}
}
