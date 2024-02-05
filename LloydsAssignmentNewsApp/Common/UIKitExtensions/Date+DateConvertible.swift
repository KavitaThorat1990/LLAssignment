//
//  Date+Extension.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation

extension Date: DateConvertible {
    
    // Convert date into desired format to use
    func formattedDate(using formatter: DateFormatterProviding, formatString: String) -> String? {
        let dateFormatter = formatter.dateFormatter(for: .customFormat(formatString))
        if let formatter = dateFormatter as? ISO8601DateFormatter {
            return formatter.string(from: self)
        } else if let formatter = dateFormatter as? DateFormatter {
            return formatter.string(from: self)
        }
        return nil
    }
}
