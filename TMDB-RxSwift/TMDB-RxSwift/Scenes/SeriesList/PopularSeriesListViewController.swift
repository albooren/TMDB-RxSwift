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
        
        popularSeriesListCV.delegate = self
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
                          imageURL: networkManager.getImageURL(with: data.posterPath ?? ""),
                          vote: data.voteAverage ?? 0)
        }.disposed(by: bag)
        
        makeLoader()
        viewModel.getData()
    }
}

extension PopularSeriesListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item > viewModel.popularSeriesList.count - 5 {
            if viewModel.canLoadMore(),!popularSeriesListCVPagining {
                    popularSeriesListCVPagining = true
                    loadMoreData()
            }
        }
    }
}
