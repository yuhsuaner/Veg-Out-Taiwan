//
//  ProfileViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/16.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

//class ProfileViewController: UIViewController {
//
//    // MARK: - Properties
//
//    let images: [UIImage] = [#imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food"), #imageLiteral(resourceName: "vegan-healthy-food")]
//
//    lazy var containerHeaderView: UIView = {
//
//        let view = UIView()
//
//        view.addSubview(profileImageView)
//
//        //        profileImageView.anchor(left: view.leftAnchor, paddingLeft: 80, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//
//        //        outerView.centerY(inView: view)
//        //        outerView.translatesAutoresizingMaskIntoConstraints = false
//        //
//        //        NSLayoutConstraint.activate([
//        //            outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
//        //            outerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        //            outerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
//        //            //            outerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
//        //            outerView.widthAnchor.constraint(equalTo: outerView.heightAnchor, multiplier: 1.0)
//        //        ])
//
//        NSLayoutConstraint(item: profileImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 3/5, constant: -25).isActive = true
//        profileImageView.anchor(top: view.topAnchor,
//                                paddingTop: 85,
//                                width: 100,
//                                height: 100)
//
//        view.addSubview(nameLabel)
//        NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 4/5, constant: 0).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//        nameLabel.anchor(top: view.topAnchor, left: profileImageView.rightAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
//
//        view.addSubview(generateStackView)
//
//        generateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        generateStackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 40, paddingBottom: 0, paddingRight: 40)
//        return view
//    }()
//
//    /* Reference:
//     https://stackoverflow.com/questions/41475501/creating-a-shadow-for-a-uiimageview-that-has-rounded-corners
//     */
//
//    lazy var profileImageView: UIImageView = {
//        //        let image = UIImageView(frame: outerView.bounds)
//        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        //            image.clipsToBounds = true
//        //            image.layer.cornerRadius = 10
//        image.image = #imageLiteral(resourceName: "vegan-healthy-food")
//        //            image.layer.cornerRadius = image.frame.size.width / 2
//        image.contentMode = .scaleAspectFill
//        return image
//    }()
//
//    //        lazy var outerView: UIView = {
//    ////            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//    //            let view = UIView()
//    //            view.anchor(left: containerHeaderView.leftAnchor, paddingLeft: 80, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//    //            view.centerY(inView: containerHeaderView)
//    //            view.clipsToBounds = false
//    //            view.layer.shadowColor = UIColor.black.cgColor
//    //            view.layer.shadowOpacity = 1
//    //            view.layer.shadowOffset = CGSize.zero
//    //            view.layer.shadowRadius = 10
//    //            view.layer.cornerRadius = view.frame.size.width / 2
//    ////            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
//    //            view.addSubview(profileImageView)
//    //            return view
//    //        }()
//    //
//    //        lazy var  profileImageView: UIImageView = {
//    ////                let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//    ////                let image = UIImageView(frame: outerView.frame)
//    //                let image = UIImageView()
//    //                image.image = #imageLiteral(resourceName: "vegan-healthy-food")
//    //        //        image.clipsToBounds = true
//    //                image.layer.masksToBounds = false
//    //                image.layer.cornerRadius = image.frame.size.width / 2
//    //                image.contentMode = .scaleAspectFill
//    //                image.clipsToBounds = true
//    //                image.layer.shadowOpacity = 0.8
//    //                image.layer.shadowRadius = 20
//    //            image.anchor(top: outerView.topAnchor, left: outerView.leftAnchor, bottom: outerView.bottomAnchor, right: outerView.rightAnchor)
//    //                return image
//    //            }()
//
//    //    func setUPhoto() {
//    //
//    //        containerHeaderView.addSubview(outerView)
//    //        outerView.translatesAutoresizingMaskIntoConstraints = false
//    //
//    //        NSLayoutConstraint.activate([
//    //            outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
//    //            outerView.centerYAnchor.constraint(equalTo: containerHeaderView.centerYAnchor),
//    //            outerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
//    ////            outerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
//    //            outerView.widthAnchor.constraint(equalTo: outerView.heightAnchor, multiplier: 1.0)
//    //        ])
//    //
//    //        outerView.addSubview(profileImageView)
//    //        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//    //
//    //        NSLayoutConstraint.activate([
//    //            profileImageView.topAnchor.constraint(equalTo: outerView.topAnchor),
//    //            profileImageView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor),
//    //            profileImageView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor),
//    //            profileImageView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor)
//    //        ])
//    //
//    //    }
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.text = "Irene Chen"
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 24)
//        label.textColor = .G2
//        return label
//    }()
//
//    lazy var generateStackView: UIStackView = {
//        let stackV = UIStackView(arrangedSubviews: [commentSatckView, followerSatckView, followingSatckView])
//
//        stackV.translatesAutoresizingMaskIntoConstraints = false
//        stackV.axis = .horizontal
//        stackV.spacing = 20
//        stackV.distribution = .equalCentering
//
//        return stackV
//    }()
//
//    lazy var commentSatckView: UIStackView = {
//        let stackV = UIStackView(arrangedSubviews: [commentOfCountsLabel, commentOfNameLabel])
//
//        stackV.translatesAutoresizingMaskIntoConstraints = false
//        stackV.axis = .vertical
//        stackV.spacing = 0
//        stackV.distribution = .fillEqually
//
//        return stackV
//    }()
//
//    lazy var followerSatckView: UIStackView = {
//        let stackV = UIStackView(arrangedSubviews: [followerOfCountsLabel, followerOfNameLabel])
//
//        stackV.translatesAutoresizingMaskIntoConstraints = false
//        stackV.axis = .vertical
//        stackV.spacing = 0
//        stackV.distribution = .fillEqually
//
//        return stackV
//    }()
//
//    lazy var followingSatckView: UIStackView = {
//        let stackV = UIStackView(arrangedSubviews: [followingOfCountsLabel, followingOfNameLabel])
//
//        stackV.translatesAutoresizingMaskIntoConstraints = false
//        stackV.axis = .vertical
//        stackV.spacing = 0
//        stackV.distribution = .fillEqually
//
//        return stackV
//    }()
//
//    private lazy var commentOfCountsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "115"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 21)
//        return label
//    }()
//
//    private lazy var commentOfNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "評論"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 15)
//        return label
//    }()
//
//    private lazy var followerOfCountsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "1000"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 21)
//        return label
//    }()
//
//    private lazy var followerOfNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "粉絲"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 15)
//        return label
//    }()
//
//    private lazy var followingOfCountsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "8"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 21)
//        return label
//    }()
//
//    private lazy var followingOfNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "追蹤中"
//        label.textColor = .G2
//        label.textAlignment = .center
//        label.font = UIFont(name: "jf-openhuninn-1.0", size: 15)
//        return label
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCell")
//
//        return collectionView
//    }()
//
//    // MARK: - LifeCycle
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        //        profileImageView.layer.cornerRadius = profileImageView.layer.bounds.width / 2
//        //        outerView.layer.cornerRadius = outerView.layer.bounds.width / 2
//        //        outerView.layer.shadowColor = UIColor.black.cgColor
//        //        outerView.layer.shadowOpacity = 0.7
//
//        profileImageView.layer.masksToBounds = false
//        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
//        profileImageView.clipsToBounds = true
//        profileImageView.layer.shadowOpacity = 0.7
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureUI()
//
//        view.addSubview(containerHeaderView)
//        containerHeaderView.anchor(top: view.topAnchor,
//                                   left: view.leftAnchor,
//                                   right: view.rightAnchor,
//                                   height: 260)
//
//        configureCollectionViewUI()
//        //         setUPhoto()
//    }
//
//    // MARK: - Helper
//
//    func configureUI() {
//
//        view.backgroundColor = .white
//
//        //hide NavigationBar
//        let barAppearance =  UINavigationBarAppearance()
//        barAppearance.configureWithTransparentBackground()
//        navigationController?.navigationBar.standardAppearance = barAppearance
//
//    }
//
//    func configureCollectionViewUI() {
//
//        collectionView.backgroundColor = .white
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        view.addSubview(collectionView)
//        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        collectionView.anchor(top: containerHeaderView.bottomAnchor, left: view.leftAnchor,
//                              bottom: view.bottomAnchor,
//                              right: view.rightAnchor)
//
//    }
//}
//
//extension ProfileViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return images.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {
//            return UICollectionViewCell() }
//
////        cell.layer.cornerRadius = 10
//        cell.image = images[indexPath.item]
//
//        return cell
//    }
//}
//
//extension ProfileViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: (collectionView.frame.width - 40) / 3, height: collectionView.frame.width / 3)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
//    }
//}
