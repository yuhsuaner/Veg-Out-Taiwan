//
//  MapMarkerManager.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/19.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation
import GoogleMaps

private let sharedMapMarkerManager = MapMarkerManager()

class MapMarkerManager {
    
    class var shared: MapMarkerManager {
        
        return sharedMapMarkerManager
        
    }
    
    fileprivate var markers = [GMSMarker]()
    
    public func addMarkersFor(restaurants: [Restaurant], to map: GMSMapView) {
        
//        guard let markerList = restaurants else { return }
        
        map.clear()
        markers.removeAll()
        
        guard restaurants.count > 0 else { return }
        
        for restaurant in restaurants {
            
            let marker = markerFor(restaurant: restaurant, in: map)
            
            markers.append(marker)
            
        }
    }
    
    public func markerFor(restaurant: Restaurant, in map: GMSMapView) -> GMSMarker {
        
        let marker = markerFor(latitude: restaurant.coordinates.latitude,
                               longitude: restaurant.coordinates.longitude,
                               map: map)
        
        marker.icon = UIImage(named: "Pin")
        marker.userData = restaurant
        
        return marker
        
    }
    
    public func markerFor(latitude: CLLocationDegrees, longitude: CLLocationDegrees, map: GMSMapView) -> GMSMarker {
        
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return markerFor(position: position, in: map)
        
    }
    
    public func markerFor(position: CLLocationCoordinate2D, in map: GMSMapView) -> GMSMarker {
        
        let marker = markerFor(position: position)
        marker.map = map
        
        return marker
    }
    
    public func markerFor(position: CLLocationCoordinate2D) -> GMSMarker {
        
        let marker = GMSMarker(position: position)
        
        marker.isFlat = true
        
        marker.appearAnimation = .pop
        
        return marker
    }
}
