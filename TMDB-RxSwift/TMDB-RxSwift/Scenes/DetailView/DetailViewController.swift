//
//  DetailViewController.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import SDWebImage

final class DetailViewController: BaseViewController {
    
    var viewModel:DetailViewModel?
    
    private var posterImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private let imdbLogo : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "IMDBLogo"))
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private let starIcon : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "starIcon"))
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private var voteLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = FontManager.fontMedium(15)
        return label
    }()
    
    private var dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = FontManager.fontMedium(15)
        return label
    }()
    
    private var movieNameLabel : UILabel = {
        let label = UILabel()
        label.font = FontManager.fontBold(20)
        return label
    }()
    
    private var movieDescriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontManager.fontRegular(15)
        return label
    }()
    
    private let dotView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func initUI() {
        super.initUI()
        navigationController?.navigationBar.tintColor = UIColor.label
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        mainView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.width.height.equalTo(screenWidth)
        })
        
        scrollView.addSubview(imdbLogo)
        imdbLogo.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(49)
            make.height.equalTo(24)
        })
        
        scrollView.addSubview(starIcon)
        starIcon.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(imdbLogo.snp.right).offset(8)
            make.centerY.equalTo(imdbLogo)
            make.width.height.equalTo(16)
        })
        
        scrollView.addSubview(voteLabel)
        voteLabel.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(starIcon.snp.right).offset(8)
            make.centerY.equalTo(starIcon)
        })
        
        scrollView.addSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.height.width.equalTo(4)
            make.left.equalTo(voteLabel.snp.right).offset(8)
            make.centerY.equalTo(voteLabel)
        }
        
        scrollView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(dotView.snp.right).offset(8)
            make.centerY.equalTo(starIcon)
        })
        
        scrollView.addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints({ make in
            make.top.equalTo(imdbLogo.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(16)
        })
        
        scrollView.addSubview(movieDescriptionLabel)
        movieDescriptionLabel.snp.makeConstraints({ make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-20)
        })
    }
    
    private func updateUI() {
        posterImageView.sd_setImage(with: viewModel?.getImageURL())
        movieNameLabel.text = viewModel?.getSeriesName()
        voteLabel.attributedText = viewModel?.getSeriesVote()
        dateLabel.text = viewModel?.getSeriesReleaseDate()
        movieDescriptionLabel.text = viewModel?.getSeriesDescription()
    }
}
