//
//  APIManager.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

enum ErrorType {
    case requestError(String)
    case dataError
    case clientError
    case serverError
    case noData
    case unknow
    
    var value: String {
        switch self {
        case .dataError:
            return "Data Error"
        case .clientError:
            return "Data Format Error"
        case .serverError:
            return "Somethings wrong with our server"
        case .noData:
            return "No data"
        case .unknow:
            return "Unknow error"
        case .requestError(let string):
            return string
        }
    }
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
                return completion(.error(.requestError(error.localizedDescription)))
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
            case 404:
                completion(.error(.noData))
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
        urlComponent.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
        return urlComponent.url
    }
    
    private var apiKey: String {
        let obfuscator = Obfuscator()
        return obfuscator.reveal(key: [119, 64, 19, 114, 3, 14, 0, 5, 85, 22, 92, 125, 50, 44, 84, 95, 86, 0, 64, 120, 66, 18, 37, 93, 92, 83, 1, 2, 71, 81, 120, 55])
    }
}
