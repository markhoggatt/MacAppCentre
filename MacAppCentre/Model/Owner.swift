//
//  Owner.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 10/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//


/// Owner record. Object used by other structures.
struct Owner : Codable
{
	/// Unique identifier
	var id : String

	/// URL for an avatar, if available.
	var avatar_url : String?

	/// Visible name
	var display_name : String

	/// Email of the owner, if available.
	var email : String?

	/// Internal name
	var name : String

	/// Owner type
	var type : String
}
