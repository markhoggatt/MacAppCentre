//
//  SecureCredential.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 25/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

/// Holds parameters for secure storage
struct SecureCredential
{
	/// The user name that this structure represents.
	var userName : String

	/// The password to secure.
	var password : String

	/// The server to which this credential relates.
	var server : String
}
