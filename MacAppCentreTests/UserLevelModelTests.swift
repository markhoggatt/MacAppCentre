//
//  UserLevelModelTests.swift
//  MacAppCentreTests
//
//  Created by Mark Hoggatt on 10/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import XCTest
@testable import MacAppCentre

class UserLevelModelTests: XCTestCase
{
	let loggedInUserJson : String = """
{"id":"ea71de61-791a-45e4-bc86-2c25c2fcd153","display_name":"Mark Hoggatt","email":"mark.hoggatt@paxton-access.co.uk","name":"ProEuropa","avatar_url":null,"can_change_password":false,"created_at":"2017-11-27T07:31:03.000Z","origin":"appcenter"}
"""

	let userOrgsJson : String = """
	[{"id":"9badea42-43a5-44b2-b9d6-ef36740bf92f","display_name":"Paxton","name":"Paxton","origin":"appcenter"}]
	"""

	let applicationJson : String = """
	[{"id":"dedb395b-25c7-4f58-bf1f-89037f517c5b","app_secret":"94f47f48-58b0-4005-81e6-d6c3d0fdd458","description":"Paxton services administration App","display_name":"PaxtonConnect","name":"PaxtonConnect-1","os":"Android","platform":"Xamarin","origin":"appcenter","icon_url":"https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/682/367/original/a15269d50149a2f10ce138bc915c9f2a.png","created_at":"2018-01-05T08:26:03.000Z","updated_at":"2018-02-09T16:17:43.000Z","owner":{"id":"9badea42-43a5-44b2-b9d6-ef36740bf92f","avatar_url":null,"display_name":"Paxton","email":null,"name":"Paxton","type":"org"},"azure_subscription":null,"member_permissions":["manager"]},{"id":"c50e9718-82a5-4cf6-8597-af488a2b15aa","app_secret":"be281b30-87a2-4cb0-828c-31a5796e8b9a","description":"Administer Paxton user sites","display_name":"PaxtonConnect","name":"PaxtonConnect","os":"iOS","platform":"Xamarin","origin":"appcenter","icon_url":"https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/681/282/original/6b68e177a043079f5dfa58a7cf13e1cf.png","created_at":"2018-01-03T12:14:44.000Z","updated_at":"2018-01-05T15:47:43.000Z","owner":{"id":"9badea42-43a5-44b2-b9d6-ef36740bf92f","avatar_url":null,"display_name":"Paxton","email":null,"name":"Paxton","type":"org"},"azure_subscription":null,"member_permissions":["manager"]}]
"""

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

	func testJsonDecode()
	{
		let decoder = JSONDecoder()
		let jsonData : Data = loggedInUserJson.data(using: String.Encoding.utf8)!
		XCTAssertNotNil(jsonData)
		XCTAssertGreaterThan(jsonData.count, 0)
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

    func testUserTeams()
	{
		let decoder = JSONDecoder()
		let jsonData : Data = userOrgsJson.data(using: String.Encoding.utf8)!
		XCTAssertNotNil(jsonData)
		XCTAssertGreaterThan(jsonData.count, 0)
		guard let userOrgRecord = try? decoder.decode([Org].self, from: jsonData)
			else
		{
			XCTFail()
			return
		}

		XCTAssertEqual(1, userOrgRecord.count)
		for team in userOrgRecord
		{
			XCTAssertEqual("9badea42-43a5-44b2-b9d6-ef36740bf92f", team.id)
			XCTAssertEqual("Paxton", team.display_name)
			XCTAssertEqual("Paxton", team.name)
			XCTAssertEqual("appcenter", team.origin)
		}
    }

	func testApplication()
	{
		let decoder = JSONDecoder()
		let jsonData : Data = applicationJson.data(using: String.Encoding.utf8)!
		XCTAssertNotNil(jsonData)
		XCTAssertGreaterThan(jsonData.count, 0)
		guard let appRecord = try? decoder.decode([Application].self, from: jsonData)
			else
		{
			XCTFail()
			return
		}

		XCTAssertEqual(2, appRecord.count)

		XCTAssertEqual("dedb395b-25c7-4f58-bf1f-89037f517c5b", appRecord[0].id)
		XCTAssertEqual("c50e9718-82a5-4cf6-8597-af488a2b15aa", appRecord[1].id)
	}

    func testPerformanceExample()
	{
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
