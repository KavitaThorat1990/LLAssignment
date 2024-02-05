//
//  DateConvertible.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation

/// protocol to convert date into desired format to use in app 
protocol DateConvertible {
    func formattedDate(using formatter: DateFormatterProviding, formatString: String) -> String?
}
