//
//  Manager+Default.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 07/06/2018.
//

import Foundation
import MinterCore

public extension AuthManager {
	
	public class var `default`: AuthManager {
		let httpClient = APIClient.shared
		return AuthManager(httpClient: httpClient)
	}

}
