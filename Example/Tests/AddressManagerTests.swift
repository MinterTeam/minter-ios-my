//
//  MyAddressManagerTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class MyAddressManagerTestsSpec: QuickSpec {
	
	let http = APIClient()
	var manager: MyAddressManager!
	
	override func spec() {
		
		describe("MyAddressManagerTestsSpec") {
			
			it("MyAddressManager can be initialized") {
				let manager = MyAddressManager(httpClient: self.http)
				expect(manager).toNot(beNil())
			}

			it("MyAddressManager can be initialized") {
				self.manager = MyAddressManager(httpClient: self.http)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.addresses(completion: { (addresses, err) in
						expect(addresses).to(beEmpty())
						expect(err).toNot(beNil())
						
						done()
					})
				}
			}
			
		}
	}
}
