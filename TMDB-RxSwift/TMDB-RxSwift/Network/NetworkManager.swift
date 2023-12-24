//
//  NetworkManager.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import Foundation

typealias RequestCompletion<T> = (Result<T, Error>) -> Void

enum Endpoints : String {
    case popularTVSeries = "/3/tv/popular"
}

enum HTTPMethods: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}


import RxSwift
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Decodable>(url: URL?, requestMethod: HTTPMethods, onComplete: @escaping RequestCompletion<T>) {
        guard let url = url else { return }
        
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": apikey]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: HTTPMethod(rawValue: requestMethod.rawValue), headers: headers)
            .validate()
            .responseDecodable(of: T.self,decoder: decoder) { response in
                switch response.result {
                case .success(let value):
                    onComplete(.success(value))
                case .failure(let error):
                    onComplete(.failure(error))
                }
            }
    }
    
    
    
    
    
    
    func getURL(with endpoint:String,page:Int?=nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = endpoint
        var queryParams:[URLQueryItem] = []
        queryParams.append(URLQueryItem(name: "language", value: "en-US"))
        if let page {
            queryParams.append(URLQueryItem(name: "page", value: String(page)))
        }
        components.queryItems = queryParams
        return components.url
    }
    
    func getImageURL(with imageURL:String) -> URL? {
        let baseURL = "https://image.tmdb.org/t/p/original"
        return URL(string: baseURL + imageURL)
    }
}
