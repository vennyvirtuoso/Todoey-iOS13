//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemAray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Find Mike"
        itemAray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Mike"
        itemAray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Mike"
        itemAray.append(newItem3)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemAray = items
        }
        
    }
    // MARK -Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemAray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemAray[indexPath.row] // item in the cell
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none     // terniary operator
        
        return cell
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedItem = itemAray[indexPath.row]
//        print("Selected item: \(selectedItem)")
        itemAray[indexPath.row].done = !itemAray[indexPath.row].done
        self.tableView.reloadData()
    }
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            // what will happen once the uer clicks the Add Item button on our UIAlert
            if let textField = alert.textFields?.first{
                
                let newItem=Item()
                newItem.title = textField.text!
                self.itemAray.append(newItem);
                self.defaults.set(self.itemAray, forKey: "TodoListArray") // storing in the device with key TodoListArray
                self.tableView.reloadData()
            }
        }
        
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new item"
//            print(alertTextField.text)
//        }
            alert.addAction(action)
        
            present(alert,animated: true, completion: nil)
        
        
    }
    

}

