//
//  SimpleViweController.swift
//  SeSAC7LaunchProject
//
//  Created by andev on 9/29/25.
//

import UIKit
import SnapKit
import Kingfisher

struct MovieItem {
    let title: String
    let rating: Double
    let imageURL: URL?
}

final class SimpleViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var movies: [MovieItem] = [
        MovieItem(title: "Interstellar", rating: 8.6, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg")),
        MovieItem(title: "Inception", rating: 8.3, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg")),
        MovieItem(title: "Parasite", rating: 8.5, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg")),
        MovieItem(title: "The Dark Knight", rating: 8.4, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg")),
        MovieItem(title: "Avengers: Endgame", rating: 8.3, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg")),
        MovieItem(title: "La La Land", rating: 8.0, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg")),
        MovieItem(title: "Joker", rating: 8.2, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg")),
        MovieItem(title: "Forrest Gump", rating: 8.8, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/saHP97rTPS5eLmrLQEcANmKrsFl.jpg")),
        MovieItem(title: "The Matrix", rating: 8.7, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg")),
        MovieItem(title: "Pulp Fiction", rating: 8.9, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/dM2w364MScsjFf8pfMbaWUcWrR.jpg")),
        MovieItem(title: "Fight Club", rating: 8.8, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/a26cQPRhJPX6GbWfQbvZdrrp9j9.jpg")),
        MovieItem(title: "Titanic", rating: 7.9, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg")),
        MovieItem(title: "The Lion King", rating: 8.5, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg")),
        MovieItem(title: "Toy Story", rating: 8.3, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg")),
        MovieItem(title: "The Godfather", rating: 9.2, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg")),
        MovieItem(title: "Schindler's List", rating: 8.9, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg")),
        MovieItem(title: "Spirited Away", rating: 8.6, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/oRvMaJOmapypFUcQqpgHMZA6qL9.jpg")),
        MovieItem(title: "The Shawshank Redemption", rating: 9.3, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg")),
        MovieItem(title: "Whiplash", rating: 8.5, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/oPxnRhyAIzJKGUEdSiwTJQBa6xU.jpg")),
        MovieItem(title: "Coco", rating: 8.4, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/gGEsBPAijhVUFoiNpgZXqRVWJt2.jpg"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "영화 3열 그리드"

        configureCollectionView()
    }
    
    /*
     Item: 셀 하나를 의미. 셀 크기와 컨텐츠 영역을 정의
     Group: 셀들의 집합. 방향(수직, 수평)과 레이아웃 정의
     Section: 그룹들의 모음
     Layout: 전체 컬렉션뷰의 최종 레이아웃
     */
    
    //1. 수직
//    private static func layout() -> UICollectionViewLayout {
//        
//        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        //section.interGroupSpacing = 50
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    //2. 수평
//    private static func layout() -> UICollectionViewLayout {
//        
//        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(100))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        //section.interGroupSpacing = 50
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    //3. 그룹 중첩
//    private static func layout() -> UICollectionViewLayout {
//        
//        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        
//        let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitems: [item])
//        
//        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(400))
//        
//        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [innerGroup])
//        
//        let section = NSCollectionLayoutSection(group: outerGroup)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        //section.interGroupSpacing = 50
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    //4. 여러 섹션
    private static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            
            if index == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                
                let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitems: [item])
                
                let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(400))
                
                let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [innerGroup])
                
                let section = NSCollectionLayoutSection(group: outerGroup)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        
        return layout
    }
    
    private func configureCollectionView() {
//        let spacing: CGFloat = 10
//        let numberOfColumns: CGFloat = 3
//        let width = (view.bounds.width - (numberOfColumns + 1) * spacing - 10) / numberOfColumns
//        let height = width * 1.6
//
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.minimumInteritemSpacing = spacing
//        layout.minimumLineSpacing = spacing
//        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
//        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: SimpleViewController.layout())
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SimpleViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.id,
            for: indexPath
        ) as! MovieCollectionViewCell
        let movie = movies[indexPath.item]
        
        // Kingfisher를 사용해 이미지뷰에 이미지 세팅
//        cell.posterImageView.kf.setImage(
//            with: movie.imageURL,
//            placeholder: UIImage(systemName: "film")
//        )
        cell.titleLabel.text = "\(indexPath)"
        cell.ratingLabel.text = String(format: "⭐️ %.1f", movie.rating)
        cell.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return cell
    }
}
