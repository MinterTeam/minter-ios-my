//
//  MnemonicHelperTests.swift
//  MinterMy_Tests
//
//  Created by Alexey Sidorov on 10/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterMy


class MnemonicHelperTestsSpec: QuickSpec {
	
	
	override func spec() {
		
		describe("MnemonicHelperSpec") {
			
			it("MnemonicHelper can generate seed from mnemonic") {
				
				let correctData = Data(hex: "b433223a9d3ac872f3af87d971522aa53916d2fbb4f1ba92ea3bad8ec5a7c6fa1ab1e1e34e44b1c8fdaf08d23c72a68807ac8e6aa52872ad336b7e8fd0c60a4c")
				
				let mnemonic = "adjust correct photo fancy knee lion blur away coconut inform sun cancel"
				let data = MnemonicHelper().seed(mnemonic: mnemonic)
				expect(data).toNot(beNil())
				expect(data).to(equal(correctData))
			}
			
			it("MnemonicHelper can encrypt mnemonic") {
				let mnemonic = "globe arrange forget twice potato nurse ice dwarf arctic piano scorpion tube"
				let rawPassword = Data(hex: "123456".sha256())
				let encryptedMnemonic = Data(hex: "e28513acd2336aa048b68cf382a45ec0bc7bed1e7d35f2b7bf0b6c1406e6f3c57fc91c08ba972f7ed82050e54867e1624b2e2f145aa8d0a40d51ad4eb258faa7e2a9ccaed555d15d7830df188897c054")
				
				let data = try? MnemonicHelper().encryptedMnemonic(mnemonic: mnemonic, password: rawPassword)
				expect(data).to(equal(encryptedMnemonic))
			}
			
			it("MnemonicHelper can generate seed from mnemonic") {
				let mnemonic = "globe arrange forget twice potato nurse ice dwarf arctic piano scorpion tube"
				let rawPassword = Data(hex: "123456".sha256())
				let encryptedMnemonic = Data(hex: "e28513acd2336aa048b68cf382a45ec0bc7bed1e7d35f2b7bf0b6c1406e6f3c57fc91c08ba972f7ed82050e54867e1624b2e2f145aa8d0a40d51ad4eb258faa7e2a9ccaed555d15d7830df188897c054")
				
				let data = MnemonicHelper().decryptMnemonic(encrypted: encryptedMnemonic, password: rawPassword)
				expect(data).to(equal(mnemonic))
			}
			
			it("MnemonicHelper can get address from mnemonic") {
				let mnemonic = "globe arrange forget twice potato nurse ice dwarf arctic piano scorpion tube"
				let correctAddress = "676138799ee899a214d6d878b4658fc77e2f0922"
				
				let address = MnemonicHelper().address(from: mnemonic)
				expect(address).to(equal(correctAddress))
			}
			
		}
	}
}
