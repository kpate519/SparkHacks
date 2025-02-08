//  Fountain.swift
//  Everday 2.0
//
//  Created by Nour Alsramah on 2/8/25.
//
//import Foundation
//import MapKit
//import UIKit
//
//struct Fountain: Codable{
//    let id: Int
//    let building: String
//    let location: String
//    let lat: Double
//    let lon: Double
//    
//    var coordinate: CLLocationCoordinate2D{
//        CLLocationCoordinate2D(latitude: lat, longitude: lon)
//    }
//    
//}
import Foundation
import CoreLocation

struct Fountain: Identifiable, Codable {
    let id: String
    let building: String
    let location: String
    let lat: Double
    let lon: Double
    

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
