//
//  MinterMyAPIURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 02/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation
import MinterCore

public let MinterMyTestnetAPIBaseURL = "https://my.beta.minter.network/api/v1/"
public let MinterMyAPIBaseURL = "https://my.apps.minter.network/api/v1/"

public enum MinterMyAPIURL {

	var baseURL: String {
		return MinterMySDK.shared.network == .testnet ? MinterMyTestnetAPIBaseURL : MinterMyAPIBaseURL
	}

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
			return URL(string: self.baseURL + "register")!

		case .login:
			return URL(string: self.baseURL + "login")!

		case .username(let username):
			return URL(string: self.baseURL + "username/" + username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		//Profile
		case .password:
			return URL(string: self.baseURL + "profile/password")!

		case .profileConfirm(let id):
			return URL(string: self.baseURL + "profile/confirm/\(id)/")!

		case .profile:
			return URL(string: self.baseURL + "profile")!

		case .profileAvatar:
			return URL(string: self.baseURL + "profile/avatar")!

		case .avatarAddress(let address):
			return URL(string: self.baseURL + "avatar/by/address/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .avatarUserId(let id):
			return URL(string: self.baseURL + "avatar/by/user/" + String(id))!

		case .avatarByCoin(let coin):
			return URL(string: self.baseURL + "avatar/by/coin/" + coin.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		}
	}
}
