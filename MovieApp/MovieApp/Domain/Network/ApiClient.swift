//
//  ApiClient.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

struct ApiClient {
    private static let baseURL = URL(string: Environment.REST_URL)!
    
    // MARK: - ApiClient
    static func execute<T: Codable>(apiRequest: ApiRequest, completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        let ep = ApiClient.baseURL
        let request = apiRequest.request(with: ep)
        let myDelegate: MySession? = MySession()
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: myDelegate, delegateQueue: nil)
        
        let headerJson = request.allHTTPHeaderFields?.json ?? [String:String]().json
        let bodyJson = apiRequest.body.json
        let paramsJson = apiRequest.parameters.json
        
        print("\n\n ⚡️ ⚡️ ⚡️ REQUEST INFO ⚡️ ⚡️ ⚡️ \n ===[\(type(of: apiRequest))]===[\(apiRequest.path)]======[Info]: \n Method: \(apiRequest.method.rawValue) \n Header: \(headerJson) \n Parameters:\(paramsJson) \n Body: \(bodyJson)")
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let e = error {
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.failure(.noInternetAccess))
                }else {
                    completionHandler(.failure(.internalError(message: e.localizedDescription)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(CustomError.networkRequestError))
                return
            }
            
            // NOTE: Request timeout
            if httpResponse.statusCode == -1001  {
                print("\n\n⛔️ ⛔️ ⛔️ REQUEST ERROR ⛔️ ⛔️ ⛔️\n ===[\(type(of: apiRequest))]===[\(apiRequest.path)]===[\(httpResponse.allHeaderFields["tracer"] ?? "")]===[info]: \n Request TimeOut")
                completionHandler(.failure(.requestTimeOut))
                
                // NOTE: Error from server
            } else if httpResponse.statusCode >= 300 {
                print("\n\n⛔️ ⛔️ ⛔️ REQUEST ERROR ⛔️ ⛔️ ⛔️\n ===[\(type(of: apiRequest))]===[\(apiRequest.path)]===[info]: \n \(httpResponse.statusCode) Server Error")
                completionHandler(.failure(.serverError(message: "\(httpResponse.statusCode) Server Error")))
                
                // NOTE: Get response and parse it
            } else {
                do {
                    let dict = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String : Any]
                    print("\n\n💦 💦 💦 RESPONSE 💦 💦 💦 \n ===[\(apiRequest.path)]===[dict]: \n\(String(describing: dict))")
                    
                    let response = try JSONDecoder().decode(T.self, from: data ?? Data())
                    completionHandler(.success(response))
                } catch let error {
                    let dict = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String : Any]
                    print("\n\n⛔️ ⛔️ ⛔️ PARSE ERROR ⛔️ ⛔️ ⛔️ \n ===[\(type(of: apiRequest))]===[\(apiRequest.path)]===[info]: \n \(String(describing: dict))===Error===: \(error)")
                    completionHandler(.failure(.internalError(message: error.localizedDescription)))
                }
            }
        }
        dataTask.resume()

    }
}

class MySession: NSObject, URLSessionTaskDelegate {
    // Disable auto redirect url
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            completionHandler(nil)
        }
}
