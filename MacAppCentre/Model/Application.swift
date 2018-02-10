//
//  Application.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 10/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

/// Application detail.
/// GET URL = https://api.appcenter.ms/v0.1/apps . Returns an array of Application.
struct Application : Codable
{
	/// Unique identifier
	var id : String

	/// App secret
	var app_secret : String

	/// Description
	var description : String

	/// Visible name
	var display_name : String

	/// Internal name
	var name : String

	/// Operating system
	var os : String

	/// Development platform
	var platform : String

	/// Originating site
	var origin : String

	/// URL for the display icon.
	var icon_url : String

	/// Date created
	var created_at : String

	/// Date last updated
	var updated_at : String

	/// Owner record
	var owner : Owner

	/// Azure subscription, if applicable.
	var azure_subscription : String?

	/// Permission set
	var member_permissions : [String]
}
