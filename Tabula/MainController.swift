//
//  MainController.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class MainController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 || tabBarIndex == 2{
            
        }
    }


}
