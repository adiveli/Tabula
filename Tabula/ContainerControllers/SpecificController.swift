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
    
    
    
    
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var appointmentButton: UIButton!
    
    var container : ContainerViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesButton.setImage(UIImage(named: "ServiceIconColor"), for: UIControlState.normal)
        
        scrollViewSetup()

        // Do any additional setup after loading the view.
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
            print("Reviews")
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
        
        scrollView.auk.show(url: "https://ziarulunirea.ro/wp-content/uploads/2016/02/stomatologie.jpg")
        scrollView.auk.show(url: "https://media0.webgarden.ro/images/media0:4b648f4b4bbec.png/1.bmp.png")
        scrollView.auk.show(url: "https://media.publika.md/md/image/201604/w720/student_87874900.jpg")
        // Return the number of pages in the scroll view
        scrollView.auk.numberOfPages
        
        // Get the index of the current page or nil if there are no pages
        scrollView.auk.currentPageIndex
        
        // Return currently displayed images
        scrollView.auk.images
        scrollView.auk.startAutoScroll(delaySeconds: 3)
        
        
        
        
    }

}
