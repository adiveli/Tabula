//
//  RegistrationController.swift
//  Tabula
//
//  Created by Adi Veliman on 11/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Alamofire
import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cnpField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var telephoneField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    
    //URL for web service
    let URL_USER_REGISTER = "https://vaportofolio.ro/php/v1/register.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInPressed(_ sender: Any) {
        
        
        //creating parameters for the post request
        let parameters: Parameters=[
            "FirstName":firstNameField.text!,
            "LastName":lastNameField.text!,
            "Password":passwordField.text!,
            "CNP":cnpField.text!,
            "TN":telephoneField.text!,
            "Email":emailField.text!,
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    //let jsonData = result as! NSDictionary
                    
                }
        }
        
        
    }
    

}
