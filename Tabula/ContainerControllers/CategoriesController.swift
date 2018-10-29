//
//  CategoriesController.swift
//  Tabula
//
//  Created by Adi Veliman on 13/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


protocol CategoriesCellDelegate : class {
    func categoryTapped(_ sender: CategoriesCell, value : String)
}


protocol ContainerDelegate : class{
    
    func setCategory(value: String)
    func setSpecific(Name: String, ID: Int)
    
}

class CategoriesController: UIViewController, CategoriesCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var containerDelegate: ContainerDelegate?
    
    var categories = Categories()
    var netService = NetworkServices()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        netService.getCategories { (categories) in
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    
    func categoryTapped(_ sender: CategoriesCell, value:String) {

        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("Index: ", tappedIndexPath.row)
        
        containerDelegate?.setCategory(value: value)
        
    
    }
    
    
    
    
    

}

extension CategoriesController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.Categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.containerView.layer.cornerRadius = cell.containerView.frame.size.width / 6
        cell.containerView.backgroundColor = UIColor.random()
        cell.containerView.clipsToBounds = true;
        cell.categoryNameLabel.text = categories.Categories[indexPath.row].Name
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    
}
