//
//  AuthManager.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 20/05/2018.
//

import Foundation
import MinterCore


public class AuthManager : BaseManager {
	
	public func isTaken(username: String, completion: ((Bool?, Error?) -> ())?) {
		let url = MinterMyAPIURL.username.url()
		
		self.httpClient.getRequest(url, parameters: ["username" : username]) { (response, error) in
			
			var res: Bool?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil != error else {
				err = error
				return
			}
			
			
			
			print(response)
			print(error)
			
		}
	}
	
}
