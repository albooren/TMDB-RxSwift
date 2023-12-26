//
//  API.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import Foundation

enum Endpoints : String {
    case popularTVSeries = "/3/tv/popular"
}

final class API {
    static let shared = API()
    
    func getURL(with endpoint:String,page:Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = endpoint
        let queryParams:[URLQueryItem] = [URLQueryItem(name: "language", value: currentLanguageCode),
                                          URLQueryItem(name: "page", value: String(page))]
        components.queryItems = queryParams
        return components.url
    }
    
    func getImageURL(with imageURL:String) -> URL? {
        let baseURL = "https://image.tmdb.org/t/p/w300"
        return URL(string: baseURL + imageURL)
    }
}
