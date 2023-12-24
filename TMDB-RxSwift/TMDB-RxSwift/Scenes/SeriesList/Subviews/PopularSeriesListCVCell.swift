//
//  PopularSeriesListCVCell.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import SDWebImage
import RxSwift

final class PopularSeriesListCVCell: UICollectionViewCell {
    
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
        
        rightArrow = UIImageView(image: UIImage(named: "rightArrow"))
        rightArrow.contentMode = .scaleAspectFill
        addSubview(rightArrow)
        
        underLine.backgroundColor = .gray
        underLine.layer.opacity = 0.2
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
            make.height.equalTo(10)
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
    
    
    func fillWith(movieName:String,movieShortDesc:String,imageURL:URL?,vote:Double){
        movieNameLabel.text = movieName
        movieShortDescLabel.text = movieShortDesc
        
        let stringVote = String(vote)
        let range = (stringVote + "/10" as NSString).range(of: stringVote)
        let mutableAttributedString = NSMutableAttributedString.init(string: stringVote + "/10")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                             value: UIColor.label,
                                             range: range)
        movieVoteLabel.attributedText = mutableAttributedString
        movieImage.sd_setImage(with: imageURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

