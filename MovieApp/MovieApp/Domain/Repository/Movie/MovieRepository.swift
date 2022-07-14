//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation


protocol MovieRepository {
    func getListMovies(keyword: String,
                       type: MovieType,
                       page: Int,
                       completionHandler: @escaping (Result<GetListMoviesResponse, CustomError>) -> Void)
}
