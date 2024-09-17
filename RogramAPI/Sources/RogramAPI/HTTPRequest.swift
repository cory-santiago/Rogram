//
//  HTTPRequest.swift
//
//
//  Created by Cory Santiago on 9/16/24.
//

import Foundation

/// HTTP request object for making a HTTP call. Defines the base URL, path, and all the necessary parameters for a HTTP request.
public struct HTTPRequest {
    public var baseURL: URL
    public var path: String
    public var method: String
    public var queryParameters: [String: String]?
    public var headers: [String: String]?
    public var body: [String: Any]?

    public init(baseURL: URL,
                path: String,
                method: String,
                headers: [String: String]? = nil,
                body: [String: Any]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
}

public extension HTTPRequest {
    var endpoint: URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return baseURL.appendingPathComponent(path)
        }

        components.path.append(path)
        let queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = queryItems
        return components.url ?? baseURL.appendingPathComponent(path)
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: endpoint)
        // request.httpMethod = method.rawValue

//        for header in defaultHeaders {
//            request.setValue(header.value, forHTTPHeaderField: header.key)
//        }

        if let headers = headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        if let body = body {
            let bodyData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = bodyData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
    
