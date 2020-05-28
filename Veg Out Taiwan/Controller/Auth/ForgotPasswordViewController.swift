//
//  ForgotPasswordViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/28.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper
    func configureUI() {
        
        setupEmailTextField()
        
        setupResetButton()
    }
    
    func setupEmailTextField() {
        
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor.lightGray.cgColor
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        emailTextField.borderStyle = .none
        emailTextField.textColor = .darkGray
        
        let placeholderAttr = NSAttributedString(string: "Email Address",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        emailTextField.attributedPlaceholder = placeholderAttr
        
    }
    
    func setupResetButton() {
        
        resetButton.layer.cornerRadius = 5
    }
    
    @IBAction func dissmissAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRestsetPassword(_ sender: Any) {
        
        guard
            let email = emailTextField.text,
            email != "" else {
                
                VOTProgressHUD.showFailure(text: "請輸入您的Eamil喔！")
                
                return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            
            if let error = err {
                VOTProgressHUD.showFailure()
                print(error.localizedDescription)
                return
            }
            
            self.view.endEditing(true)
            VOTProgressHUD.showSuccess(text: "VOT 已經寄出重新設置密碼信至您的信箱，請查看您的信箱並進行重設密碼，謝謝。")
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
}
