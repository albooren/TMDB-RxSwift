//
//  PopularSeriesListViewController.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class PopularSeriesListViewController: BaseViewController {
    
    private let viewModel = PopularListViewModel()
    private let bag = DisposeBag()
    private var popularSeriesListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth,
                                     height: 140)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(PopularSeriesListCollectionViewCell.self,
                                forCellWithReuseIdentifier: PopularSeriesListCollectionViewCell.id)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Series"
        bindCollectionView()
    }
    
    override func initUI(){
        super.initUI()
        mainView.addSubview(popularSeriesListCollectionView)
        popularSeriesListCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bindCollectionView(){
        viewModel.publishlist
            .bind(to: popularSeriesListCollectionView.rx.items(cellIdentifier: PopularSeriesListCollectionViewCell.id,
                                                               cellType: PopularSeriesListCollectionViewCell.self)) {[weak self] _, data, cell in
                guard let self = self else { return }
                self.dismissLoader()
                let itemData = PopularSeriesItem(movieName: data.name ?? "",
                                                 movieShortDesc: data.overview ?? "",
                                                 imageURL: API.shared.getImageURL(with: data.posterPath ?? ""),
                                                 vote: data.voteAverage ?? 0)
                cell.fillWith(item: itemData)
            }.disposed(by: bag)
        
        popularSeriesListCollectionView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .map({ ($0.cell as? PopularSeriesListCollectionViewCell, $0.at.item) })
            .subscribe { [weak self] cell, indexPath in
                guard let self = self else { return }
                if indexPath > self.viewModel.popularSeriesList.count - 5 {
                    if self.viewModel.canLoadMore() {
                        self.loadMoreData()
                    }
                }
            }
            .disposed(by: bag)
        
        popularSeriesListCollectionView.rx.modelSelected(PopularSeriesModel.self)
            .bind {[weak self] movie in
                guard let self = self else { return }
                let detailViewController = DetailViewController()
                let viewModel = DetailViewModel(imageURL: movie.posterPath ?? "",
                                                name: movie.name ?? "",
                                                desc: movie.overview ?? "",
                                                date: movie.firstAirDate ?? "",
                                                vote: movie.voteAverage ?? 0)
                detailViewController.viewModel = viewModel
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }.disposed(by: bag)
        
        presentLoader()
        viewModel.getData()
    }
    
    func loadMoreData(){
        presentLoader()
        viewModel.pageUp()
        viewModel.getData()
    }
}
