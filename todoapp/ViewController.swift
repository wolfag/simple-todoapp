//
//  ViewController.swift
//  todoapp
//
//  Created by wolfag on 14/12/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    
    var items = [String]()
    
    let table:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = "Todo app"
        
        table.dataSource = self
        view.addSubview(table)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.frame = view.bounds
        
        items = UserDefaults.standard.stringArray(forKey: "items") ?? []
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "Add new item", message: "Are you want to add new item", preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = "Enter your item"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        self.items.append(text)
                        self.table.reloadData()
                        
                        UserDefaults.standard.setValue(self.items, forKey: "items")
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }


}

