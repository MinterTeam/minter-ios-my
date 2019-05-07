//
//  MinterMyURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 05/06/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation

public let MinterMyTestnetBaseURL = "https://my.beta.minter.network/api/v1/"
public let MinterMyBaseURL = "https://my.apps.minter.network/api/v1/"

enum MinterMyURL {
	
	var baseURL: String {
		return MinterMySDK.shared.network == .testnet ? MinterMyTestnetBaseURL : MinterMyBaseURL
	}
	
	case addressesEncrypted
	case addressEncrypted(address: String)
	case infoByAddresses
	case addressByContact

	func url() -> URL {
		
		switch self {
		case .addressByContact:
			return URL(string: baseURL + "info/address/by/contact")!
			
		case .addressesEncrypted:
			return URL(string: baseURL + "addresses/encrypted")!
		
		case .addressEncrypted(let address):
			return URL(string: baseURL + "addresses/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! + "/encrypted")!
			
		case .infoByAddresses:
			return URL(string: baseURL + "info/by/addresses")!
		
		}
	}

}
