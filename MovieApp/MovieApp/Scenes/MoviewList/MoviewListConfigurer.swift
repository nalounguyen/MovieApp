//
//  MoviewListConfigurer.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation

struct MoviewListConfigurer {
    static func configure(vc: MoviewListViewController) {
        let mu = MovieUseCaseImpl(repository: MovieRepositoryImpl())
        let vm = MoviewListViewModelImpl(movieUseCase: mu)
        vc.viewModel = vm 
        
    }
}
