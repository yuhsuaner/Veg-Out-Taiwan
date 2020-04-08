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
    
    // MARK: - Properties
    
    private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.O1
        button.setImage(UIImage(named: "icons8-search-64"), for: .normal)
        button.addTarget(self, action: #selector(handleSearchAction), for: .touchUpInside)
        return button
    }()
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "搜尋美食"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont(name: "jf-openhuninn-1.0", size: 18)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(searchControl), for: .editingChanged)
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "RestaurantCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "RestaurantCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        
        collectionView.isPagingEnabled = true
        
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide NavigationBar
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 25.033493, longitude: 121.564101, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        self.view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        //        Google Map SDK: COMPASS
        mapView.settings.compassButton = true
        
        //        Google Map SDK: User's loaction
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        mapView.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.7, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/24),
            searchTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: mapView.centerXAnchor, multiplier: 5/2)
        ])
        
        NSLayoutConstraint(item: searchTextField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mapView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/5, constant: 0).isActive = true
        
        mapView.addSubview(searchButton)
        searchButton.anchor(left: searchTextField.rightAnchor, paddingLeft: 10, width: UIScreen.main.bounds.height/24, height: UIScreen.main.bounds.height/24)
        
        NSLayoutConstraint(item: searchButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mapView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/5, constant: 0).isActive = true
        
        mapView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            collectionView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 1/5),
            collectionView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -150)
        ])
        
    }
    
    // MARK: - selector
    @objc func handleSearchAction() {
        
        print("123")
    }
    
    @objc func searchControl() {
        
        print(self.searchTextField.text ?? "123")
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 25
        cell.numberOfStarLabel.text = "3.5"
        cell.restaurantNameLabel.text = "qwertyuiodfghjvbnm"
        cell.restaurantImage.image = #imageLiteral(resourceName: "vegan-healthy-food")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = RestaurantInfomationViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
