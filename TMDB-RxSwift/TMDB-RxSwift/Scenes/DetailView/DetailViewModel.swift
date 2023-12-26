//
//  DetailViewModel.swift
//  TMDB-RxSwift
//
//  Created by albooren on 26.12.2023.
//

import UIKit

final class DetailViewModel {
    
    private var imageURL: String
    private var name: String
    private var desc: String
    private var date: String
    private var vote: Double
    
    init(imageURL: String, name: String, desc: String, date: String, vote: Double) {
        self.imageURL = imageURL
        self.name = name
        self.desc = desc
        self.date = date
        self.vote = vote
    }
    
    func getImageURL() -> URL? {
        return API.shared.getImageURL(with: imageURL)
    }
    
    func getSeriesName() ->  String {
        return name
    }
    
    func getSeriesDescription() -> String {
        return desc
    }
    
    func getSeriesReleaseDate() -> String {
        return date.toDate(format: serverDateFormat)?.convertDateToString(format: clientDateStringFormat) ?? ""
    }
    
    func getSeriesVote() -> NSAttributedString {
        let formattedVote = String(format: "%.2f", vote)
        let range = (formattedVote + "/10" as NSString).range(of: formattedVote)
        let mutableAttributedString = NSMutableAttributedString.init(string: formattedVote + "/10")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                             value: UIColor.label,
                                             range: range)
        return mutableAttributedString
    }
}
