//
//  ViewController.swift
//  Swipe-able TableView Cell
//
//  Created by Рустам on 24.09.2019.
//  Copyright © 2019 Рустам Амирханов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = ["Alex", "Amir", "Anna", "Vicrotia", "Vladimir"]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }

    fileprivate func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func setupNavigationBar() {
        
        title = "Swipe-able Cell"
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Required methods TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    // Create Swipe-able Cell
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (_, indePath) in
            
            self.showAlert(title: self.dataSource[indexPath.row], message: "Line: \(indexPath.row)")
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, indePath) in
            
            self.dataSource.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.1674376428, green: 0.1674425602, blue: 0.167439878, alpha: 1) // Setting color button
        
        return [deleteAction, shareAction]
    }
    
    // Create AlertController
    
    fileprivate func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .destructive))
        present(alertController, animated: true, completion: nil)
    }
}
