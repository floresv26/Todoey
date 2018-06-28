//
//  ViewController.swift
//  Todoey
//
//  Created by Vanessa Flores on 6/27/18.
//  Copyright © 2018 Vanessa Flores. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ListItem]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = ListItem()
        newItem.itemTitle = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = ListItem()
        newItem2.itemTitle = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = ListItem()
        newItem3.itemTitle = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [ListItem] {
            itemArray = items
        }
        
    }

    //MARK - TableView Datasource Methods
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.itemTitle
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.itemCompleted ? .checkmark : .none
        
//        if item.itemCompleted == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].itemCompleted = !itemArray[indexPath.row].itemCompleted
        
        tableView.reloadData()
        
        
        // Only highlight selected row for a moment after user selects it
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button  on our UIAlert
            
            let newItem = ListItem()
            newItem.itemTitle = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

