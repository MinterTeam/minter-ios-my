//
//  MinterMyAPIURL.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 02/05/2018.
//

import Foundation

let MinterMyAPIBaseURL = "http://159.89.107.246:8841/api/"


enum MinterMyAPIURL {
	
	case balance
	
	func url() -> URL {
		switch self {
		case .balance:
			return URL(string: MinterMyAPIBaseURL + "getBalance")!
			
		}
	}
}
