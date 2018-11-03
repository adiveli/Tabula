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
    
    weak var delegate : ServiceDelegate!
    
    var servicesArray = ServiceArray()
    
    var netService = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}
