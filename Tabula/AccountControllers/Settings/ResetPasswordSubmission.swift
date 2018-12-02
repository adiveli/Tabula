//
//  ResetPasswordSubmission.swift
//  Tabula
//
//  Created by Adi Veliman on 25/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class ResetPasswordSubmission: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    var netService = NetworkServices()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitPressed(_ sender: Any) {
        if emailField.text != ""{
        netService.submitPasswordReset(email: emailField.text!) { (succes) in
            if succes{
                self.dismiss(animated: true, completion: nil)
            }
        }
        }else{
            let alert = UIAlertController(title: "Error", message: "No email/username", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default   , handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
