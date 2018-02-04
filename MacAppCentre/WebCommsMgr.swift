//
//  WebCommsMgr.swift
//  MacAppCentre
//
//  Created by Mark Hoggatt on 03/02/2018.
//  Copyright © 2018 Mark Hoggatt. All rights reserved.
//

import Foundation

class WebCommsMgr
{
	let acceptHeader : String = "application/json"
	let apiTokenKey : String = "X-API-Token"

	var jsonResponseDelegate : JsonRepondable?

	func MakeRequestToServer(atUrl url: String, withContent content : String, usingToken token : String)
	{
		guard let sourceUrl = URL(string: url)
		else
		{
			return
		}

		var request = URLRequest(url: sourceUrl)
		request.httpMethod = "GET"
		request.setValue(acceptHeader, forHTTPHeaderField: "accept")
		request.addValue(token, forHTTPHeaderField: apiTokenKey)
		if content.isEmpty == false
		{
			request.httpBody = content.data(using: .utf8)
		}

		let dataTask = URLSession.shared.dataTask(with: request)
		{ (recvdData : Data?, urlResp : URLResponse?, err : Error?) -> Void in
			if err != nil
			{
				NSLog("Web request failed: \(err!.localizedDescription)")
				return
			}

			guard self.jsonResponseDelegate != nil,
					recvdData != nil
			else
			{
				return
			}

			self.jsonResponseDelegate!.DidRespondWithJson(jsonData: recvdData!)
		}

		dataTask.resume()
	}
}
