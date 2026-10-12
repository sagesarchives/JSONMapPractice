//
//  DataLoader.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import Foundation

class DataLoader {
    static func loadLocations() -> [Location] {
        // This line of code locates the file inside of the application
        guard let url = Bundle.main.url(forResource: "locations.json", withExtension: nil) else {
            print("Could not find locations.json in the app bundle")
            return []
        } // guard ending brace
        
        do {
            // This line of code loads the raw data from the file
            let data = try Data(contentsOf: url)
            
            // This line of code decodes the data into the array of Location structs
            let decoder = JSONDecoder()
            let locations = try decoder.decode([Location].self, from: data)
            return locations
        } catch {
            print("Failed to decode JSON data: \(error)")
            return []
        } // do catch ending brace
    } // func ending  brace
} // class ending brace
