//
//  AddPromotionController.swift
//  Tabula
//
//  Created by Adi Veliman on 10/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class AddPromotionController: UIViewController {

    var container : ContainerViewController!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var closePopUp : UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius = viewContainer.frame.size.width/12
        viewContainer.clipsToBounds = true
        backButton.isHidden = true
        // Do any additional setup after loading the view.
        
        if let specificController = self.container.currentViewController as? SelectionController{
            specificController.onTap = {(index:Int) -> () in
             self.container.segueIdentifierReceivedFromParent("customizationStage")
                
                if let specificController = self.container.currentViewController as? CustomizationController{
                    
                    specificController.setIndex(index: index)
                }
            }
            
        }
    }
    
    
    @IBAction func closePopUpPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
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

}
