//
//  CategoriesTabController.swift
//  Tabula
//
//  Created by Adi Veliman on 14/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


class CategoriesTabController: UIViewController, ContainerDelegate {
    
    
    @IBOutlet weak var containerView: UIView!
    
    var timer: Timer!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var container : ContainerViewController!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        
    
    }
    
    
    
    
    @objc func delegationProcess(){
        if let categoriesController = self.container.currentViewController as? CategoriesController{
            categoriesController.containerDelegate = self
        }
        if let specificCategoriesController = self.container.currentViewController as? SpecificCategoryController{
            specificCategoriesController.containerDelegate = self
        }
    }
    
   
    
    
    func buttonSetup(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(delegationProcess), userInfo: nil, repeats: true)
    }
    

    
    @IBAction func backPressed(_ sender: Any) {
        
        if (self.container.currentViewController is SpecificController){
            backButton.isHidden = false
            filterButton.isHidden = false
            container.segueIdentifierReceivedFromParent("specificCategory")
        } else{
            container.segueIdentifierReceivedFromParent("categories")
            backButton.isHidden = true
            filterButton.isHidden = true
        }
        
        buttonSetup()
    }
    
    @IBAction func filterPressed(_ sender: Any) {
  
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
            
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }
    
    
    ///////////////////////////DELEGATION METHODS//////////////////////
    
    func setCategory(value: String) {
        container.segueIdentifierReceivedFromParent("specificCategory")
        backButton.isHidden = false
        filterButton.isHidden = false
        if let specificController = self.container.currentViewController as? SpecificCategoryController{
            specificController.specificLabel.text = value
        }
        
    }
    
    func setSpecific(value: String){
        container.segueIdentifierReceivedFromParent("toSpecific")
        backButton.isHidden = false
        filterButton.isHidden = true
        if let specificController = self.container.currentViewController as? SpecificController{
        }
        
        
    }
    

}
