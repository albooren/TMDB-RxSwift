//
//  NetworkManager.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

typealias RequestCompletion<T> = (Result<T, Error>) -> Void

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
}
