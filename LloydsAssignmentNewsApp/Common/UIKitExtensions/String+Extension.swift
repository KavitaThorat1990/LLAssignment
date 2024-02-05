//
//  String+Extension.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

extension String {
    /// parse date string to identify formatter and then convert it to date 
    func parseDateString(formats: [DateFormat]) -> Date? {
        let dateFormatterProvider = DateFormatterProvider()
        for format in formats {
            if let formatter = dateFormatterProvider.dateFormatter(for: format) as? DateFormatter, let date = formatter.date(from: self) {
                return date
            } else if let formatter = dateFormatterProvider.dateFormatter(for: format) as? ISO8601DateFormatter, let date = formatter.date(from: self) {
                return date
            }
        }
        return nil
    }
}
