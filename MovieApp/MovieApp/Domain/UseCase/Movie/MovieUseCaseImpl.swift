//
//  MovieUseCaseImpl.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

class MovieUseCaseImpl: MovieUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getListMovies(keyword: String,
                       type: MovieType,
                       page: Int,
                       completionHandler: @escaping ([MovieModel]) -> Void) {
        let emptyList = [MovieModel]()
        guard !keyword.isEmpty,
        page > 0 else {
            completionHandler(emptyList)
            return
        }
        repository.getListMovies(keyword: keyword, type: type, page: page) { result in
            switch result {
            case .failure(let err):
                completionHandler(emptyList)
                
            case .success(let value):
                completionHandler(value.movieList ?? emptyList)
            }
        }
    }
}
