//
//  ViewController.swift
//  MinterMy
//
//  Created by sidorov.panda on 05/01/2018.
//  Copyright (c) 2018 sidorov.panda. All rights reserved.
//

import UIKit
import MinterCore
import MinterMy


class ViewController: UIViewController {
	
	var manager: AuthManager?
	var profileManager: ProfileManager?
	
	/// HTTP Client
	let httpClient = APIClient.shared
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.manager = AuthManager(httpClient: httpClient)
		
		manager?.isTaken(username: "ody344", completion: { [weak self] (respoonse, error) in
			print(respoonse)
			print(error)
		})
		
		let accessToken = "Your access token"
		let client = APIClient(headers: ["Authorization" : "Bearer " + accessToken])
		profileManager = ProfileManager(httpClient: client)
		
		let base64 = "base64ImageString"
		
		profileManager?.uploadAvatar(imageBase64: base64, completion: { (succeed, url, error) in
			print(succeed)
			print(url)
			print(error)
		})
		
		profileManager?.deleteAvatar(with: { (error) in
			print(error)
		})
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

