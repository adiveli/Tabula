//
//  SpecificController.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Auk


protocol ServiceDelegate: class{
    func prepareServices(sir: [String])
}

class SpecificController: UIViewController {
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var shadowContainer: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var appointmentButton: UIButton!
    
    var container : ContainerViewController!
    
    var companyID : Int!
    var itemProperties : Item!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesButton.setImage(UIImage(named: "ServiceIconColor"), for: UIControlState.normal)
        //scrollView.auk.removeAll()
        
        scrollView.layer.borderColor = UIColor.black.cgColor
        scrollView.layer.borderWidth = 1.0
        scrollView.layer.cornerRadius = scrollView.frame.size.width/30
        scrollView.clipsToBounds = true
        
        
        //containerView.layer.borderColor = UIColor.black.cgColor
        //containerView.layer.borderWidth = 1.0
        //containerView.layer.cornerRadius = containerView.frame.size.width/30
        //containerView.clipsToBounds = true
        
        
//        containerView.layer.shadowColor = UIColor.gray.cgColor
//        containerView.layer.shadowOpacity = 1.2
//        containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        containerView.layer.shadowRadius = 10
//        containerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: containerView.bounds.origin.x, y: containerView.bounds.origin.y, width: containerView.bounds.width, height: containerView.bounds.height+80)).cgPath
        
        shadowContainer.layer.cornerRadius = shadowContainer.frame.size.width/30
        shadowContainer.layer.shadowColor = UIColor.gray.cgColor
        shadowContainer.layer.shadowOpacity = 1.2
        shadowContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowContainer.layer.shadowRadius = 10
        shadowContainer.layer.shadowPath = UIBezierPath(rect: CGRect(x: shadowContainer.bounds.origin.x, y: shadowContainer.bounds.origin.y, width: shadowContainer.bounds.width, height: shadowContainer.bounds.height)).cgPath
        
        //shadowContainer.clipsToBounds = true
        //print(itemProperties)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        scrollView.auk.removeAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollViewSetup()
        
    }
    
    
    
    
    
    @IBAction func servicesPressed(_ sender: Any) {
        reviewButton.setImage(UIImage(named: "reviewsIcon"), for: UIControlState.normal)
        appointmentButton.setImage(UIImage(named: "AppointmentsIcon"), for: UIControlState.normal)
        servicesButton.setImage(UIImage(named: "ServiceIconColor"), for: UIControlState.normal)
        container.segueIdentifierReceivedFromParent("services")
        if let specificController = self.container.currentViewController as? ServicesController{
            print("Services")
        }
        
    }
    
    @IBAction func reviewPressed(_ sender: Any) {
        reviewButton.setImage(UIImage(named: "reviewsIconColor"), for: UIControlState.normal)
        appointmentButton.setImage(UIImage(named: "AppointmentsIcon"), for: UIControlState.normal)
        servicesButton.setImage(UIImage(named: "ServiceIcon"), for: UIControlState.normal)
        container.segueIdentifierReceivedFromParent("reviews")
        if let specificController = self.container.currentViewController as? ReviewsController{
            specificController.fetchData(company: companyID)
            specificController.companyID = companyID
        }
    }
    @IBAction func appointmentPressed(_ sender: Any) {
        reviewButton.setImage(UIImage(named: "reviewsIcon"), for: UIControlState.normal)
        appointmentButton.setImage(UIImage(named: "AppointmentsIconColor"), for: UIControlState.normal)
        servicesButton.setImage(UIImage(named: "ServiceIcon"), for: UIControlState.normal)
        container.segueIdentifierReceivedFromParent("appointments")
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
    
    
    func scrollViewSetup(){
        //print(itemProperties!.Photo1)
        scrollView.auk.settings.contentMode = .scaleAspectFill
        scrollView.auk.settings.placeholderImage = UIImage(named: "loading")
        
        if itemProperties.Photo1 != ""{
            scrollView.auk.show(url: itemProperties.Photo1 as! String)
            
        }
        if itemProperties.Photo2 != ""{
            scrollView.auk.show(url: itemProperties.Photo2 as! String)
        }
        if itemProperties.Photo3 != ""{
            scrollView.auk.show(url: itemProperties.Photo3 as! String)
        }
        if itemProperties.Photo4 != ""{
            scrollView.auk.show(url: itemProperties.Photo4 as! String)
        }
        if itemProperties.Photo5 != ""{
            scrollView.auk.show(url: itemProperties.Photo5 as! String)
        }
        if itemProperties.Photo6 != ""{
            scrollView.auk.show(url: itemProperties.Photo6 as! String)
        }
        
    
        // Return the number of pages in the scroll view
        if scrollView.auk.numberOfPages == 0{
            scrollView.auk.settings.contentMode = .scaleAspectFit
            scrollView.auk.show(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png")
        }
        
        scrollView.auk.startAutoScroll(delaySeconds: 3)
        
        
        
        
    }

}
