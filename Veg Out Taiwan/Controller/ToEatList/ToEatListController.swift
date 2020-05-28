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
    var listType: [ListType] = [
        .wantToGo, .myFavorite, .other
    ]
    
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
        
        checkUser()
        configureUI()
        configureTableView()
        
    }
    
    // MARK: - Helper
    func checkUser() {
        
        
    }

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "ToEatListCell", for: indexPath) as? ToEatListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .W1
        
        switch indexPath.row {
            
        case 0:
            cell.dayLabel.text = "  Want 2 GO"
        case 1:
            cell.dayLabel.text = "  My Favorites"
        default:
            cell.dayLabel.text = "  Other"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = ToEatListDetailsController()
        
        controller.listName = listType[indexPath.item].listName
        controller.bigTitle = listType[indexPath.item].listTitle
        
        navigationController?.pushViewController(controller, animated: true)

    }
}
