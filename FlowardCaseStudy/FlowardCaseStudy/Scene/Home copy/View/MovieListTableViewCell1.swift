//
//  MovieListTableViewCell.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 25/08/2021.
//

import UIKit
import Kingfisher


class MovieListTableViewCell1: UITableViewCell, Configurable {
    
    private enum Constants {
        static let crewTitle = "Crew"
    }

    var model: Item?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.viewBackgroundColor)
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.7
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var movieTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var movieYearLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemYellow
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var movieCrewTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemYellow
        lbl.text = Constants.crewTitle
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lbl
    }()
    
    private lazy var movieCrewLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 3
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lbl
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratinglbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MovieListTableViewCell1 {
    
    func configureWithModel(_ model: Item) {
        self.model = model
        self.setData()
        
        containerView.alpha = 0.1
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
            [weak self] in
            self?.containerView.alpha = 1.0
        })
        
    }
}

private extension MovieListTableViewCell1 {
    
    func setupView() {
        
        // view for rating label
        ratingView.addSubview(ratinglbl)
        
        // Used individual item instead of Stack view just to show command on layouts,
        // otherwise can use stack views here.
        
        containerView.addSubview(movieImage)
        containerView.addSubview(ratingView)
        containerView.addSubview(movieTitleLbl)
        containerView.addSubview(movieYearLbl)
        containerView.addSubview(movieCrewTitleLbl)
        containerView.addSubview(movieCrewLbl)
        
        contentView.addSubview(containerView)
                
        NSLayoutConstraint.activate([
            
            ratinglbl.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 8),
            ratinglbl.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 8),
            ratinglbl.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -8),
            ratinglbl.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: -8),

            movieImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            movieImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            movieImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            movieImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.33),
            movieImage.heightAnchor.constraint(equalToConstant: 160),
            
            movieTitleLbl.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 4),
            movieTitleLbl.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            movieTitleLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            movieYearLbl.topAnchor.constraint(equalTo: movieTitleLbl.bottomAnchor, constant: 4),
            movieYearLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor),
            movieYearLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor),
            
            movieCrewTitleLbl.bottomAnchor.constraint(equalTo: movieCrewLbl.topAnchor, constant: -4),
            movieCrewTitleLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor),
            
            movieCrewLbl.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -4),
            movieCrewLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor),
            movieCrewLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor),

            ratingView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor),
            ratingView.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    
    func setData() {
        
        guard let model = model else { return }
        movieTitleLbl.text = model.fullTitle
        movieYearLbl.text = model.year
        ratinglbl.text = model.imdbRating
        movieCrewLbl.text = model.crew?.replacingOccurrences(of: ", ", with: "\n")
        setImage(imageUrlStr: model.image ?? "")
    }
    
    func setImage(imageUrlStr: String) {
        
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(
            with: URL(string: imageUrlStr),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
        ])
    }
}
 



