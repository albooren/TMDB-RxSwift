//
//  PopularSeriesListViewController.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import RxSwift
import RxCocoa

class PopularSeriesListViewController: BaseViewController {
    
    let viewModel = PopularListViewModel()
    
    private var popularSeriesListCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth,
                                     height: 140)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.clear
        cv.register(PopularSeriesListCVCell.self,
                    forCellWithReuseIdentifier: "popularSeriesListCVCell")
        return cv
    }()
    
    private var popularSeriesListCVPagining = false
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Populer Series"
        bindCollectionView()
    }
    
    override func initUI(){
        super.initUI()
        mainView.addSubview(popularSeriesListCV)
        popularSeriesListCV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func loadMoreData(){
        makeLoader()
        viewModel.pageUp()
        viewModel.getData()
    }
    
    func bindCollectionView(){
        viewModel.publishlist.bind(to: popularSeriesListCV.rx.items(cellIdentifier: "popularSeriesListCVCell",
                                                                    cellType: PopularSeriesListCVCell.self)
        ) { row,data,cell in
            self.dismissLoader()
            self.popularSeriesListCVPagining = false
            cell.fillWith(movieName: data.name ?? "",
                          movieShortDesc: data.overview ?? "",
                          imageURL: API.shared.getImageURL(with: data.posterPath ?? ""),
                          vote: data.voteAverage ?? 0)
        }.disposed(by: bag)
        
        handleScrollToLoadMoreSeries()
        handleSeriesTapped()
        
        makeLoader()
        viewModel.getData()
    }
    
    func handleSeriesTapped(){
        popularSeriesListCV.rx.modelSelected(PopularSeriesModel.self).bind { movie in
            let detail = DetailViewController()
            detail.fillWith(image: movie.posterPath ?? "",
                            name: movie.name ?? "",
                            desc: movie.overview ?? "",
                            date: movie.firstAirDate ?? "",
                            vote: movie.voteAverage ?? 0)
            self.navigationController?.pushViewController(detail, animated: true)
        }.disposed(by: bag)
    }
    
    func handleScrollToLoadMoreSeries(){
        popularSeriesListCV.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .map({ ($0.cell as? PopularSeriesListCVCell, $0.at.item) })
            .subscribe { [weak self] cell, indexPath in
                guard let self = self else { return }
                if indexPath > self.viewModel.popularSeriesList.count - 5 {
                    if self.viewModel.canLoadMore(),!self.popularSeriesListCVPagining {
                        self.popularSeriesListCVPagining = true
                        self.loadMoreData()
                    }
                }
            }
            .disposed(by: bag)
    }
}
