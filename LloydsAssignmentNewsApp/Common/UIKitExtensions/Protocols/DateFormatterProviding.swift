//
//  DateFormatterProviding.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation

enum DateFormat {
    case iso8601
    case customFormat(String)
}

/// to provide dateFormatter based on format
protocol DateFormatterProviding {
    func dateFormatter(for format: DateFormat) -> Formatter
}
