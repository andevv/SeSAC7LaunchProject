//
//  ViewController.swift
//  SeSAC7LaunchProject
//
//  Created by andev on 9/24/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var oneImageView: UIImageView!
    @IBOutlet var twoImageView: UIImageView!
    @IBOutlet var threeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        ImageNetworkManager.shared.fetchThumbnail { image in
        //            print("1111")
        //            self.oneImageView.image = image
        //        }
        //
        //        ImageNetworkManager.shared.fetchThumbnail { image in
        //            print("2222")
        //            self.twoImageView.image = image
        //        }
        //
        //        ImageNetworkManager.shared.fetchThumbnail { image in
        //            print("3333")
        //            self.threeImageView.image = image
        //        }
        
        //        //URLSession + GCD
        //        ImageNetworkManager.shared.fetchThumbnailURLSession { response in
        //            switch response {
        //            case .success(let success):
        //                self.oneImageView.image = success
        //            case .failure(let failure):
        //                self.oneImageView.image = UIImage(systemName: "star.fill")
        //            }
        //        }
        
        //DispatchQueue.global().async == Task
        //        Task {
        //            oneImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
        //            print("1111")
        //            twoImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
        //            print("2222")
        //            threeImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
        //            print("3333")
        //        }
        
        //GCD DispatchGroup처럼 여러 비동기 메서드를 동시에 실행
        //Swift Concurrency async let
        Task {
            
            let result = try await ImageNetworkManager.shared.fetchAsyncLet()
            
            oneImageView.image = result[0]
            twoImageView.image = result[1]
            threeImageView.image = result[2]
        }
    }
    
    
}

