//
//  PopularSeriesListCVCell.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import SDWebImage
import RxSwift
import RxRelay

final class PopularSeriesListCollectionViewCell: UICollectionViewCell {
    
    static let id = "popularSeriesListCollectionViewCell"
    
    private lazy var rightArrow = UIImageView()
    private lazy var movieImage : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var movieNameLabel = UILabel()
    private lazy var movieShortDescLabel = UILabel()
    private lazy var movieVoteLabel = UILabel()
    private lazy var underLine = UIView()
    
    private lazy var starIcon : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "starIcon"))
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeCell()
    }
    
    private func makeCell(){
        clipsToBounds = true
        addSubview(movieImage)
        
        movieNameLabel.font = FontManager.fontBold(15)
        addSubview(movieNameLabel)
        
        movieShortDescLabel.numberOfLines = 0
        movieShortDescLabel.textColor = .secondaryLabel
        
        movieShortDescLabel.font = FontManager.fontMedium(13)
        addSubview(movieShortDescLabel)
        
        addSubview(starIcon)
        
        movieVoteLabel.textColor = .gray
        movieVoteLabel.font = FontManager.fontMedium(12)
        addSubview(movieVoteLabel)
        
        rightArrow = UIImageView(image: UIImage(named: "rightArrow")?.withRenderingMode(.alwaysTemplate))
        rightArrow.tintColor = .label
        rightArrow.contentMode = .scaleAspectFill
        addSubview(rightArrow)
        
        underLine.backgroundColor = .separator
        underLine.layer.opacity = 0.5
        addSubview(underLine)
        
        movieImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        rightArrow.snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(10.5)
            make.width.equalTo(6)
        })
        
        movieNameLabel.snp.makeConstraints({ make in
            make.top.equalTo(movieImage.snp.top).offset(8)
            make.left.equalTo(movieImage.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        })
        
        movieShortDescLabel.snp.makeConstraints({ make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            make.bottom.lessThanOrEqualTo(movieVoteLabel.snp.top).offset(-4)
            make.left.equalTo(movieNameLabel)
            make.right.lessThanOrEqualTo(rightArrow.snp.left).offset(-19)
        })
        
        movieVoteLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(movieImage.snp.bottom)
            make.right.equalTo(rightArrow.snp.left).offset(-10)
        })
        
        starIcon.snp.makeConstraints({ make in
            make.top.equalTo(movieVoteLabel)
            make.right.equalTo(movieVoteLabel.snp.left).offset(-8)
            make.centerY.equalTo(movieVoteLabel)
            make.width.height.equalTo(16)
        })
        
        underLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(2)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }
    
    
    func fillWith(item: PopularSeriesItem) {
        Observable.just(item.movieName)
            .bind(to: movieNameLabel.rx.text)
            .disposed(by: bag)
        
        Observable.just(item.movieShortDesc)
            .bind(to: movieShortDescLabel.rx.text)
            .disposed(by: bag)
        
        Observable.just(item.getVoteAttributedString())
            .bind(to: movieVoteLabel.rx.attributedText)
            .disposed(by: bag)
        
        if let imageURL = item.imageURL {
            Observable.just(imageURL)
                .subscribe(onNext: { [weak self] url in
                    guard let self = self else { return }
                    self.movieImage.sd_setImage(with: url)
                })
                .disposed(by: bag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct PopularSeriesItem {
    let movieName: String
    let movieShortDesc: String
    let imageURL: URL?
    let vote: Double
    
    func getVoteAttributedString() -> NSAttributedString {
        let formattedVote = String(format: "%.2f", vote)
        let range = (formattedVote + "/10" as NSString).range(of: formattedVote)
        let mutableAttributedString = NSMutableAttributedString(string: formattedVote + "/10")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                             value: UIColor.label,
                                             range: range)
        return mutableAttributedString
    }
}

