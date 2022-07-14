//
//  MovieThumnailCollectionViewCell.swift
//  Movie
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import UIKit
import Kingfisher

class MovieThumnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var wrapTitleView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
        
    @IBOutlet weak var gradientView: GradientView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        wrapTitleView.backgroundColor = .clear
        wrapView.layer.cornerRadius = 6
        gradientView.startColor = .black.withAlphaComponent(0.8)
        gradientView.endColor = .gray.withAlphaComponent(0.8)
    }

    func displayData(movie: MovieModel) {
        let image = UIImage(named: "image")
        imgMovie.kf.setImage(with: movie.posterURL, placeholder: image)
        lbTitle.text = movie.title
    }
    
}
