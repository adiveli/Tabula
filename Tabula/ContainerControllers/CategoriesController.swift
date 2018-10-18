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
    func setSpecific(value: String)
    
}

class CategoriesController: UIViewController, CategoriesCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var containerDelegate: ContainerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func categoryTapped(_ sender: CategoriesCell, value:String) {

        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("Index: ", tappedIndexPath.row)
        
        containerDelegate?.setCategory(value: value)
        
    
    }
    
    

}

extension CategoriesController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.containerView.layer.cornerRadius = cell.containerView.frame.size.width / 6
        cell.containerView.clipsToBounds = true;
        cell.categoryNameLabel.text = "Barbers"
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
}
