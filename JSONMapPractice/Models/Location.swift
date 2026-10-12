//
//  Location.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import Foundation
import CoreLocation
import Clusterables

struct Location: Codable, Identifiable, Clusterable {
    var id: String { landmark }
    
    let landmark: String
    let address: String
    let ipAddress: String
    let landmarkLatitude: Double
    let landmarkLongitude: Double

    enum CodingKeys: String, CodingKey {
        case landmark
        case address
        // These lines turn JSON's snake case (snake_case) into Swift's camel case
        case ipAddress = "ip_address"
        case landmarkLatitude = "landmark_latitude"
        case landmarkLongitude = "landmark_longitude"
    } // enum ending brace
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: landmarkLatitude, longitude: landmarkLongitude)
    } // var coordinate ending brace
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    } // func ending brace
} // struct ending brace
