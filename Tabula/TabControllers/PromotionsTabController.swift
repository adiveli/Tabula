//
//  PromotionsTabController.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

protocol PromotionsControllerDelegate : class{
    
    func sendTap(id: Int,name: String)
    
}

class PromotionsTabController: UIViewController,PromotionsControllerDelegate {
    
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var container : ContainerViewController!
    
    
    var netService = NetworkServices()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
   
    
    override func viewDidDisappear(_ animated: Bool) {
        container.segueIdentifierReceivedFromParent("promotionsController")
        backButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let specificController = self.container.currentViewController as? PromotionCollectionController{
            specificController.delegate = self
    }
        
    }
    

    @IBAction func backPressed(_ sender: Any) {
        container.segueIdentifierReceivedFromParent("promotionsController")
        backButton.isHidden = true
    }
    
    
    func sendTap(id: Int, name: String) {
        print("John")
        container.segueIdentifierReceivedFromParent("toSpecificController")
        backButton.isHidden = false
        
        
        if let specificController = self.container.currentViewController as? SpecificController{
            specificController.nameLabel.text = name
            specificController.companyID = id
            
            /////////maintain different data for every company////////
            specificController.container.segueIdentifierReceivedFromParent("services")
            specificController.reviewButton.setImage(UIImage(named: "reviewsIcon"), for: UIControlState.normal)
            specificController.appointmentButton.setImage(UIImage(named: "AppointmentsIcon"), for: UIControlState.normal)
            specificController.servicesButton.setImage(UIImage(named: "ServiceIconColor"), for: UIControlState.normal)
            ///////////////////////////////////////////////////////////
            
            if let serviceController = specificController.container.currentViewController as? ServicesController{
                serviceController.fetchData(company: id)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container2"{
            container = segue.destination as! ContainerViewController
            
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.1, .transitionCrossDissolve)
        }
    }
   
}
