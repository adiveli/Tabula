//
//  CompanySettings.swift
//  Tabula
//
//  Created by Adi Veliman on 07/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox

class CompanySettings: UITableViewController {
    
    var modifyImagesState : ((_ value: Bool)->())?
    var exit: ((_ state: Bool)->())?
    var onClick: (()->())?
    var imagesState = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        exit?(true)
    }
    
    @IBAction func changePhotosClicked(_ sender: Any) {
       
       imagesState = !imagesState
       modifyImagesState?(imagesState)
        
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
    }
    @IBAction func addPromotionClicked(_ sender: Any) {
        onClick?()
    }
    @IBAction func helpCentrePressed(_ sender: Any) {
        performSegue(withIdentifier: "showFAQ", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = UIColor.white
        header.textLabel?.textColor = UIColor.black
        header.contentView.backgroundColor = UIColor.white
        let linie = UIImageView(frame: CGRect(x: 0, y: 27, width: tableView.frame.size.width, height: 2))
        linie.image = UIImage(named: "Linie")
        header.addSubview(linie)
        
    }

    
}


extension CompanySettings : ImagePickerDelegate{
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else {return}
        dismiss(animated: true, completion: nil)
       
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
