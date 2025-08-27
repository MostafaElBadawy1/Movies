//
//  DateFormatterHelper.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

enum DateFormatterHelper {
    static func parse(_ string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let date = formatter.date(from: string) ?? Date()
        return format(date)
    }

    static func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
