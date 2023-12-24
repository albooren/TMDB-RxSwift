//
//  PopularListViewModel.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import RxSwift
import RxCocoa

final class PopularListViewModel {
    
    var popularSeriesList: [PopularSeriesModel] = []
    var publishlist = PublishSubject<[PopularSeriesModel]>()
    
    private var page = 1
    private var maxPage = 1
    private var nowPlayingMaxPageNumber = 1
    
    func getData() {
        networkManager.request(url: API.shared.getURL(with: Endpoints.popularTVSeries.rawValue,
                                                      page: page),
                               requestMethod: .get) { (result: Result<ResponseDataModel, Error>) in
            switch result {
            case .success(let response):
                self.maxPage = response.totalPages ?? 1
                //to avoid duplicate and empty data
                let newData = response.results?.filter { series in
                    return !self.popularSeriesList.contains(where: {$0.id == series.id}) && series.overview != ""
                }
                self.popularSeriesList.append(contentsOf: newData ?? [])
                self.publishlist.onNext(self.popularSeriesList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func currentPage() -> Int {
        return page
    }
    
    func pageUp() {
        page += 1
    }
    
    func canLoadMore() -> Bool {
        return maxPage > page
    }
}
