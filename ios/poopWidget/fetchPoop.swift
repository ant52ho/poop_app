//
//  fetchPoop.swift
//  Runner
//
//  Created by Anthony on 2024-08-23.
//

import Foundation

// fetches data and stores into userdefaults
func fetchPoop() async throws -> String {
        
    let url = URL(string: "\(Config.apiUrl)/api/v1/poop/dailycache")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // Fetch JSON data
    let (data, _) = try await URLSession.shared.data(from: url);

    // set string json data in db
    let jsonString = String(data: data, encoding: .utf8);
    let userDefaults = UserDefaults(suiteName: Config.poopAppGroup)
    userDefaults?.set(data, forKey: Config.dbKey)
    
    return jsonString ?? "null string"
}
//
//func incrementPoop() async throws -> String {
//    let url = URL(string: "\(Config.apiUrl)/api/v1/poop/increment")! // todo
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    
//    // Fetch JSON data
//    let (data, _) = try await URLSession.shared.data(from: url);
//
//    // set string json data in db
//    let jsonString = String(data: data, encoding: .utf8);
//    let userDefaults = UserDefaults(suiteName: Config.poopAppGroup)
//    userDefaults?.set(data, forKey: Config.dbKey)
//    
//    return jsonString ?? "null string"
//}
//
//func decrementPoop() async throws -> String {
//    let url = URL(string: "\(Config.apiUrl)/api/v1/poop/decrement")! // todo
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    
//    // Fetch JSON data
//    let (data, _) = try await URLSession.shared.data(from: url);
//
//    // set string json data in db
//    let jsonString = String(data: data, encoding: .utf8);
//    let userDefaults = UserDefaults(suiteName: Config.poopAppGroup)
//    userDefaults?.set(data, forKey: Config.dbKey)
//    
//    return jsonString ?? "null string"
//}
