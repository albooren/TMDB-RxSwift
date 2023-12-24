//
//  Date+StringExtensions.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import Foundation

public extension Date {
    static func convertStringDateToDate(stDate:String,format:String)->Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let d = dateFormatter.date(from: stDate)
        return d
    }
    
    func convertDateToString(format:String)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

public extension String {
    func toDate(format:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? nil
    }
}
