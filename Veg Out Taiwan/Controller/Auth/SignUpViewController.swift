//
//  SignUpViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/20.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "VOT tab bar icons-12"), for: .normal)
        button.tintColor = .DG
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "VOT tab bar icons-12")
        let view = Utilies().inputContainView(withImage: image, textFiled: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "VOT tab bar icons-12")
        let view = Utilies().inputContainView(withImage: image, textFiled: passwordTextField)
        
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "VOT tab bar icons-12")
        let view = Utilies().inputContainView(withImage: image, textFiled: fullNameTextField)
        
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "VOT tab bar icons-12")
        let view = Utilies().inputContainView(withImage: image, textFiled: userNameTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        
        let textField = Utilies().textField(withPlaceholer: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        
        let textField = Utilies().textField(withPlaceholer: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullNameTextField: UITextField = {
        
        let textField = Utilies().textField(withPlaceholer: "Full Name")
        return textField
    }()
    
    private let userNameTextField: UITextField = {
        
        let textField = Utilies().textField(withPlaceholer: "UserName")
        return textField
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .DG
        button.setTitleColor(.W1, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilies().attributedButton("Already have an account", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI() 
    }
    
    // MARK: - Selectors
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        
        guard let profileImage = profileImage else { return }
        
        guard let email = emailTextField.text else { return }
        guard let password  = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = userNameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, username: userName, fullname: fullName, password: password, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.setBackgroundView()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       fullNameContainerView,
                                                       userNameContainerView,
                                                       registrationButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor, paddingLeft: 40,
                                        paddingBottom: 16, paddingRight: 40)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
