//
//  User.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 13/06/2018.
//

import Foundation
import ObjectMapper


public class User {

	public var id: Int?
	public var username: String?
	public var name: String?
	public var email: String?
	public var language: String?
	public var avatar: String?
	public var mainAddress: Bool?

}

class UserMappable : User, Mappable {
	
	required init?(map: Map) {
		super.init()
		
		self.mapping(map: map)
	}
	
	func mapping(map: Map) {
		id <- map["id"]
		username <- map["username"]
		name <- map["name"]
		email <- map["email"]
		language <- map["language"]
		avatar <- map["avatar"]
		mainAddress <- map["mainAddress"]
	}

}
