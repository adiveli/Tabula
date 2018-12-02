//
//  AccountController.swift
//  Tabula
//
//  Created by Adi Veliman on 18/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Alamofire

class UserAccountController: UIViewController{
    
    

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var verificationIcon: UIImageView!
    
    @IBOutlet weak var shadowContainer: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let defaultValues = UserDefaults.standard
    var netService = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.image = UIImage(named: "insertPhoto")
        
        let firstName = defaultValues.string(forKey: "firstName")
        let lastName = defaultValues.string(forKey: "lastName")
        
        usernameLabel.text = "\(firstName as! String) \(lastName as! String)"
        shadowContainer.dropShadow(color: .gray, opacity: 0.8, offSet: CGSize(width: -1, height: 1), radius: 10, scale: true)
        
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
        
        
        
        setProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 2.0
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
    }
    
    
    func setProfileImage(){
    
        if self.defaultValues.object(forKey: "userPhoto") as! String != ""{
            progressBar.isHidden = false
            progressBar.progress = 0
            profileImage.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "userPhoto") as! String)!).downloadProgress { (progress) in
                self.progressBar.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progressBar.isHidden = true
                    self.profileImage.image = UIImage(data: data.result.value!)
                    
            }
        }else{
            
            self.profileImage.image = UIImage(named: "insertPhoto")
            self.progressBar.isHidden = true
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userSettings"{
            let vc = segue.destination as! UserSettings
            vc.onSave = {(photo: UIImage) -> () in
                self.profileImage.image = photo
                self.netService.savePhoto(userID: self.defaultValues.integer(forKey: "userid"), deleteRef: self.defaultValues.object(forKey: "userPhoto") as! String, photo: photo, completion: { (url) in
                    self.defaultValues.set(url, forKey: "userPhoto")
                })
            }
            vc.exit = {(state: Bool) -> () in
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
        }
    }
    
    
}


