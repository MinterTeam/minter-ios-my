//
//  MinterMyURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 05/06/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation


let MinterMyBaseURL = "https://my.beta.minter.network/api/v1/"


enum MinterMyURL {
	
	case addressesEncrypted
	case addressEncrypted(address: String)
	case infoByAddresses
	case addressByContact

	func url() -> URL {
		
		switch self {
		case .addressByContact:
			return URL(string: MinterMyBaseURL + "info/address/by/contact")!
			
		case .addressesEncrypted:
			return URL(string: MinterMyBaseURL + "addresses/encrypted")!
		
		case .addressEncrypted(let address):
			return URL(string: MinterMyBaseURL + "addresses/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! + "/encrypted")!
			
		case .infoByAddresses:
			return URL(string: MinterMyBaseURL + "info/by/addresses")!
		
		}
	}

}
