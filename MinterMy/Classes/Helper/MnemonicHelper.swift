//
//  MnemonicHelper.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 17/08/2018.
//

import Foundation
import MinterCore
import CryptoSwift

class MnemonicHelper {

	private let iv = Data(bytes: "Minter seed".bytes).setLengthRight(16)

	enum MnemonicHelperError : Error {
		case privateKeyUnableToEncrypt
		case privateKeyEncryptionFaulted
		case privateKeyCanNotBeSaved
	}

	//Generate Seed from mnemonic
	func seed(mnemonic: String, passphrase: String = "") -> Data? {
		return Data(hex: String.seedString(mnemonic, passphrase: passphrase)!)
	}

	func encryptedMnemonic(mnemonic: String, password: Data) throws -> Data? {
		do {
			let aes = try AES(key: password.bytes, blockMode: CBC(iv: self.iv!.bytes))
			let ciphertext = try aes.encrypt(Array(mnemonic.utf8))
			guard ciphertext.count > 0 else {
				//throw error
				assert(true)
				throw MnemonicHelperError.privateKeyEncryptionFaulted
			}
			return Data(bytes: ciphertext)
		} catch {
			throw MnemonicHelperError.privateKeyUnableToEncrypt
		}
		return nil
	}

	func address(from mnemonic: String) -> String? {
		guard let seed = self.seed(mnemonic: mnemonic) else {
			return nil
		}

		let pk = PrivateKey(seed: seed)
		guard
			let newPk = try? pk.derive(at: 44, hardened: true)
			.derive(at: 60, hardened: true)
			.derive(at: 0, hardened: true)
			.derive(at: 0)
			.derive(at: 0),
			let publicKey = RawTransactionSigner.publicKey(privateKey: newPk.raw,
																										 compressed: false)?.dropFirst(),
			let address = RawTransactionSigner.address(publicKey: publicKey) else {
				return nil
		}
		return address
	}

	func decryptMnemonic(encrypted: Data, password: Data) -> String? {
		let key = password
		let aes = try? AES(key: password.bytes, blockMode: CBC(iv: self.iv!.bytes))
		guard let decrypted = try? aes?.decrypt(encrypted.bytes) else {
			return nil
		}
		let mnemonic = Data(bytes: decrypted!)
		return String(data: mnemonic, encoding: .utf8)
	}

}
