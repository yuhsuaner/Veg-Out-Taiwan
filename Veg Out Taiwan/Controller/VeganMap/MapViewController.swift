//
//  MapViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/15.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

private let reuseIdentifier = "SearchTabeleViewCell"

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var user: User?
    
    var restaurant: [Restaurant] = [] {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    var restaurantList: [String] = []
    var searchedArray: [String] = []
    
    let votProvider = VOTProvider()
    
    private var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.G2
        button.setImage(UIImage(named: "VOT_Search"), for: .normal)
        button.addTarget(self, action: #selector(handleSearchAction), for: .touchUpInside)
        return button
    }()
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "探索美食...")
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.search
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont(name: "jf-openhuninn-1.0", size: 18)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "RestaurantCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "RestaurantCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        fetchUser()
        configureMap()
        configureUI()
        
        for str in restaurantList {
            searchedArray.append(str)
        }
    }

    // MARK: - API
    func fetchData() {
        
        votProvider.fetchRestaurant(completion: { [weak self] result in
            
            switch result {
                
            case .success(let restaurants):
                
                self?.restaurant = restaurants
                
                self?.createMarkersFrom(restaurants)
                
                guard let self = self else { return }
                
                for list in self.restaurant {
                    
                    let list = list.restaurantName
                    self.restaurantList.append(list)
                }
                
            case .failure:
                
                VOTProgressHUD.showFailure(text: "讀取資料失敗！")
            }
        })
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid  else { return }
        
        UserService.shared.fetchUser(uid: uid) { user in
            
            self.user = user
        }
    }
    
    // MARK: - Helper
    
    func configureMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.033493, longitude: 121.564101, zoom: 15.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "MapStyle_Orange", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height / 4 + 5, right: 10)
        
        locationManager.delegate = self

        mapView.delegate = self
        
        let locationButton = mapView.subviews
            .filter { $0.description.contains("GMSUISettingsPaddingView") }
            .flatMap { $0.subviews }
            .flatMap { $0.subviews }
            .filter { $0.description.contains("GMSx_QTMButton") }
            .first
        let customImage = UIImage(imageLiteralResourceName: "VOT_nav")
        let myLocationButton = locationButton as? UIButton
        myLocationButton?.setImage(customImage, for: .normal)
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2DMake(25.04434, 121.563468)
        marker1.map = mapView
        marker1.title = "BaganHood 蔬食餐酒館"
        marker1.snippet = "好吃~~~~~~~~！"
        marker1.icon = UIImage(named: "Pin")
    }
    
    func configureUI() {
        
        //hide NavigationBar
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30)
        ])
        
        searchTextField.delegate = self
        
        NSLayoutConstraint(item: searchTextField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/5, constant: 0).isActive = true
        
        searchTextField.addSubview(searchButton)
        searchButton.anchor(right: searchTextField.rightAnchor, paddingRight: 5,
                            width: UIScreen.main.bounds.height/20,
                            height: UIScreen.main.bounds.height/20)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)
        ])
        
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.5, constant: 0).isActive = true
    }
    
    func setUpTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Creating markers
    func createMarkersFrom(_ restaurants: [Restaurant]) {
        for restaurant in restaurants {
            createMarker(title: restaurant.restaurantName,
                         with: CLLocation(latitude: restaurant.coordinates.latitude,
                                          longitude: restaurant.coordinates.longitude),
                         from: restaurant)
        }
    }
    
    func createMarker(title: String, with location: CLLocation, from restaurant: Restaurant) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude,
                                                 longitude: restaurant.coordinates.longitude)
        marker.title = title
//        marker.snippet = "Tap for details"
        marker.icon = UIImage(named: "Pin")
        marker.map = mapView
    }
    
    // MARK: - selector
    @objc func handleSearchAction() {
        fetchData()
    }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        self.changeMapViewLocation(lat: marker.position.latitude,
                                   long: marker.position.longitude, zoom: 15)

        return true
    }
    
    func changeMapViewLocation(lat: Double, long: Double, zoom: Float) {
        
        var indexNum = Int()
        
        for (index, data) in restaurant.enumerated() where
            
            lat == data.coordinates.latitude {
                
                indexNum = index
        }
        
        collectionView.scrollToItem(
            at: IndexPath(row: indexNum, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        
        updateMapView(lat: lat, long: long, zoom: zoom)
        
    }
    
    func updateMapView(lat: Double, long: Double, zoom: Float) {
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: long ,
                                              zoom: zoom)
        
        mapView.animate(to: camera)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!

        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)

        mapView.camera = camera

        locationManager.stopUpdatingLocation()
        
    }
}

