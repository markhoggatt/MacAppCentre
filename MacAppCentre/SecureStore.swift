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

		let secQuery : [String : Any] = [kSecClass as String : kSecClassInternetPassword,
										 kSecAttrAccount as String : cred.userName,
										 kSecAttrServer as String : cred.server,
										 kSecValueData as String : pwd]
		let status : OSStatus = SecItemAdd(secQuery as CFDictionary, nil)

		return status == errSecSuccess
	}


	/// Locates the password for a given user account in the Keychain, if it exists.
	///
	/// - Parameters:
	///   - svr: Server URL
	///   - usr: User id
	/// - Returns: The SecureCredential that relates or nil if not found.
	func FindItem(OnServer svr : String, ForUser usr: String) -> SecureCredential?
	{
		let searchQuery = BuildSearchQuery(serverName: svr, userName: usr)
		var foundItem : CFTypeRef?
		let status = SecItemCopyMatching(searchQuery as CFDictionary, &foundItem)
		if status != errSecSuccess
		{
			return nil
		}

		guard let pwd = foundItem as? String
		else
		{
			return nil
		}

		return SecureCredential(userName: usr, password: pwd, server: svr)
	}

	func DeleteItem(ForServer svr : String, WithUser usr : String) -> Bool
	{
		let searchQuery = BuildSearchQuery(serverName: svr, userName: usr)
		let status = SecItemDelete(searchQuery as CFDictionary)

		return status == errSecSuccess
	}

	fileprivate func BuildSearchQuery(serverName svr : String, userName usr: String) -> [String : Any]
	{
		return [kSecClass as String : kSecClassInternetPassword,
											kSecAttrServer as String : svr,
											kSecAttrAccount as String : usr,
											kSecMatchLimit as String : kSecMatchLimitOne,
											kSecReturnData as String : true]
	}
}
