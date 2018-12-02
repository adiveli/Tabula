//
//  LoginController.swift
//  Tabula
//
//  Created by Adi Veliman on 11/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import FacebookCore
import FacebookLogin

class LoginController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate{
    
    
    let URL_USER_LOGIN = "https://vaportofolio.ro/php/v1/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var googleButton : UIButton!
    
    var netService = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleButton.addTarget(self, action: #selector(signInUsingGoogle(_:)), for: .touchUpInside)
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrationPressed(_ sender: Any) {
        performSegue(withIdentifier: "toRegistration", sender: nil)
    }
    
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        performSegue(withIdentifier: "forgotPasswordSubmission", sender: nil)
    }
    
    
    
    
    ///////////////////// GOOGLE LOGIN //////////////////////////////
    
    @objc func signInUsingGoogle(_ sender: UIButton){
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("Error signing in: \(error.localizedDescription)")
        }else{
            if let gmailUser = user{
                print("working!\(gmailUser.profile.email)")
                self.performSegue(withIdentifier: "loginSucceded", sender: nil)
            }
        }
    }

    ///////////////////////////////////////////////////////////////////
    
    
    ///////////////////// Facebook LOGIN //////////////////////////////
    
    
    @IBAction func loginWithFacebook(_ sender: Any){
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result{
            case .cancelled:
                print("User cancelled login!")
                break
            case .failed(let error):
                print("Login failed with error: \(error.localizedDescription)")
                break
            case .success(let grantedPermissions, let declinedPermisions, let accessToken):
                print("Acces token: \(accessToken)")
                self.performSegue(withIdentifier: "loginSucceded", sender: nil)
            
           }
        }
        
        
    }
    
    
    ///////////////////////////////////////////////////////////////////
    
    @IBAction func signInPressed(_ sender: Any) {
        
        //getting the username and password
        let parameters: Parameters=[
            "Email":emailField.text!,
            "Password":passwordField.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "ID") as! Int
                        let firstName = user.value(forKey: "FirstName") as! String
                        let lastName = user.value(forKey: "LastName") as! String
                        let userPhone = user.value(forKey: "TN") as! String
                        let email = user.value(forKey: "Email") as! String
                        let cnp = user.value(forKey: "CNP") as! String
                        let accountType = user.value(forKey: "COMPANY") as! Int
                        let validation = user.value(forKey: "VALIDATION") as! Int
                        let userPhotoURL = user.value(forKey: "Photo") as? String
                        let companyID = user.value(forKey: "CompanyID") as? Int
                        
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(firstName, forKey: "firstName")
                        self.defaultValues.set(lastName, forKey: "lastName")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        self.defaultValues.set(email, forKey: "email")
                        self.defaultValues.set(cnp, forKey: "cnp")
                        self.defaultValues.set(accountType, forKey: "accountType")
                        self.defaultValues.set(validation, forKey: "validation")
                        self.defaultValues.set(companyID, forKey: "cid")
                        self.defaultValues.set(userPhotoURL, forKey: "userPhoto")
                        
                        //switching the screen
                        
                        
                        self.performSegue(withIdentifier: "loginSucceded", sender: nil)
                        
                    }else{
                        //error message in case of invalid credential
                        print("Invalid username or password")
                    }
                }
        }
        
    }
    

}
