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
	let testOwnerId : String = "74D22BEC-B4DC-4F76-A24F-DFCD2563750B"
	let testOrgName : String = "TestyOrg"
	let testAppName : String = "TestyApp"

	let loggedInUserJson : String = """
{"id":"2FCB8932-4CEA-4999-83D5-0D7C339D0E4C","display_name":"Bert Testbloke","email":"bert@testbloke.eu","name":"ProEuropa","avatar_url":null,"can_change_password":false,"created_at":"2017-11-27T07:31:03.000Z","origin":"appcenter"}
"""

	let userOrgsJson : String = """
	[{"id":"74D22BEC-B4DC-4F76-A24F-DFCD2563750B","display_name":"TestyOrg","name":"TestyOrg","origin":"appcenter"}]
	"""

	let applicationJson : String = """
	[{"id":"BDE28D84-85F8-4FB2-BB11-22C6F591B716","app_secret":"27A85F9F-C023-4FDC-8F2F-B95E75B54238","description":"TestyOrg services app","display_name":"TestyApp","name":"TestyApp-1","os":"Android","platform":"Xamarin","origin":"appcenter","icon_url":"https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/682/367/original/a15269d50149a2f10ce138bc915c9f2a.png","created_at":"2018-01-05T08:26:03.000Z","updated_at":"2018-02-09T16:17:43.000Z","owner":{"id":"74D22BEC-B4DC-4F76-A24F-DFCD2563750B","avatar_url":null,"display_name":"TestyOrg","email":null,"name":"TestyOrg","type":"org"},"azure_subscription":null,"member_permissions":["manager"]},{"id":"90A53508-BB82-451B-B23E-09435FF4103E","app_secret":"be281b30-87a2-4cb0-828c-31a5796e8b9a","description":"Administer TestyApp services","display_name":"TestyApp","name":"TestyApp","os":"iOS","platform":"Xamarin","origin":"appcenter","icon_url":"https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/681/282/original/6b68e177a043079f5dfa58a7cf13e1cf.png","created_at":"2018-01-03T12:14:44.000Z","updated_at":"2018-01-05T15:47:43.000Z","owner":{"id":"74D22BEC-B4DC-4F76-A24F-DFCD2563750B","avatar_url":null,"display_name":"TestyOrg","email":null,"name":"TestyOrg","type":"org"},"azure_subscription":null,"member_permissions":["manager"]}]
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

		XCTAssertEqual("2FCB8932-4CEA-4999-83D5-0D7C339D0E4C", userRecord.id)
		XCTAssertEqual("Bert Testbloke", userRecord.display_name)
		XCTAssertEqual("bert@testbloke.eu", userRecord.email)
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
			XCTAssertEqual(testOwnerId, team.id)
			XCTAssertEqual(testOrgName, team.display_name)
			XCTAssertEqual(testOrgName, team.name)
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

		XCTAssertEqual("BDE28D84-85F8-4FB2-BB11-22C6F591B716", appRecord[0].id)
		XCTAssertEqual("90A53508-BB82-451B-B23E-09435FF4103E", appRecord[1].id)

		XCTAssertEqual("27A85F9F-C023-4FDC-8F2F-B95E75B54238", appRecord[0].app_secret)
		XCTAssertEqual("be281b30-87a2-4cb0-828c-31a5796e8b9a", appRecord[1].app_secret)

		XCTAssertEqual("TestyOrg services app", appRecord[0].description)
		XCTAssertEqual("Administer TestyApp services", appRecord[1].description)

		XCTAssertEqual(testAppName, appRecord[0].display_name)
		XCTAssertEqual(testAppName, appRecord[1].display_name)

		XCTAssertEqual(testAppName + "-1", appRecord[0].name)
		XCTAssertEqual(testAppName, appRecord[1].name)

		XCTAssertEqual("Android", appRecord[0].os)
		XCTAssertEqual("iOS", appRecord[1].os)

		XCTAssertEqual("Xamarin", appRecord[0].platform)
		XCTAssertEqual("Xamarin", appRecord[1].platform)

		XCTAssertEqual("appcenter", appRecord[0].origin)
		XCTAssertEqual("appcenter", appRecord[1].origin)

		XCTAssertEqual("https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/682/367/original/a15269d50149a2f10ce138bc915c9f2a.png", appRecord[0].icon_url)
		XCTAssertEqual("https://dl0tgz6ee3upo.cloudfront.net/production/apps/icons/000/681/282/original/6b68e177a043079f5dfa58a7cf13e1cf.png", appRecord[1].icon_url)

		XCTAssertEqual("2018-01-05T08:26:03.000Z", appRecord[0].created_at)
		XCTAssertEqual("2018-01-03T12:14:44.000Z", appRecord[1].created_at)

		XCTAssertEqual("2018-02-09T16:17:43.000Z", appRecord[0].updated_at)
		XCTAssertEqual("2018-01-05T15:47:43.000Z", appRecord[1].updated_at)

		XCTAssertEqual(testOwnerId, appRecord[0].owner.id)
		XCTAssertEqual(testOwnerId, appRecord[1].owner.id)

		XCTAssertNil(appRecord[0].owner.avatar_url)
		XCTAssertNil(appRecord[1].owner.avatar_url)

		XCTAssertNil(appRecord[0].owner.email)
		XCTAssertNil(appRecord[1].owner.email)

		XCTAssertEqual(testOrgName, appRecord[0].owner.name)
		XCTAssertEqual(testOrgName, appRecord[1].owner.name)

		XCTAssertEqual(testOrgName, appRecord[0].owner.display_name)
		XCTAssertEqual(testOrgName, appRecord[1].owner.display_name)

		XCTAssertEqual("org", appRecord[0].owner.type)
		XCTAssertEqual("org", appRecord[1].owner.type)

		XCTAssertNil(appRecord[0].azure_subscription)
		XCTAssertNil(appRecord[1].azure_subscription)

		XCTAssertEqual(1, appRecord[0].member_permissions.count)
		XCTAssertEqual(1, appRecord[1].member_permissions.count)

		XCTAssertEqual("manager", appRecord[0].member_permissions[0])
		XCTAssertEqual("manager", appRecord[1].member_permissions[0])
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
