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
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var blurEffectView: UIView!
    @IBOutlet weak var containerTableView: UIView!
    
    var timer: Timer!
    
    var container : ContainerViewController!
    
    var netService = NetworkServices()
    var filterArray = Specializations()
    var pressedFilter = false
    var pressedCategory = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        setFilter()
        backButton.isHidden = true
        filterButton.isHidden = true
        
    }
    
    
    func buttonSetup(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(delegationProcess), userInfo: nil, repeats: true)
    }
    
    @objc func delegationProcess(){
        if let categoriesController = self.container.currentViewController as? CategoriesController{
            categoriesController.containerDelegate = self
        }
        if let specificCategoriesController = self.container.currentViewController as? SpecificCategoryController{
            specificCategoriesController.containerDelegate = self
        }
    }
    

    
    @IBAction func backPressed(_ sender: Any) {
        
        
        ///configure state of buttons through containers
        if (self.container.currentViewController is SpecificController){
            backButton.isHidden = false
            filterButton.isHidden = false
            container.segueIdentifierReceivedFromParent("specificCategory")
            filterTableView.reloadData()
        } else{
            container.segueIdentifierReceivedFromParent("categories")
            backButton.isHidden = true
            filterButton.isHidden = true
        }
        
        buttonSetup()
    }
    
    @IBAction func filterPressed(_ sender: Any) {
        pressedFilter = !pressedFilter
        configureFilter()
        
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
        pressedCategory = value
        print("\(value)")
        netService.getSpecializations(identifier: value) { (filterArray) in
            self.filterTableView.delegate = self
            self.filterTableView.dataSource = self
            self.filterArray = filterArray
            self.filterArray.Specializations.append(Specialization(Specialization: "Remove Filters", ID: 0))
            self.filterTableView.reloadData()
        }
        
        
        if let specificController = self.container.currentViewController as? SpecificCategoryController{
            specificController.specificLabel.text = value
        }
        
    }
    
    func setSpecific(Name: String, ID: Int){
        container.segueIdentifierReceivedFromParent("toSpecific")
        backButton.isHidden = false
        filterButton.isHidden = true
        
        if let specificController = self.container.currentViewController as? SpecificController{
            specificController.nameLabel.text = Name
            if let serviceController = specificController.container.currentViewController as? ServicesController{
                serviceController.fetchData(company: ID)
            }
            
        }
        
    }
    
    ///////////////////////////////Filter functions//////////////////////////////
    
    func setFilter(){
        blurEffectView.alpha = 0
        containerTableView.alpha = 0
        filterTableView.backgroundColor = UIColor.clear
        self.containerTableView.transform = CGAffineTransform(translationX: 0, y: -600)
        
    }
    
    
    func configureFilter(){
        UIView.animate(withDuration: 0.3) {
            if(self.pressedFilter == true){
                self.blurEffectView.isHidden = false
                self.containerTableView.isHidden = false
                self.blurEffectView.alpha = 1
                self.containerTableView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.containerTableView.alpha = 1
                self.containerTableView.backgroundColor = UIColor.clear
                self.blurEffectView.addBlur()
                
                
            }else{
                self.blurEffectView.removeBlurEffect()
                self.containerTableView.transform = CGAffineTransform(translationX: 0, y: -600)
                self.containerTableView.alpha = 0
                self.blurEffectView.isHidden = true
                self.containerTableView.isHidden = true
    
            }
            
        }
        
    }
    
        
        
        //////////////////////////////////////////////////////////////
    

}

///////////////////////////////TABLE VIEW FILTER////////////////////////////////////

extension CategoriesTabController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.Specializations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! CustomCellFilter
        cell.itemLabel.text = filterArray.Specializations[indexPath.row].Specialization
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.backgroundColor = UIColor.clear
        if(filterArray.Specializations[indexPath.row].Specialization == "Remove Filters"){
            cell.itemLabel.textColor = UIColor.blue
        }else{
            cell.itemLabel.textColor = UIColor.black
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.pressedFilter = !self.pressedFilter
        
        
        configureFilter()
        UIView.animate(withDuration: 0.3) {
            self.filterButton.transform = .identity
        }
        
        if(filterArray.Specializations[indexPath.row].Specialization != "Remove Filters"){
        netService.getFilteredItems(identifier: filterArray.Specializations[indexPath.row].ID!) { (result) in
            if let specificController = self.container.currentViewController as? SpecificCategoryController{
                specificController.items = result
                specificController.tableView.reloadData()
            }
           
        }
        }else{
            netService.getItems(identifier: pressedCategory) { (unfilteredItems) in
                if let specificController = self.container.currentViewController as? SpecificCategoryController{
                    specificController.items = unfilteredItems
                    specificController.tableView.reloadData()
                }
            }
            filterTableView.reloadData()
        }
        
    }
    
    
    
}

