//
//  MainController.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class MainController: UITabBarController,UITabBarControllerDelegate {

    let defaultValues = UserDefaults.standard
    var netService = NetworkServices()
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        
        let accountType = defaultValues.integer(forKey: "accountType")
        let userAssociatedCompanyID = defaultValues.integer(forKey: "cid")
        if(accountType == 0){
            
            let user = storyboard!.instantiateViewController(withIdentifier: "UserAccount") as! UserAccountController
            user.tabBarItem.title = "Account"
            user.tabBarItem.image = UIImage(named: "accountIcon")
            self.viewControllers?.append(user)
            
        }else{
            
            let details = netService.getCompanyDetails(identifier: userAssociatedCompanyID) { (item) in
                self.defaultValues.set(item.items[0].Address, forKey: "companyAddress")
                self.defaultValues.set(item.items[0].Name, forKey: "companyName")
                self.defaultValues.set(item.items[0].Description, forKey: "companyDescription")
                self.defaultValues.set(item.items[0].Photo1, forKey: "companyPhoto1")
                self.defaultValues.set(item.items[0].Photo2, forKey: "companyPhoto2")
                self.defaultValues.set(item.items[0].Photo3, forKey: "companyPhoto3")
                self.defaultValues.set(item.items[0].Photo4, forKey: "companyPhoto4")
                self.defaultValues.set(item.items[0].Photo5, forKey: "companyPhoto5")
                self.defaultValues.set(item.items[0].Photo6, forKey: "companyPhoto6")
                
            }
            let company = storyboard!.instantiateViewController(withIdentifier: "CompanyAccount") as! CompanyAccountController
            company.tabBarItem.title = "Account"
            company.tabBarItem.image = UIImage(named: "accountIcon")
            self.viewControllers?.append(company)
            
        }
            
        
        
    }
    

    
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 || tabBarIndex == 2{
            
        }
    }
    
   


}
