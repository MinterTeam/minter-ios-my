//
//  ProfileManager.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 19/06/2018.
//

import Foundation
import MinterCore
import ObjectMapper


public class ProfileManager : BaseManager {
	
	public func profile(completion: ((User?, Error?) -> ())?) {
		
		let url = MinterMyAPIURL.profile.url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var user: User?
			var err: Error?
			
			defer {
				completion?(user, err)
			}
			
			guard nil == error, let data = response.data as? [String : Any] else {
				err = error
				return
			}
			
			user = Mapper<UserMappable>().map(JSON: data)
			
		}

	}
	
	public func updateProfile(user: User, completion: ((Bool?, Error?) -> ())?) {
		
		let url = MinterMyAPIURL.profile.url()

		let params = UserMappable(user: user).toJSON()
		
		self.httpClient.putRequest(url, parameters: params) { (response, error) in
			
			var success = false
			var err: Error?
			
			defer {
				completion?(success, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			success = true
		}
	}
	
	public func uploadAvatar(imageBase64: String, completion: ((Bool?, URL?, Error?) -> ())?) {
		
		let url = MinterMyAPIURL.profileAvatar.url()
		
		self.httpClient.postRequest(url, parameters: ["avatarBase64" : imageBase64]) { (response, error) in
			
			var succeed = false
			var url: URL?
			
			defer {
				completion?(succeed, url, error)
			}
			
			guard nil == error else {
				return
			}
			
			succeed = true
			
			if let data = response.data as? [String : Any], let urlString = data["src"] as? String {
				url = URL(string: urlString)
			}
		}
	}

}
