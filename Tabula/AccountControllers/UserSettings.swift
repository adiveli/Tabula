//
//  UserSettings.swift
//  Tabula
//
//  Created by Adi Veliman on 06/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox


class UserSettings: UITableViewController {
    
    var onSave: ((_ image: UIImage)->())?
    var exit: ((_ state: Bool)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false

    }

    @IBAction func changePhotoPressed(_ sender: Any) {
        let config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowVideoSelection = false
        
        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.imageLimit = 1
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func changePasswordPressed(_ sender: Any) {
    }
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        exit?(true)
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
    
    @IBAction func helpCentrePressed(_ sender: Any) {
        performSegue(withIdentifier: "showFAQ", sender: nil)
    }
}

extension UserSettings : ImagePickerDelegate{
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
        onSave?(images[0])
        dismiss(animated: true, completion: nil)
        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


