//
//  ToEatListViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/16.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class ToEatListViewController: UIViewController {

    // MARK: - Properties
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.W1
        tableview.separatorStyle = .none
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.backgroundColor = .W1
        
        navigationItem.title = "我的 To Eat List"
    }
    
    func configureTableView() {
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        tableview.register(ToEatListTableViewCell.self, forCellReuseIdentifier: "ToEatListCell")
        tableview.dataSource = self
        tableview.delegate = self
    }
}

// MARK: - UITableView Delegate & DataSource
extension ToEatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "ToEatListCell", for: indexPath) as? ToEatListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.dayLabel.text = "VOT \(indexPath.row+1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
