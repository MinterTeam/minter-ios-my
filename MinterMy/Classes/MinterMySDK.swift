//
//  MinterMySDK.swift
//  MinterMy
//
//  Created by Alexey Sidorov on 29/04/2019.
//

import Foundation
import MinterCore

public class MinterMySDK {

	private init() {}

	public static let shared = MinterMySDK()

	public var network: MinterCoreSDK.Network {
		return self._network
	}

	internal var _network: MinterCoreSDK.Network = .testnet

	/// MinterMy SDK initializer
	public class func initialize(network: MinterCoreSDK.Network = .testnet) {
		shared._network = network
	}

}
