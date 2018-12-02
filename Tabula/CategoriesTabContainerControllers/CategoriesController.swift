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
    func setSpecific(Name: String, ID: Int, item: Item)
    
}

class CategoriesController: UIViewController, CategoriesCellDelegate {
    
    @IBOutlet weak var collectionViewFlowDelegate: UICollectionViewFlowLayout!
    weak var containerDelegate: ContainerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    let inset : CGFloat = 10.0
    let lineSpacing : CGFloat = 8.0
    let itemSpacing : CGFloat = 4.0
    let numberOfItemsOnRow :CGFloat = 2.0
    
    
    var categories = Categories()
    var netService = NetworkServices()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        netService.getCategories { (categories) in
            self.categories = categories
            self.collectionView.reloadData()
        }
    }
    
    
    func categoryTapped(_ sender: CategoriesCell, value:String) {

        guard let tappedIndexPath = collectionView.indexPath(for: sender) else { return }
        print("Index: ", tappedIndexPath.row)
        
        containerDelegate?.setCategory(value: value)
        
    
    }
    
    func getIcon(name: String)->UIImage{
        var image = UIImage()
        
        if name == "Medical"{
            let icon = UIImage(named: "medicalIcon")
            image = icon!
        } else if name == "Auto-Service"{
            let icon = UIImage(named: "autoServiceIcon")
            image = icon!
        } else if name == "Barbers"{
            let icon = UIImage(named: "barbersIcon")
            image = icon!
        } else if name == "IT"{
            let icon = UIImage(named: "ITIcon")
            image = icon!
        } else if name == "Coffee Shop"{
            let icon = UIImage(named: "coffeeIcon")
            image = icon!
        }
        return image
    }
    
    
    
    
    

}


extension CategoriesController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.Categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
                cell.containerView.layer.cornerRadius = cell.containerView.frame.size.width / 40
                cell.containerView.backgroundColor = UIColor.white
                cell.iconView.image = getIcon(name: categories.Categories[indexPath.item].Name!)
                cell.dropShadow(color: .gray, opacity: 0.8, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
                cell.containerView.clipsToBounds = true;
                cell.categoryNameLabel.text = categories.Categories[indexPath.item].Name
                cell.delegate = self
        
        return cell
    }
     
}

extension CategoriesController: UICollectionViewDelegateFlowLayout{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let cellWidth =  Int((collectionView.frame.width / numberOfItemsOnRow) - (inset+itemSpacing))
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return itemSpacing
    }
    
    
}
