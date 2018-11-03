//
//  PromotionCollectionController.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout

class PromotionCollectionController: UIViewController{
    
    weak var delegate : PromotionsControllerDelegate?
    
    fileprivate var portraitLayout: ADMozaikLayout {
        let layout = ADMozaikLayout(delegate: self)
        return layout;
    }
    
    var netService = NetworkServices()
    var promotions = PromotionsArray()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.setCollectionViewLayout(self.portraitLayout, animated: animated)
        fetchData()
    }
    

    func fetchData(){
        
        netService.getPromotions { (items) in
            self.promotions = items
            self.collectionView.reloadData()
        }
        
    }
}

extension PromotionCollectionController : UICollectionViewDataSource,ADMozaikLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotions.Promotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var specificCell = UICollectionViewCell()
        if promotions.Promotions[indexPath.item].VoucherType == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type1", for: indexPath) as! PromotionCardType1Cell
            cell.imageView.image = UIImage(named: "CardType\(promotions.Promotions[indexPath.row].VoucherType ?? 1)")
            cell.descriptionLabel.text = promotions.Promotions[indexPath.item].Description
            cell.titleLabel.text = promotions.Promotions[indexPath.item].Name
            cell.voucherLabel.text = promotions.Promotions[indexPath.item].VoucherCode
            //cell.specializationIcon.image =
            specificCell = cell
        }
        else if promotions.Promotions[indexPath.item].VoucherType == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type2", for: indexPath) as! PromotionCardType2Cell
            cell.imageView.image = UIImage(named: "CardType\(promotions.Promotions[indexPath.row].VoucherType ?? 2)")
            cell.titleLabel.text = promotions.Promotions[indexPath.item].Name
            cell.descriptionLabel.text = promotions.Promotions[indexPath.item].Description
            
            specificCell = cell
        }
        else if promotions.Promotions[indexPath.item].VoucherType == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type3", for: indexPath) as! PromotionCardType3Cell
            cell.imageView.image = UIImage(named: "CardType\(promotions.Promotions[indexPath.row].VoucherType ?? 3)")
            cell.descriptionLabel.text = promotions.Promotions[indexPath.item].Name
            cell.titleLabel.text = promotions.Promotions[indexPath.item].Description
            specificCell = cell
        }
        return specificCell
    }
    
    func collectionView(_ collectionView: UICollectionView, mozaik layout: ADMozaikLayout, mozaikSizeForItemAt indexPath: IndexPath) -> ADMozaikLayoutSize {
        if promotions.Promotions[indexPath.item].VoucherType == 1{
            let label = UILabel()
            label.text = "text"
            
            
            return ADMozaikLayoutSize(numberOfColumns: 4, numberOfRows: 2)
        }
        else if promotions.Promotions[indexPath.item].VoucherType == 2 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 2)
        }
        else if promotions.Promotions[indexPath.item].VoucherType == 3 {
            return ADMozaikLayoutSize(numberOfColumns: 4, numberOfRows: 1)
        }
        else {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
        }
    }
    
    func collectonView(_ collectionView: UICollectionView, mozaik layoyt: ADMozaikLayout, geometryInfoFor section: ADMozaikLayoutSection) -> ADMozaikLayoutSectionGeometryInfo {
        let rowHeight: CGFloat = collectionView.frame.width/4+20
        let spacing : CGFloat = 5
        let columns = [ADMozaikLayoutColumn(width: collectionView.frame.width/4-spacing), ADMozaikLayoutColumn(width: collectionView.frame.width/4-spacing), ADMozaikLayoutColumn(width: collectionView.frame.width/4-spacing), ADMozaikLayoutColumn(width: collectionView.frame.width/4-spacing)]
        let geometryInfo = ADMozaikLayoutSectionGeometryInfo(rowHeight: rowHeight,
                                                             columns: columns,
                                                             minimumInteritemSpacing: 5,
                                                             minimumLineSpacing: spacing,
                                                             sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                                                             headerHeight: 0, footerHeight: 0)
        return geometryInfo
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sendTap(id: promotions.Promotions[indexPath.item].CompanyID!, name: promotions.Promotions[indexPath.item].Name!)
    }
    
    
    
    
}
