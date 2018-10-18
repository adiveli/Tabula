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
    func specificCategoryTapped(_ sender: SpecificCategoryCell, value : String)
}

class SpecificCategoryController: UIViewController, CategoriesControllerDelegate, SpecificCellDelegate {
    
 
    weak var containerDelegate : ContainerDelegate!
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var specificLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func categoryTapped(_ sender: Int) {
        print("Index: \(sender)")
    }
    
    func specificCategoryTapped(_ sender: SpecificCategoryCell, value: String) {
        print("laba")
        containerDelegate.setSpecific(value: value)
    }
    
    
    

}

extension SpecificCategoryController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificCell") as! SpecificCategoryCell
        cell.nameLabel.text = "Dr. Lupu"
        cell.addressLabel.text = "Strada penisului belit"
        cell.descriptionLabel.text = "Cel mai fita cabinet oferim tot ce se poate de la muie pana la spalari pe dinti. Nu ratati ocazia unica"
        cell.availabilityLabel.text = "Locuri libere"
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    
    
}
