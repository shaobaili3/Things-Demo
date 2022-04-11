//
//  NetworkService.swift
//  homeProject
//
//  Created by SHAOBAI LI on 28.03.22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case decodingError
    case domainError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T,  NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage,  NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                completion(.failure(.domainError))
                return
            }
            DispatchQueue.main.async() {
                completion(.success(image))
            }
        }.resume()
    }
}
