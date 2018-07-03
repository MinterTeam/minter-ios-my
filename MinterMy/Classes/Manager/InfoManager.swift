//
//  InfoManager.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 22/06/2018.
//

import Foundation
import MinterCore
import ObjectMapper


public class InfoManager : BaseManager {
	
	public enum InfoManagerError : Error {
		case wrongParametes
	}
	
	public func info(by addresses: [String], completion: (([[String : Any]]?, Error?) -> ())?) {
		
		let url = MinterMyURL.infoByAddresses.url()
		
		self.httpClient.getRequest(url, parameters: ["addresses" : addresses]) { (response, error) in
			
			var res: [[String : Any]]?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [[String : Any]] {
				res = data
			}
			
		}
	}

	public func address(username: String? = nil, email: String? = nil, completion: ((String?, User?, Error?) -> ())?) {
		
		let url = MinterMyURL.addressByContact.url()
		
		guard username != nil || email != nil else {
			completion?(nil, nil, InfoManagerError.wrongParametes)
			return
		}
		
		var field = "username"
		var value = username
		
		if email != nil {
			field = "email"
			value = email
		}
		
		self.httpClient.getRequest(url, parameters: [field : value!]) { (response, error) in
			
			var address: String?
			var user: User?
			var err: Error?
			
			defer {
				completion?(address, user, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : Any] {
				address = data["address"] as? String
				
				if let usr = data["user"] as? [String : Any] {
					user = Mapper<UserMappable>().map(JSON: usr)
				}
				
				
			}
			
		}
	}

	
	

}

