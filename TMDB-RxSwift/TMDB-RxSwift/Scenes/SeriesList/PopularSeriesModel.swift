//
//  PopularSeriesModel.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

struct ResponseDataModel: Decodable {
    let results: [PopularSeriesModel]?
    let page,totalPages, totalResults: Int?
}

struct PopularSeriesModel: Decodable {
    let id: Int?
    let overview,posterPath, firstAirDate, name: String?
    let voteAverage: Double?
}
