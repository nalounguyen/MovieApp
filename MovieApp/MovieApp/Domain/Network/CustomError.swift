//
//  CustomError.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

enum CustomError: Error {
    case noInternetAccess
    
    /// We can't even reach the API
    case networkRequestError
    
    /// The request timed out
    case requestTimeOut
    
    /// Server Error
    case serverError(message: String)
    
    /// Error internal app for checking root cause.
    case internalError(message: String)
}
