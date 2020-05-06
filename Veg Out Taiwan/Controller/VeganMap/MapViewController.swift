//
//  MapViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/15.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseDatabase

class MapViewController: UIViewController {
    
    // MARK: - Properties
    /*
     Reference: https://www.freecodecamp.org/news/how-to-create-an-autocompletion-uitextfield-using-coredata-in-swift-dbedad03ea3d/
     */
    
    var restaurant: [Restaurant] = [] {
        didSet {
            
            collectionView.reloadData()
        }
    }
    let votProvider = VOTProvider()
    
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
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont(name: "jf-openhuninn-1.0", size: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        textField.addTarget(self, action: #selector(searchControl), for: .editingChanged)
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        //        let layout = RestaurantCollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        
        //        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "RestaurantCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "RestaurantCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        
        //        collectionView.isPagingEnabled = true
        
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.033493, longitude: 121.564101, zoom: 15.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
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
        
        //  Google Map SDK: COMPASS
        mapView.settings.compassButton = true
        
        //  Google Map SDK: User's loaction
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(25.034012, 121.563461)
        marker.map = mapView
        marker.title = "台北101"
        marker.snippet = "好吃！"
        marker.icon = UIImage(named: "Pin")
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2DMake(25.04434, 121.563468)
        marker1.map = mapView
        marker1.title = "BaganHood 蔬食餐酒館"
        marker1.snippet = "好吃~~~~~~~~！"
        marker1.icon = UIImage(named: "Pin")
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(25.034012, 121.566461)
        marker2.map = mapView
        marker2.title = "標題2"
        marker2.snippet = "副標題2"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        searchTextField.delegate = self
        
//        fetchAllRestaurants()
        fetchData()
    }
    
    func fetchData() {
        
        votProvider.fetchRestaurant(completion: { [weak self] result in

            switch result {

            case .success(let restaurants):

                self?.restaurant = restaurants
                print(result)

            case .failure:

                VOTProgressHUD.showFailure(text: "讀取資料失敗！")
            }
        })
    }
    
    func fetchAllRestaurants() {
        
        let session = URLSession.shared
        let url = URL(string: "https://veg-out-taiwan-1584254182301.firebaseio.com/VOT_Restaurants.json")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONDecoder().decode([Restaurant].self, from: data!)
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
    // MARK: - selector
    @objc func handleSearchAction() {
        
        print("123")
    }
    
    @objc func searchControl() {
        
        print(self.searchTextField.text ?? "123")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        //hide NavigationBar
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/24),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30)
        ])
        
        NSLayoutConstraint(item: searchTextField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/5, constant: 0).isActive = true
        
        view.addSubview(searchButton)
        searchButton.anchor(left: searchTextField.rightAnchor, paddingLeft: 10, width: UIScreen.main.bounds.height/24, height: UIScreen.main.bounds.height/24)
        
        NSLayoutConstraint(item: searchButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/5, constant: 0).isActive = true
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)
        ])
        
        NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.5, constant: 0).isActive = true
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
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.W1
        cell.layer.cornerRadius = 15
        cell.ratingLabel.text = "4.5"
        cell.restaurantNameLabel.text = "Plants"
        cell.restaurantImage.image = #imageLiteral(resourceName: "Pic4")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewController = UIStoryboard(name: "RestaurantInformation", bundle: nil).instantiateViewController(identifier: "RestaurantInformation") as? RestaurantInformationViewController else { return }
        
        show(viewController, sender: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        return CGSize(width: (collectionView.frame.width)*3/4,
        //                      height: collectionView.frame.width / 3)
        return CGSize(width: collectionView.frame.size.width,
                      height: collectionView.frame.size.height)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //
    //        return 0
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //
    //        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //
        //        return collectionView.contentInset
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

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
    
    // for custom snap-to paging, when user stop scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var indexOfCellWithLargestWidth = 0
        var largestWidth: CGFloat = 1
        
        for cell in self.collectionView.visibleCells {
            
            if cell.frame.size.width > largestWidth {
                largestWidth = cell.frame.size.width
                if let indexPath = self.collectionView.indexPath(for: cell) {
                    indexOfCellWithLargestWidth = indexPath.item
                }
            }
        }
        
        collectionView.scrollToItem(at: IndexPath(item: indexOfCellWithLargestWidth, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension MapViewController: UITextFieldDelegate {
    
}
