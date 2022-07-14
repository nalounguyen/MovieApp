//
//  ApiRequest.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

/// Rest API methods (GET/PUT/POST/DELETE)
public enum ApiMethod: String {
    case get = "GET", put = "PUT", post = "POST", delete = "DELETE"
}

/// Rest API protocol
protocol ApiRequest {
    var method: ApiMethod { get }
    var path: String { get }
    var parameters: [String : String] { get }
    var body: [String: Any] { get }
}

extension ApiRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method == .post || method == .put {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
