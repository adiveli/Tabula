//
//  ServicesController.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


class ServicesController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowContainer : UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate : ServiceDelegate!
    
    var servicesArray = ServiceArray()
    
    var netService = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        shadowContainer.layer.shadowColor = UIColor.gray.cgColor
        shadowContainer.layer.shadowOpacity = 1.2
        shadowContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowContainer.layer.shadowRadius = 10
        shadowContainer.layer.shadowPath = UIBezierPath(rect: CGRect(x: shadowContainer.bounds.origin.x, y: shadowContainer.bounds.origin.y, width: shadowContainer.bounds.width-30, height: shadowContainer.bounds.height-30)).cgPath
        
        //shadowView.layer.cornerRadius = shadowView.frame.size.width/30
        //shadowView.clipsToBounds = true
        tableView.layer.cornerRadius = tableView.frame.size.width/30
        tableView.clipsToBounds = true
        
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.cornerRadius = titleLabel.frame.size.width/4
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func fetchData(company: Int){
        
        netService.getServices(identifier: company) { (services) in
            self.servicesArray = services
            self.tableView.reloadData()
        }
        
        
    }
    
    
    
    
}

extension ServicesController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.serviceLabel.text = servicesArray.Services[indexPath.row].Name
        cell.priceLabel.text = "\(servicesArray.Services[indexPath.row].Price as! Int) RON"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesArray.Services.count
    }
    
    
    
}
