//
//  LoggedInUser.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 04/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Foundation


/// Logged in user record. GET URL = https://api.appcenter.ms/v0.1/user
struct LoggedInUser : Codable
{
	var id : String
	var display_name : String
	var email : String
	var name : String
	var can_change_password : Bool
	var created_at : String
	var origin : String
}
