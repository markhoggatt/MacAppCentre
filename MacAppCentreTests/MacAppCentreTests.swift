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

	let testJsonResponse : String = "{\"id\":\"ea71de61-791a-45e4-bc86-2c25c2fcd153\",\"display_name\":\"Mark Hoggatt\",\"email\":\"mark.hoggatt@paxton-access.co.uk\",\"name\":\"ProEuropa\",\"avatar_url\":null,\"can_change_password\":false,\"created_at\":\"2017-11-27T07:31:03.000Z\",\"origin\":\"appcenter\"}"
	let expectedResponseLen : Int = 244
	
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

	func testJsonDecode()
	{
		let decoder = JSONDecoder()
		let jsonData : Data = testJsonResponse.data(using: String.Encoding.utf8)!
		XCTAssertNotNil(jsonData)
		XCTAssertEqual(244, jsonData.count)
		guard let userRecord = try? decoder.decode(LoggedInUser.self, from: jsonData)
		else
		{
			XCTFail()
			return
		}

		XCTAssertEqual("ea71de61-791a-45e4-bc86-2c25c2fcd153", userRecord.id)
		XCTAssertEqual("Mark Hoggatt", userRecord.display_name)
		XCTAssertEqual("mark.hoggatt@paxton-access.co.uk", userRecord.email)
		XCTAssertEqual("ProEuropa", userRecord.name)
		XCTAssertFalse(userRecord.can_change_password)
		XCTAssertEqual("2017-11-27T07:31:03.000Z", userRecord.created_at)
		XCTAssertEqual("appcenter", userRecord.origin)
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
