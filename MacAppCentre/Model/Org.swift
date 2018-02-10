//
//  Team.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 10/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

/// A team set up by a logged in user.
/// GET URL = https://api.appcenter.ms/v0.1/orgs . Returns an array of Org.
struct Org : Codable
{
	/// Unique team id
	var id : String

	/// Visible name
	var display_name : String

	/// Initernal name
	var name : String

	/// Originating site
	var origin : String
}
