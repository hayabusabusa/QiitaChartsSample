//
//  WeekdayAxisValueFormatter.swift
//  QiitaChartsSample
//
//  Created by Yamada Shunya on 2020/01/15.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Charts

class WeekdayAxisValueFormatter: NSObject, IAxisValueFormatter {
    enum Weekday: Int, CustomStringConvertible {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var description: String {
            switch self {
            case .monday:
                return "Mon"
            case .tuesday:
                return "Tue"
            case .wednesday:
                return "Wed"
            case .thursday:
                return "Thu"
            case .friday:
                return "Fri"
            case .saturday:
                return "Sat"
            case .sunday:
                return "Sun"
            }
        }
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let weekday = Weekday(rawValue: Int(value))?.description else { return "UNKNOWN" }
        return weekday
    }
}
