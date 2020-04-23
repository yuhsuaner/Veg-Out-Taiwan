//
//  LogInViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import AuthenticationServices

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var backgroundView: UIView! {
        
        didSet {
//            backgroundView.setBackgroundView()
            backgroundView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var accountView: UIView! {
        
        didSet {
            accountView.layer.cornerRadius = 15
            accountView.layer.borderColor = UIColor.W1?.cgColor
            accountView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var passwordView: UIView! {
        
        didSet {
            passwordView.layer.cornerRadius = 15
            passwordView.layer.borderColor = UIColor.W1?.cgColor
            passwordView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var enterButton: UIButton! {
        
        didSet {
            enterButton.layer.cornerRadius = 15
            enterButton.layer.shadowColor = UIColor.black.cgColor
            enterButton.layer.shadowOpacity = 0.6
            enterButton.layer.shadowRadius = 5
            enterButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
    }
    
    func setupAppleSignInView() {
        let appleButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .white)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.cornerRadius = 25

        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        
        backgroundView.addSubview(appleButton)
        NSLayoutConstraint.activate([
            appleButton.bottomAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 110),
            appleButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            appleButton.widthAnchor.constraint(equalTo: enterButton.widthAnchor),
            appleButton.heightAnchor.constraint(equalTo: enterButton.heightAnchor)
        ])
    }
    
    @IBAction func handleCancelAction(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func handleEnterAction(_ sender: UIButton) {
        
    }
    
    @IBAction func handleSignup(_ sender: UIButton) {
        
        let controller = SignUpViewController()
        navigationController?.pushViewController(controller, animated: true)
        
        guard let viewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "SignUpVC") as? SignUpViewController else { return }

        show(viewController, sender: nil)
        
//        guard let authVC =
//        UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(
//                withIdentifier: String(describing: SignUpViewController.self))
//                as? SignUpViewController else { return }
//
//        authVC.modalPresentationStyle = .popover
//        present(authVC, animated: false, completion: nil)
        
    }
    
    @IBAction func handleForgotPassword(_ sender: UIButton) {
        
    }
    
    @objc func didTapAppleButton() {
        print("APPLE Sign in")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupAppleSignInView()
    }
    
    // MARK: - Helper

    func configureUI() {
        
    }
}
