//
//  DetailViewController.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import SDWebImage

final class DetailViewController: BaseViewController {
    
    private lazy var posterImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private lazy var imdbLogo : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "IMDBLogo"))
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private lazy var starIcon : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "starIcon"))
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private lazy var rateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = FontManager.fontMedium(15)
        return label
    }()
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = FontManager.fontMedium(15)
        return label
    }()
    
    private lazy var movieNameLabel : UILabel = {
        let label = UILabel()
        label.font = FontManager.fontBold(20)
        return label
    }()
    
    private lazy var movieDescriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontManager.fontRegular(15)
        return label
    }()
    
    private var dot : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initUI(){
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
        
        scrollView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(starIcon.snp.right).offset(8)
            make.centerY.equalTo(starIcon)
        })
        
        
        scrollView.addSubview(dot)
        dot.snp.makeConstraints { make in
            make.height.width.equalTo(4)
            make.left.equalTo(rateLabel.snp.right).offset(8)
            make.centerY.equalTo(rateLabel)
        }
        
        scrollView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(dot.snp.right).offset(8)
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
            make.bottom.equalToSuperview()
        })
        
        scrollView.contentSize = CGSize(width: screenWidth,
                                        height: movieDescriptionLabel.frame.origin.y + (movieDescriptionLabel.frame.height))
        
    }
    
    func fillWith(image:String,name:String,desc:String,date:String,vote:Double){
        
        posterImageView.sd_setImage(with: API.shared.getImageURL(with: image))
        let formattedVote = String(format: "%.2f", vote)
        let range = (formattedVote + "/10" as NSString).range(of: formattedVote)
        let mutableAttributedString = NSMutableAttributedString.init(string: formattedVote + "/10")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                             value: UIColor.label,
                                             range: range)
        movieNameLabel.text = name
        rateLabel.attributedText = mutableAttributedString
        dateLabel.text = date.toDate(format: serverDateFormat)?.convertDateToString(format: clientDateStringFormat)
        movieDescriptionLabel.text = desc
    }
}
