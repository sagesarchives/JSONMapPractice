//
//  ContentView.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import SwiftUI
import MapKit
import Clusterables

struct ContentView: View {
    // JSON import variable
    @State private var locations: [Location] = DataLoader.loadLocations()
    
    // Clustering variables
    @State private var clusterManager = ClusterManager<Location>()
    @State private var activeClusters: [Cluster<Location>] = []
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.3331, longitude: -83.0480),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ) // region ending brace
    ) // cameraposition state ending brace
    var body: some View {
        MapReader { mapProxy in
            Map(position: $cameraPosition) {
                ForEach(activeClusters, id:\.id) { cluster in
                    Annotation("", coordinate: cluster.center) {
                        if cluster.size > 1 {
                            Circle()
                                .fill(.blue)
                                .frame(width: 40, height: 40)
                                .shadow(radius: 3)
                                .overlay(
                                    Text("\(cluster.size)")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                ) // overlay ending brace
                        } else {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundStyle(Color.red)
                                .font(.title)
                        } // if else ending brace
                    } // annotation ending brace
                } // for each ending brace
            } // map ending brace
            .ignoresSafeArea()
            .onMapCameraChange(frequency: .continuous) { context in
                if let epsilon = mapProxy.degrees(fromPixels: 40) {
                    Task {
                        await clusterManager.update(locations, epsilon: epsilon, minimumPoints: 1)
                        await MainActor.run {
                            self.activeClusters = clusterManager.clusters
                        } // await ending brace
                    } // task ending brace
                } // if let ending brace
            } // onchange ending brace
            .onAppear {
                printPrettyJSON(from: locations)
                Task {
                    await clusterManager.update(locations, epsilon: 0.05, minimumPoints: 1)
                    await MainActor.run {
                        self.activeClusters = clusterManager.clusters
                    } // await enidng brace
                } // task ending brace
            } // on appear ending brace
        } // map reader ending brace
    } // var body ending brace
    
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
