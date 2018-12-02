//
//  SpecificCategoryController.swift
//  Tabula
//
//  Created by Adi Veliman on 13/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Kingfisher


protocol CategoriesControllerDelegate : class {
    func categoryTapped(_ sender: Int)
}

protocol SpecificCellDelegate : class {
    func specificCategoryTapped(_ sender: SpecificCategoryCell, Name : String, ID: Int, itemNr: Int)
}

class SpecificCategoryController: UIViewController, CategoriesControllerDelegate, SpecificCellDelegate {
    
    
    
    
    
 
    weak var containerDelegate : ContainerDelegate!
    
    var netService = NetworkServices()
    var items = ItemArray()
    var photos = [UIImage()]
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var specificLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = UIEdgeInsetsInsetRect(tableView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        netService.getItems(identifier: specificLabel.text!) { (items) in
            self.items = items
            self.tableView.reloadData()
            //self.fetchPhotos()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.items.items = []
        tableView.reloadData()
    }
    
    func categoryTapped(_ sender: Int) {
        print("Index: \(sender)")
    }
    
    func specificCategoryTapped(_ sender: SpecificCategoryCell, Name: String, ID: Int, itemNr: Int) {
        containerDelegate.setSpecific(Name: Name, ID: ID, item: items.items[itemNr])
    }
    
    

}

extension SpecificCategoryController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificCell") as! SpecificCategoryCell
        
        
        
        cell.nameLabel.text = items.items[indexPath.row].Name
        if items.items[indexPath.row].Photo1 != ""{
            let url = URL(string: items.items[indexPath.row].Photo1!)
            cell.companyImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (receivedSize, totalSize) in
                print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
            }) { (image, error, cacheType, imageURL) in
                print("\(indexPath.row + 1): Finished")
            }
        }else{
            cell.companyImage.image = UIImage(named: "no_image")
        }
        cell.addressLabel.text = items.items[indexPath.row].Address
        cell.descriptionLabel.text = items.items[indexPath.row].Description
        cell.idCompany = items.items[indexPath.row].ID!
        cell.ratingStack.settings.fillMode = .precise
        cell.ratingStack.rating = items.items[indexPath.row].Rating!
        cell.itemNr = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }
    
    
    
    
    
    
}
