//
//  ImageNetworkManager.swift
//  SeSAC7LaunchProject
//
//  Created by andev on 9/24/25.
//

import UIKit

enum JackError: Error {
    case invalidResponse
    case unknown
    case invalidImage
}

class ImageNetworkManager {
    
    static let shared = ImageNetworkManager()
    
    private init() { }
    
    static let url = URL(string: "https://picsum.photos/200/300")!
    
    func fetchThumbnail(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: ImageNetworkManager.url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    func fetchThumbnailURLSession(completion: @escaping (Result<UIImage, JackError>) -> Void) {
        
        let request = URLRequest(url: ImageNetworkManager.url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(.failure(.invalidImage))
                    return
                }
                
                completion(.success(image))
            }
        }.resume()
    }
    
    //Swift concurrency
    //GCD -> 모든 걸 클로저로 해결
    //Swfit concureencty -> 성공했으면 반환, 실패하면 오류를 던짐
    func fetchAsyncAwait() async throws -> UIImage {
        let request = URLRequest(url: ImageNetworkManager.url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 5)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw JackError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw JackError.invalidImage
        }
        
        return image
    }
    
    func fetchAsyncLet() async throws -> [UIImage] {
        async let one = ImageNetworkManager.shared.fetchAsyncAwait()
        async let two = ImageNetworkManager.shared.fetchAsyncAwait()
        async let three = ImageNetworkManager.shared.fetchAsyncAwait()
        
        let result = try await [one, two, three] // == GCD notify
        
        return result
    }
    
    //async let 대신, 횟수가 정해지지 않은 통신을 동시에 수행하려면
    func fetchTaskGroup() async throws -> [UIImage] {
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            for i in 1...10 {
                group.addTask {
                    try await ImageNetworkManager.shared.fetchAsyncAwait()
                }
            }
            
            var resultImage: [UIImage] = []
            
            for try await i in group {
                resultImage.append(i)
            }
            
            return resultImage
        }
    }
}
