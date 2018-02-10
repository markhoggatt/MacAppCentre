//
//  MacAppCentreTests.swift
//  MacAppCentreTests
//
//  Created by Mark Hoggatt on 24/01/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import XCTest
@testable import MacAppCentre

class MacAppCentreTests: XCTestCase
{
	let testUser : String = "sparks"
	let testPassword : String = "secretista"
	let testServer : String = "ms appcenter"
	let testUrl : String = "https://www.appcentre.eu/login"
	
    override func setUp()
	{
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()
	{
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    /// Test normal Add, find and delete operations on the Keychain wrapper object.
    func testSecureStore()
	{
		guard let serverUrl = URL(string: testUrl)
		else
		{
			XCTFail()
			return
		}

		let cred = SecureCredential(userName : testUser, password : testPassword, serverName : testServer, serverUrl : serverUrl)
        let sec = SecureStore()
		let existing : SecureCredential? = sec.FindItem(OnServer: testServer, ForUser: testUser)
		if existing != nil
		{
			let delResult : Bool = sec.DeleteItem(ForServer: testServer, WithUser: testUser)
			XCTAssertTrue(delResult)
		}

		let secResult : Bool = sec.AddItem(credential : cred)
		XCTAssertTrue(secResult)

		guard let secFound : SecureCredential = sec.FindItem(OnServer: testServer, ForUser: testUser)
		else
		{
			XCTFail()
			return
		}
		XCTAssertEqual(secFound, cred)

		let delResult2 : Bool = sec.DeleteItem(ForServer: testServer, WithUser: testUser)
		XCTAssertTrue(delResult2)
    }
    
    func testPerformanceExample()
	{
        // This is an example of a performance test case.
        self.measure
		{
            // Put the code you want to measure the time of here.
        }
    }
}
