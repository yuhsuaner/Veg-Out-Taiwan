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
        
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        
        self.view.setNeedsLayout()
        guard let votUrl = votUrl else { return }
        let request = URLRequest(url: URL.init(string: votUrl)!)
        self.webView.load(request)
    }
}
