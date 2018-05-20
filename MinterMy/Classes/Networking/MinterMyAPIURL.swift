//
//  MinterMyAPIURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 02/05/2018.
//

import Foundation
import MinterCore

let MinterMyAPIBaseURL = "http://159.89.107.246:8841/api/v1/"


enum MinterMyAPIURL {
	
	//
	case register
	case login
	case username
	//profile
	case profileConfirm(id: Int)
	case profile
	
	func url() -> URL {
		switch self {
			
		//Auth
		case .register:
			return URL(string: MinterMyAPIBaseURL + "register")!
			
		case .login:
			return URL(string: MinterMyAPIBaseURL + "login")!
			
		case .username:
			return URL(string: MinterMyAPIBaseURL + "username")!
			
		//Profile
			
		case .profileConfirm(let id):
			return URL(string: MinterMyAPIBaseURL + "profile/confirm/\(id)/")!
			
		case .profile:
			return URL(string: MinterMyAPIBaseURL + "profile")!
			
		}
	}
}
