//
//  ContentView.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations: [Location] = DataLoader.loadLocations()
    @State private var position: MapCameraPosition = .automatic
    var body: some View {
        Map(position: $position) {
            ForEach(locations) { location in
                Marker(location.landmark, coordinate: location.coordinate)
            } // for each ending brace
        } // map ending brace
        .ignoresSafeArea()
        .onAppear {
            printPrettyJSON(from: locations)
        } // on appear ending brace
    } // var body ending  brace
    
    func printPrettyJSON(from locations: [Location]) {
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(locations)
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            } // if let ending brace
        } catch {
            print("Failed to format JSON: \(error)")
        } // do catch ending brace
    } // pretty printing ending brace
} // struct ending brace

#Preview {
    ContentView()
}
