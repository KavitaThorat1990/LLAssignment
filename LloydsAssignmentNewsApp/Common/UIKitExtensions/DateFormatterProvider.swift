//
//  DateFormatterProvider.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation

final class DateFormatterProvider: DateFormatterProviding {
    /// Create dateformatter based on format 
    func dateFormatter(for format: DateFormat) -> Formatter {
        let dateFormatter = DateFormatter()
        switch format {
        case .iso8601:
            return ISO8601DateFormatter()
        case .customFormat(let customFormat):
            dateFormatter.dateFormat = customFormat
        }
        return dateFormatter
    }
}
