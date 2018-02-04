//
//  SettingsViewController.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 24/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Cocoa

class SettingsViewController : NSViewController, NSTextFieldDelegate, JsonRepondable
{
	let siteName : String = "Microsoft App Centre"
	let siteUrl : String = "https://api.appcenter.ms/"
	var jsonHttpComms : WebCommsMgr?

	@IBOutlet weak var privateTokenField: NSSecureTextField!
	@IBOutlet weak var userNameTextField: NSTextField!
	@IBOutlet weak var emailTextField: NSTextField!
	@IBOutlet weak var aliasNameTextField: NSTextField!
	@IBOutlet weak var creationDateTextField: NSTextField!
	@IBOutlet weak var signInButton: NSButton!

	override func viewDidLoad()
	{
		jsonHttpComms = WebCommsMgr()
	}
	
	override var representedObject: Any?
	{
		didSet
		{

		}
	}

	override func controlTextDidChange(_ obj: Notification)
	{
		signInButton.isEnabled = privateTokenField.stringValue.count > 0
	}

	@IBAction func signInButtonClicked(_ sender: NSButton)
	{
		guard jsonHttpComms != nil
		else
		{
			return
		}

		if jsonHttpComms!.jsonResponseDelegate == nil
		{
			jsonHttpComms!.jsonResponseDelegate = self
		}

		let webApiCall : String = siteUrl + "v0.1/user"
		jsonHttpComms!.MakeRequestToServer(atUrl: webApiCall, withContent: "", usingToken: privateTokenField.stringValue)
	}

	func DidRespondWithJson(jsonData: Data)
	{
		let decoder = JSONDecoder()

		do
		{
			guard let userRecord = try? decoder.decode(LoggedInUser.self, from: jsonData)
			else
			{
				NSLog("JSON decode failed")
				return
			}

			DispatchQueue.main.async
			{
				self.userNameTextField.stringValue = userRecord.display_name
				self.emailTextField.stringValue = userRecord.email
				self.aliasNameTextField.stringValue = userRecord.name
				self.creationDateTextField.stringValue = userRecord.created_at.description

				self.signInButton.isEnabled = false
			}
		}
	}

	deinit
	{
		if jsonHttpComms != nil
		{
			jsonHttpComms!.jsonResponseDelegate = nil
			jsonHttpComms = nil
		}
	}
}
