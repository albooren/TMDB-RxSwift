//
//  String+Extensions.swift
//  TMDB-RxSwift
//
//  Created by albooren on 26.12.2023.
//

import Foundation

public extension String {
    func toDate(format:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? nil
    }
    
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main, value: "", comment: "")
    }
}
