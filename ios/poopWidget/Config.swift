//
//  Config.swift
//  Runner
//
//  Created by Anthony on 2024-08-24.
//

import Foundation

public struct Config {
//    public static let apiUrl = "http://10.253.196.134:5000"
    public static let apiUrl = "https://ant-personal-site-backend.fly.dev"
    public static let poopAppGroup = "group.anthony.poopapp"
    public static let widgetKind = "poopWidget"
    public static let dbKey = "poopdb"
    public static let localDB = UserDefaults(suiteName: poopAppGroup)
}

public struct PersonData: Identifiable {
    public let id = UUID()
    let name: String
    let value: Int
}

