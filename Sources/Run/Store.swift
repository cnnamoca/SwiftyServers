//
//  Store.swift
//  SwiftyServerPackageDescription
//
//  Created by Carlo Namoca on 2017-11-13.
//
import Foundation

class Store {
    
    func set(key: String, value: String) {
        
        var dict = UserDefaults.standard.dictionary(forKey: "SavedDict")
        if dict == nil {
            dict = [String: Any]()
        }
        dict![key] = value
        
        UserDefaults.standard.set(dict, forKey: "SavedDict")
    }
    
    func get(key: String) -> String{
        guard let dict = UserDefaults.standard.dictionary(forKey: "SavedDict"), let value = dict[key] as? String else {
            return "UR A BUTT (   ).(   )\n"
        }
        return value
    }
    
    func allItems() -> [String: Any] {
        
        guard let dict = UserDefaults.standard.dictionary(forKey: "SavedDict") else {
            return [:]
        }
        return dict
    }

}
