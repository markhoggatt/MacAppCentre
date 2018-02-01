//
//  SettingsViewController.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 24/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Cocoa

class SettingsViewController : NSViewController, NSTextFieldDelegate
{
	let siteName : String = "Microsoft App Centre"
	let siteUrl : String = "https://api.appcenter.ms/"

	@IBOutlet weak var privateTokenField: NSSecureTextField!
	@IBOutlet weak var userNameTextField: NSTextField!
	@IBOutlet weak var emailTextField: NSTextField!
	@IBOutlet weak var aliasNameTextField: NSTextField!
	@IBOutlet weak var creationDateTextField: NSTextField!
	@IBOutlet weak var signInButton: NSButton!

	override func viewDidLoad()
	{

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
	}
}
