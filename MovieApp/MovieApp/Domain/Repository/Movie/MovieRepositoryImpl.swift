//
//  MovieRepositoryImpl.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    func getListMovies(keyword: String,
                       type: MovieType,
                       page: Int,
                       completionHandler: @escaping (Result<GetListMoviesResponse, CustomError>) -> Void) {
        let req = GetListMoviesRequest(keyword: keyword, type: type, page: page)
        ApiClient.execute(apiRequest: req, completionHandler: completionHandler)
    }
}

