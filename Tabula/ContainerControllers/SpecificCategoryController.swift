//
//  SpecificCategoryController.swift
//  Tabula
//
//  Created by Adi Veliman on 13/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


protocol CategoriesControllerDelegate : class {
    func categoryTapped(_ sender: Int)
}

protocol SpecificCellDelegate : class {
    func specificCategoryTapped(_ sender: SpecificCategoryCell, Name : String, ID: Int)
}

class SpecificCategoryController: UIViewController, CategoriesControllerDelegate, SpecificCellDelegate {
    
    
    
 
    weak var containerDelegate : ContainerDelegate!
    
    var netService = NetworkServices()
    var items = ItemArray()
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var specificLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        netService.getItems(identifier: specificLabel.text!) { (items) in
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.items.items = []
        tableView.reloadData()
    }
    
    func categoryTapped(_ sender: Int) {
        print("Index: \(sender)")
    }
    
    func specificCategoryTapped(_ sender: SpecificCategoryCell, Name: String, ID: Int) {
        containerDelegate.setSpecific(Name: Name, ID: ID)
    }
    
    

}

extension SpecificCategoryController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificCell") as! SpecificCategoryCell
        cell.nameLabel.text = items.items[indexPath.row].Name
        cell.addressLabel.text = items.items[indexPath.row].Address
        cell.descriptionLabel.text = items.items[indexPath.row].Description
        cell.idCompany = items.items[indexPath.row].ID!
        cell.availabilityLabel.text = "Locuri libere"
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.items.count
    }
    
    
    
    
}
