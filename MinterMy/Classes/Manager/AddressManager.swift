//
//  AddressManager.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 14/06/2018.
//

import Foundation
import MinterCore
import ObjectMapper


/// Address Manager
public class MyAddressManager : BaseManager {
	
	/**
	Method retreives addresses data from the Minter My server
	- SeeAlso: https://my.beta.minter.network/help/index.html
	*/
	public func addresses(completion: (([Address]?, Error?) -> ())?) {
		
		let url = MinterMyURL.addressesEncrypted.url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var addresses = [Address]()
			var err: Error?
			
			defer {
				completion?(addresses, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let addrs = response.data as? [[String : Any]] {
				addresses = Mapper<AddressMappable>().mapArray(JSONArray: addrs)
			}
		}
	}

//	public func address(address: String, completion: (([String : Any], Error?) -> ())?) {
//
//		let url = MinterMyURL.addressesEncrypted.url()
//
//		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
//
//			var res = [String : Any]()
//			var err: Error?
//
//			defer {
//				completion?(res, err)
//			}
//
//			guard nil == error else {
//				err = error
//				return
//			}
//
//
//		}
//	}

}

