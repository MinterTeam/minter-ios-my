//
//  MinterMyAPIURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 02/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation
import MinterCore

public let MinterMyAPIBaseURL = "https://my.beta.minter.network/api/v1/"


public enum MinterMyAPIURL {
	
	//
	case register
	case login
	case username(username: String)
	
	//profile
	case password
	case profileConfirm(id: Int)
	case profile
	case avatarAddress(address: String)
	case avatarUserId(id: Int)
	case avatarByCoin(coin: String)
	case profileAvatar
	
	
	public func url() -> URL {
		switch self {
		
		//Auth
		case .register:
			return URL(string: MinterMyAPIBaseURL + "register")!
		
		case .login:
			return URL(string: MinterMyAPIBaseURL + "login")!
		
		case .username(let username):
			return URL(string: MinterMyAPIBaseURL + "username/" + username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
		
		//Profile
		case .password:
			return URL(string: MinterMyAPIBaseURL + "profile/password")!
		
		case .profileConfirm(let id):
			return URL(string: MinterMyAPIBaseURL + "profile/confirm/\(id)/")!
		
		case .profile:
			return URL(string: MinterMyAPIBaseURL + "profile")!
		
		case .profileAvatar:
			return URL(string: MinterMyAPIBaseURL + "profile/avatar")!
		
		case .avatarAddress(let address):
			return URL(string: MinterMyAPIBaseURL + "avatar/by/address/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
		
		case .avatarUserId(let id):
			return URL(string: MinterMyAPIBaseURL + "avatar/by/user/" + String(id))!
		
		case .avatarByCoin(let coin):
			return URL(string: MinterMyAPIBaseURL + "avatar/by/coin/" + coin.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
		
		}
	}
}