// MARK: - UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return restaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.W1
        cell.layer.cornerRadius = 15
        cell.ratingLabel.text = restaurant[indexPath.row].rating
        cell.restaurantNameLabel.text = restaurant[indexPath.row].restaurantName
        cell.restaurantImage.loadImage(restaurant[indexPath.row].imageURL[0], placeHolder: #imageLiteral(resourceName: "non_photo-2"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = restaurant[indexPath.row]
        
        let viewController = UIStoryboard(name: "RestaurantInformation", bundle: nil).instantiateViewController(
            identifier: "RestaurantInformation",
            creator: { coder in
                RestaurantInformationViewController(coder: coder, restaurant: data)
        })
        
        show(viewController, sender: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width)*3/4,
                      height: collectionView.frame.width / 3)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UIScrollViewDelegate
extension MapViewController: UIScrollViewDelegate {
    
    // perform scaling whenever the collection view is being scrolled
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // center X of collection View
        let centerX = self.collectionView.center.x
        
        // only perform the scaling on cells that are visible on screen
        for cell in self.collectionView.visibleCells {
            
            // coordinate of the cell in the viewcontroller's root view coordinate space
            let basePosition = cell.convert(CGPoint.zero, to: self.view)
            let cellCenterX = basePosition.x + self.collectionView.frame.size.height / 2.0
            
            let distance = abs(cellCenterX - centerX)
            
            let tolerance: CGFloat = 0.02
            var scale = 1.00 + tolerance - (( distance / centerX ) * 0.105)
            if (scale > 1.0) {
                scale = 1.0
            }
            
            if (scale < 0.860091) {
                scale = 0.860091
            }
            
            // Transform the cell size based on the scale
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            // change the alpha of the image view
            guard let cell = cell as? RestaurantCollectionViewCell else { return }
            cell.restaurantImage.alpha = changeSizeScaleToAlphaScale(scale)
        }
    }
    
    func changeSizeScaleToAlphaScale(_ xSize: CGFloat) -> CGFloat {
        let minScale: CGFloat = 0.86
        let maxScale: CGFloat = 1.0
        
        let minAlpha: CGFloat = 0.25
        let maxAlpha: CGFloat = 1.0
        
        return ((maxAlpha - minAlpha) * (xSize - minScale)) / (maxScale - minScale) + minAlpha
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.page()
    }
    
    // for custom snap-to paging, when user stop scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if !self.collectionView.isDecelerating {
                self.page()
            }
        }
    }
    
    func page() {
        
//        let itemSize: CGSize = CGSize(width: 200, height: 150)
        let itemSize: CGSize = CGSize(width: (collectionView.frame.width)*3/4,
                                      height: collectionView.frame.width / 3)
        
        let page = collectionView.contentOffset.x / itemSize.width
        
        var targetIndex = 0
        
        if page - 0.5 >= page {
            targetIndex = Int(page) + 1
        } else {
            targetIndex = page == 0 || page == -1 ? 0 : Int(page)
        }
        
        collectionView.scrollToItem(at: IndexPath(row: targetIndex, section: 0),
                                                   at: .centeredHorizontally,
                                                   animated: true)
        
        let location = restaurant[targetIndex].coordinates
        
        updateMapView(lat: location.latitude, long: location.longitude, zoom: 15)
    }
}

// MARK: - UITextFieldDelegate
extension MapViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        setUpTableView()
        searchedArray.removeAll()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.isHidden = true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        
        searchedArray.removeAll()
        
        for str in restaurantList {
            searchedArray.append(str)
        }
        
        tableView.reloadData()
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (searchTextField.text?.count)! != 0 {
            
            self.searchedArray.removeAll()
            
            for str in restaurantList {
                
                let range = str.lowercased().range(of: textField.text!,
                                                   options: .caseInsensitive,
                                                   range: nil,
                                                   locale: nil)
                if range != nil {
                    self.searchedArray.append(str)
                }
            }
        }
        
        tableView.reloadData()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        tableView.reloadData()

        return true
    }
}

// MARK: - UITableViewDataSource
extension MapViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = searchedArray[indexPath.row]
        cell.addressLabel.text = restaurant[indexPath.row].address
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MapViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = restaurant[indexPath.row]
        
        let viewController = UIStoryboard(name: "RestaurantInformation", bundle: nil).instantiateViewController(
            identifier: "RestaurantInformation",
            creator: { coder in
                RestaurantInformationViewController(coder: coder, restaurant: data)
        })

        show(viewController, sender: self)
    }
}
