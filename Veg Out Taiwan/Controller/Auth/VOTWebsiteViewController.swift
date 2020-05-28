//
//  VOTWebsiteViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/28.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import WebKit

class VOTWebsiteViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    private let webView = WKWebView(frame: .zero)
    
    var votUrl: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        // You can set constant space for Left, Right, Top and Bottom Anchors
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        // For constant height use the below constraint and set your height constant and remove either top or bottom constraint
        //self.webView.heightAnchor.constraint(equalToConstant: 200.0),
        
        self.view.setNeedsLayout()
        guard let votUrl = votUrl else { return }
        let request = URLRequest(url: URL.init(string: votUrl)!)
        self.webView.load(request)
        
        
        
        
        //        configureUI()
        //
        //        guard let url = URL(string: votUrl!) else { return }
        //        let request = URLRequest(url: url)
        //        webView.load(request)
    }
    
    // MARK: - Helper
    func configureUI () {
        
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor,
                       bottom: view.bottomAnchor, right: view.rightAnchor)
        
        //        view.addSubview(indicatorView)
        //        indicatorView.centerX(inView: view)
        //        indicatorView.centerY(inView: view)
    }
}
