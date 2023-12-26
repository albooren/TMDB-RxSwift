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
    
    func rxRequest<T: Decodable>(url: URL?, requestMethod: HTTPMethod) -> Observable<T> {
        return Observable.create { observer in
            guard let url = url else { return Disposables.create() }
            
            let headers: HTTPHeaders = ["accept": "application/json", "Authorization": apikey]
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            AF.request(url, method: requestMethod, headers: headers)
                .validate()
                .responseDecodable(of: T.self, decoder: decoder) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
