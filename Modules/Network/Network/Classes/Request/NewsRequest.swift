//
//  NewsRequest.swift
//  Home
//
//  Created by Savvycom2021 on 15/08/2022.
//

import Foundation

public class NewsRequest: RequestType {
    public var path = "v2/everything"
    public var method: HTTPMethod = .get
    public var headerParams: [String : Any]?
    public var bodyParams: [String : Any]?
    
    public init(keyword: String?, page: Int, pageSize: Int) {
        bodyParams = ["apiKey": "e46c1268e5da41398785dd7fd0259168",
                      "page": page,
                      "pageSize": pageSize]
        if let keyword = keyword, !keyword.isEmpty {
            bodyParams?["q"] = keyword
        } else {
            bodyParams?["q"] = "q"
        }
    }
}
