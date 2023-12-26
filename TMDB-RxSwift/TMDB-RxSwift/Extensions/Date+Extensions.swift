//
//  Date+Extensions.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import Foundation

public extension Date {
    func convertDateToString(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
