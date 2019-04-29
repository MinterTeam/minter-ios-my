//
//  AddressTests.swift
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


class AddressTestsSpec: QuickSpec {
	
	
	override func spec() {
		
		describe("AccountTestsSpec") {
			
			it("Account can be initialized") {
				
				let json = "{\"id\":1,\"address\":\"Mx184ac726059e43643e67290666f7b3195093f870\",\"encrypted\":\"encrypted\",\"isServiceSecured\":true,\"isMain\":true}"
				let address = Mapper<AddressMappable>().map(JSONString: json)
				expect(address).toNot(beNil())
				expect(address?.id).to(equal(1))
				expect(address?.address).to(equal("Mx184ac726059e43643e67290666f7b3195093f870"))
				expect(address?.encrypted).to(equal("encrypted"))
				expect(address?.isMain).to(beTrue())
				expect(address?.isServiceSecured).to(beTrue())
				
			}
		}
	}
}
