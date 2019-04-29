//
//  AccountTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 09/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class AccountTestsSpec: QuickSpec {
	
	
	override func spec() {
		
		describe("AccountTestsSpec") {
			
			it("Account can be initialized") {
				let id = 1
				let encrypted = Account.EncryptedBy.bipWallet
				let address = "Mx184ac726059e43643e67290666f7b3195093f870"
				let isMain = true
				
				let account = Account(id: id, encryptedBy: encrypted, address: address, isMain: isMain)
				
				expect(account).toNot(beNil())
				expect(account.id).to(equal(id))
				expect(account.encryptedBy).to(equal(encrypted))
				expect(account.address).to(equal(address))
				expect(account.isMain).to(equal(isMain))
			}
		}
		
		it("Can be merged") {
			let id = 1
			let encrypted = Account.EncryptedBy.bipWallet
			let address = "Mx184ac726059e43643e67290666f7b3195093f870"
			let isMain = true
			
			var account = Account(id: id, encryptedBy: encrypted, address: address, isMain: isMain)
			
			let id2 = 2
			let encrypted2 = Account.EncryptedBy.me
			let address2 = "Mx184ac726059e43643e67290666f7b3195093f871"
			let isMain2 = false
			
			let account2 = Account(id: id2, encryptedBy: encrypted2, address: address2, isMain: isMain2)
			
			account.merge(with: account2)
			
			expect(account).toNot(beNil())
			expect(account.id).to(equal(id2))
			expect(account.encryptedBy).to(equal(encrypted2))
			expect(account.address).to(equal(address2))
			expect(account.isMain).to(equal(isMain2))
		}
		
		it("Can be compared") {
			let id = 1
			let encrypted = Account.EncryptedBy.bipWallet
			let address = "Mx184ac726059e43643e67290666f7b3195093f870"
			let isMain = true
			
			var account = Account(id: id, encryptedBy: encrypted, address: address, isMain: isMain)
			
			let id2 = 2
			let encrypted2 = Account.EncryptedBy.me
			let address2 = "Mx184ac726059e43643e67290666f7b3195093f871"
			let isMain2 = false
			
			let account2 = Account(id: id2, encryptedBy: encrypted2, address: address2, isMain: isMain2)
			
			expect(account).toNot(equal(account2))
		}
		
		it("Can be compared") {
			let id = 1
			let encrypted = Account.EncryptedBy.bipWallet
			let address = "Mx184ac726059e43643e67290666f7b3195093f870"
			let isMain = true
			
			let account = Account(id: id, encryptedBy: encrypted, address: address, isMain: isMain)
			
			let id2 = 1
			let encrypted2 = Account.EncryptedBy.bipWallet
			let address2 = "Mx184ac726059e43643e67290666f7b3195093f870"
			let isMain2 = true
			
			let account2 = Account(id: id2, encryptedBy: encrypted2, address: address2, isMain: isMain2)
			
			expect(account).to(equal(account2))
		}
		
	}
}
