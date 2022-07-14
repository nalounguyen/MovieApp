//
//  MoviewListViewModel.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoviewListViewModel {
    var movieList: BehaviorRelay<[MovieModel]> { get }
    
    /// The first time to get movie list
    func onSearchMovie(keyword: String)
    
    /// Load more movies
    func loadMore()
}

class MoviewListViewModelImpl: MoviewListViewModel {
    private let movieUseCase: MovieUseCase
    private let movieListSubject = BehaviorRelay<[MovieModel]>(value: [])
    
    private var page: Int = 1
    private var keyword: String = ""
    
    
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        subscribe()
    }
    
    var movieList: BehaviorRelay<[MovieModel]> {
        return movieListSubject
    }
    
    func onSearchMovie(keyword: String) {
        self.keyword = keyword
        guard !keyword.isEmpty else {
            movieListSubject.accept([])
            return
        }
        
        page = 1
        movieUseCase.getListMovies(keyword: keyword, type: .movie, page: page) { [weak self] list in
            self?.movieListSubject.accept(list)
        }
    }
    
    func loadMore() {
        guard !keyword.isEmpty else {
            return
        }
        page += 1
        movieUseCase.getListMovies(keyword: keyword, type: .movie, page: page) { [weak self] list in
            guard let self = self,
                  !list.isEmpty else { return }
            
            var currentList = self.movieListSubject.value
            currentList.append(contentsOf: list)
            self.movieListSubject.accept(currentList)
        }
    }
    
    private func subscribe() { }
}
