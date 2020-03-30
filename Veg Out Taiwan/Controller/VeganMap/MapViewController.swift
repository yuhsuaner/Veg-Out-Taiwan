//
//  MapViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/15.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide NavigationBar
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
////        Google Map SDK: COMPASS
//        mapView.settings.compassButton = true
//
////        Google Map SDK: User's loaction
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//
//        mapView.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        collectionView.backgroundColor = .clear

//        NSLayoutConstraint.activate([
//            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
//            collectionView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 1/5),
//            collectionView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -150)
//        ])
//    }
    
//    fileprivate var collectionView: UICollectionView = {
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.layer.cornerRadius = 15
//        return collectionView
//    }()
}

//extension MapViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//    }
//}
//
//extension MapViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
//
//        cell.backgroundColor = .clear
//
//        return cell
//    }
//
//}
//
//extension MapViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
//    }
//}
}
