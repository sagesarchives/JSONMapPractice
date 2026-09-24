//
//  Location.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable {
    var id: String { school }
    
    let school: String
    let address: String
    let ipAddress: String
    let schoolLatitude: Double
    let schoolLongitude: Double

    enum CodingKeys: String, CodingKey {
        case school
        case address
        // These lines turn JSON's snake case (snake_case) into Swift's camel case
        case ipAddress = "ip_address"
        case schoolLatitude = "school_latitude"
        case schoolLongitude = "school_longitude"
    } // enum ending brace
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: schoolLatitude, longitude: schoolLongitude)
    } // var coordinate ending brace
} // struct ending brace
