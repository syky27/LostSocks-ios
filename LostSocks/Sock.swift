//
//  Sock.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 13/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation
import MapKit

class Sock: NSObject, MKAnnotation {
    var id: Int?
    var d: String
    var name: String
    var time: Int
    var lat: Double
    var lon: Double
    var imageBase64: String?
    var demouser_id: Int?
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        set (coordinates){
            lat = coordinates.latitude
            lon = coordinates.longitude
        }
    }
    
    var title: String? {
        get {
            return name
        }
    }
    
    
    init(formValues: Dictionary<String, Any>) {
        d = formValues["d"] as! String
        if let image = formValues["image"] {
            imageBase64 = UIImageJPEGRepresentation(image as! UIImage, 1.0)?.base64EncodedString()
        }
        name = formValues["name"] as! String
        time = Int(Date().timeIntervalSince1970)
        let coords = formValues["coordinates"] as! CLLocation
        lat = coords.coordinate.latitude
        lon = coords.coordinate.longitude
        
        
    }
    
    init(node: Dictionary<String, Any>) {
        id = node["id"] as! Int
        d = node["d"] as! String
        name = node["name"] as! String
        time = node["time"] as! Int
        lat = node["lat"] as! Double
        lon = node["lon"] as! Double
        if let image = node["imageBase64"] as? String {
            imageBase64 = image
        }
        
        if let user = node["demouser_id"] as? Int {
            demouser_id = user
        }
        
    }
    
    func json() -> Dictionary<String, Any> {
        return[
            "name": name,
            "d": d,
            "time": time,
            "lat" : lat,
            "lon" : lon,
            "imageBase64": imageBase64 ?? "",
        ]
    }
    
}

