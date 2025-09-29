//
//  MovieCollectionViewCell.swift
//  SeSAC7LaunchProject
//
//  Created by andev on 9/29/25.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let id = "MovieCollectionViewCell"
    
    //let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        //contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
    }
    
    private func configureLayout() {
//        posterImageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview()
//            make.height.equalTo(contentView.snp.width).multipliedBy(1.3)
//        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.top.equalTo(posterImageView.snp.bottom).offset(6)
//            make.horizontalEdges.equalToSuperview().inset(4)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.bottom.equalToSuperview().inset(4)
        }
    }
    
    private func configureView() {
//        posterImageView.contentMode = .scaleAspectFill
//        posterImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textColor = .secondaryLabel
        ratingLabel.textAlignment = .left
    }
    
    func configure(image: UIImage?, title: String, rating: Double) {
        //posterImageView.image = image
        titleLabel.text = title
        ratingLabel.text = String(format: "⭐️ %.1f", rating)
    }
}
