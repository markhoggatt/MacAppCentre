//
//  SecureCredential.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 25/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Foundation

/// Holds parameters for secure storage
struct SecureCredential : Equatable
{
	/// The user name that this structure represents.
	var userName : String

	/// The password to secure.
	var password : String

	/// The name that best describes this credential.
	var serverName : String

	/// The server URL.
	var serverUrl : URL

	/// Compare two objects.
	static func ==(lhs: SecureCredential, rhs: SecureCredential) -> Bool
	{
		if lhs.userName != rhs.userName
		{
			return false
		}
		if lhs.serverName != rhs.serverName
		{
			return false
		}
		if lhs.serverUrl != rhs.serverUrl
		{
			return false
		}
		if lhs.password != rhs.password
		{
			return false
		}

		return true
	}
}
