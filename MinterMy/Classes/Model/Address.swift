//
//  Address.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 15/06/2018.
//

import Foundation
import ObjectMapper
import MinterCore


/// Address model
public class Address {
	
	/// Address identifier
	public var id: Int?
	
	/// Minter Address
	public var address: String?
	
	public var isMain: Bool?
	public var isServiceSecured: Bool?
	public var encrypted: String?
}

/// Address Mapper
class AddressMappable : Address, Mappable {
	
	required init?(map: Map) {
		super.init()
		
		mapping(map: map)
	}
	
	func mapping(map: Map) {
		id <- map["id"]
		address <- map["address"]
		isMain <- map["isMain"]
		isServiceSecured <- map["isServiceSecured"]
		encrypted <- map["encrypted"]
	}
	
}
