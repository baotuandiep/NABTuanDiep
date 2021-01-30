//
//  APIManager.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

enum ErrorType {
    case dataError
    case clientError
    case serverError
    case noData
    case unknow
}

enum APIResult<T> {
    case success(T)
    case error(ErrorType)
}

class APIManager {
    static let shared = APIManager()
    
    private let host = "api.openweathermap.org"
    private let scheme = "https"
    
    private let urlSession = URLSession.shared

    private init() {}
    
    func loadData<T: Codable>(type: T.Type, path: String, queryParams: [String :Any], completion: @escaping ((APIResult<T>) -> Void)) {
        guard let url = url(path: path, queryParams: queryParams) else {
            return completion(.error(.clientError))
        }
        handleRequest(type: type, url: url, completion: completion)
    }
    
    private func handleRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping ((APIResult<T>) -> Void)) {
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(.unknow))
            }
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        print(result)
                        completion(.success(result))
                    } catch {
                        print(error)
                        completion(.error(.dataError))
                    }
                } else {
                    completion(.error(.noData))
                }
            case 400...499:
                completion(.error(.clientError))
            case 500...599:
                completion(.error(.serverError))
            default:
                completion(.error(.unknow))
            }
        }
        task.resume()
    }
    
    private func url(path: String, queryParams: [String: Any]) -> URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryParams.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        return urlComponent.url
    }
}
