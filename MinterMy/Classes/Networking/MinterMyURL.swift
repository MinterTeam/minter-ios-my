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

	func url() -> URL {
		
		switch self {
		case .addressesEncrypted:
			return URL(string: MinterMyBaseURL + "addresses/encrypted")!
		
		case .addressEncrypted(let address):
			return URL(string: MinterMyBaseURL + "addresses/" + address + "/encrypted")!
		
		}
	}

}
