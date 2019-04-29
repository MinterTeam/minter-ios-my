//
//  Account.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 03/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation

/// Account model
public struct Account {
	
	public enum EncryptedBy : String {
		case me = "me"
		case bipWallet = "bipWallet"
	}
	
	//MARK: -
	
	/// Encryption type
	public var encryptedBy: EncryptedBy
	
	/// Minter Address
	public var address: String
	
	/// Whether the address is main for this account
	public var isMain: Bool
	
	public var lastBalance: [String : Double] = [:]
	
	/// Account id
	public var id: Int
	
	//MARK: -
	
	public init(id: Int, encryptedBy: EncryptedBy, address: String, isMain: Bool = false) {
		self.id = id
		self.encryptedBy = encryptedBy
		self.address = address
		self.isMain = isMain
	}
	
	//MARK: -

	/// Method substitutes two account instances
	public mutating func merge(with account: Account) {
		self.id = account.id
		self.encryptedBy = account.encryptedBy
		self.address = account.address
		self.isMain = account.isMain
	}

}

extension Account : Equatable {
	
	public static func == (lhs: Account, rhs: Account) -> Bool {
		return lhs.id == rhs.id && lhs.address == rhs.address && lhs.encryptedBy.rawValue == rhs.encryptedBy.rawValue && lhs.isMain == rhs.isMain
	}
}
