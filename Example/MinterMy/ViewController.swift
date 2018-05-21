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

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let httpClient = APIClient.shared
		
		self.manager = AuthManager(httpClient: httpClient)
		
		manager?.isTaken(username: "ody344", completion: { [weak self] (respoonse, error) in
			print(respoonse)
			print(error)
		})
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

