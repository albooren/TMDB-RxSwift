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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Populer Series"
    }
    
    override func initUI(){
        super.initUI()
        mainView.addSubview(popularSeriesListCV)
        popularSeriesListCV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
