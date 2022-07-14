//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: BaseViewController {
    var viewModel: MoviewListViewModel!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var isWating = false
    
    private lazy var searchController: UISearchController = {
        let searchView = UISearchController(searchResultsController: nil)
        searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.placeholder = "What movie do you want to search"
        return searchView
    }()
    
    
    override func viewDidLoad() {
        MoviewListConfigurer.configure(vc: self)
        super.viewDidLoad()
        collectionView.register(MovieThumnailCollectionViewCell.nib,
                                forCellWithReuseIdentifier: MovieThumnailCollectionViewCell.identifier)
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override func setupView() {
        title = "List Movie"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        let back = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let backButton: UIBarButtonItem = UIBarButtonItem(image: back, style:.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func bindingViewModel() {
        searchController.searchBar
            .rx
            .text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] keyword in
                self?.viewModel.onSearchMovie(keyword: keyword ?? "")
            })
            .disposed(by: disposeBag)
        
        viewModel.movieList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.isWating = false
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}


extension MovieListViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.resignFirstResponder()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let height = size * 448 / 300
        return CGSize(width: size, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieThumnailCollectionViewCell.identifier, for: indexPath) as! MovieThumnailCollectionViewCell
        cell.displayData(movie: viewModel.movieList.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //NOTE: check and load more data
        if indexPath.row == viewModel.movieList.value.count - 4, !isWating {
            isWating = true
            viewModel.loadMore()
        }
    }
}
