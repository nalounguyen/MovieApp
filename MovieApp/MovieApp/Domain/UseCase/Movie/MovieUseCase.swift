//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

protocol MovieUseCase {
    /// Get movie list with keyword
    func getListMovies(keyword: String,
                       type: MovieType,
                       page: Int,
                       completionHandler: @escaping ([MovieModel]) -> Void)
}
