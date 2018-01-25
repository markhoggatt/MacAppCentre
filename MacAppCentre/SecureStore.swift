//
//  SecureStore.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 25/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Foundation


/// Manages data that must be stored and managed securely in the Keychain.
class SecureStore
{

	/// Add an item to the Keychain
	///
	/// - Parameter cred: SecureCredential structure that contains the account data.
	/// - Returns: true if the credential was stored successfully or was already found, otherwise false.
	func AddItem(credential cred : SecureCredential) -> Bool
	{
		guard let pwd : Data = cred.password.data(using: String.Encoding.utf8)
		else
		{
			return false
		}

		let secQuery : [String : Any] = [kSecClass as String : kSecClassGenericPassword,
										 kSecAttrAccount as String : cred.userName,
										 kSecAttrServer as String : cred.server,
										 kSecValueData as String : pwd]
		let status : OSStatus = SecItemAdd(secQuery as CFDictionary, nil)

		return status == errSecSuccess
	}
}
