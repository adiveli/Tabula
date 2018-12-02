//
//  CompanyAccountController.swift
//  
//
//  Created by Adi Veliman on 05/11/2018.
//

import UIKit
import Alamofire
import ImagePicker
import Lightbox
import SVProgressHUD
import MaterialComponents.MaterialActivityIndicator



class CompanyAccountController: UIViewController {
    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var photo3: UIImageView!
    @IBOutlet weak var photo4: UIImageView!
    @IBOutlet weak var photo5: UIImageView!
    @IBOutlet weak var photo6: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoContainer: UIView!
    
    
    let progress1 = MDCActivityIndicator()
    let progress2 = MDCActivityIndicator()
    let progress3 = MDCActivityIndicator()
    let progress4 = MDCActivityIndicator()
    let progress5 = MDCActivityIndicator()
    let progress6 = MDCActivityIndicator()
    
    @IBOutlet weak var viewContainer6: UIView!
    @IBOutlet weak var viewContainer5: UIView!
    @IBOutlet weak var viewContainer1: UIView!
    @IBOutlet weak var viewContainer2: UIView!
    @IBOutlet weak var viewContainer3: UIView!
    @IBOutlet weak var viewContainer4: UIView!
    
    @IBOutlet weak var addImageButton1: UIButton!
    @IBOutlet weak var addImageButton2: UIButton!
    @IBOutlet weak var addImageButton3: UIButton!
    @IBOutlet weak var addImageButton6: UIButton!
    @IBOutlet weak var addImageButton5: UIButton!
    @IBOutlet weak var addImageButton4: UIButton!
    
    var selectedImage = Int()
    let defaultValues = UserDefaults.standard
    var netService = NetworkServices()
    var imageViews = [UIImageView]()
    var oldImageRefs = [String]()
    var nameRefs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProgressBars()
        setImages()
        hideModifyIcons()
        
        
        
        nameLabel.text = defaultValues.object(forKey: "companyName") as! String
        
        photoContainer.dropShadow(color: .gray, opacity: 0.8, offSet: CGSize(width: -1, height: 1), radius: 10, scale: true)
        
        nameRefs.append("companyPhoto1")
        nameRefs.append("companyPhoto2")
        nameRefs.append("companyPhoto3")
        nameRefs.append("companyPhoto4")
        nameRefs.append("companyPhoto5")
        nameRefs.append("companyPhoto6")
        
    
        // Do any additional setup after loading the view.
    }
    
    
    
    func setProgressBars(){

        
        //progress1.sizeToFit()
        //progress2.sizeToFit()
        //progress3.sizeToFit()
        //progress4.sizeToFit()
        //progress5.sizeToFit()
        //progress6.sizeToFit()
        
//        progress1.indicatorMode = .determinate
//        progress2.indicatorMode = .determinate
//        progress3.indicatorMode = .determinate
//        progress4.indicatorMode = .determinate
//        progress5.indicatorMode = .determinate
//        progress6.indicatorMode = .determinate
        
        progress1.cycleColors = [.orange]
        progress2.cycleColors = [.orange]
        progress3.cycleColors = [.orange]
        progress4.cycleColors = [.orange]
        progress5.cycleColors = [.orange]
        progress6.cycleColors = [.orange]
        
        viewContainer1.addSubview(progress1)
        viewContainer2.addSubview(progress2)
        viewContainer3.addSubview(progress3)
        viewContainer4.addSubview(progress4)
        viewContainer5.addSubview(progress5)
        viewContainer6.addSubview(progress6)
        
        setupActivityIndicatorViewConstraints()
        
        self.imageViews.append(photo1)
        self.imageViews.append(photo2)
        self.imageViews.append(photo3)
        self.imageViews.append(photo4)
        self.imageViews.append(photo5)
        self.imageViews.append(photo6)
        
        
    }
    
    private func setupActivityIndicatorViewConstraints() {
        progress1.translatesAutoresizingMaskIntoConstraints = false
        progress1.centerXAnchor.constraint(equalTo: viewContainer1.centerXAnchor).isActive = true
        progress1.centerYAnchor.constraint(equalTo: viewContainer1.centerYAnchor).isActive = true
        
        progress2.translatesAutoresizingMaskIntoConstraints = false
        progress2.centerXAnchor.constraint(equalTo: viewContainer2.centerXAnchor).isActive = true
        progress2.centerYAnchor.constraint(equalTo: viewContainer2.centerYAnchor).isActive = true
        
        progress3.translatesAutoresizingMaskIntoConstraints = false
        progress3.centerXAnchor.constraint(equalTo: viewContainer3.centerXAnchor).isActive = true
        progress3.centerYAnchor.constraint(equalTo: viewContainer3.centerYAnchor).isActive = true
        
        progress4.translatesAutoresizingMaskIntoConstraints = false
        progress4.centerXAnchor.constraint(equalTo: viewContainer4.centerXAnchor).isActive = true
        progress4.centerYAnchor.constraint(equalTo: viewContainer4.centerYAnchor).isActive = true
        
        progress5.translatesAutoresizingMaskIntoConstraints = false
        progress5.centerXAnchor.constraint(equalTo: viewContainer5.centerXAnchor).isActive = true
        progress5.centerYAnchor.constraint(equalTo: viewContainer5.centerYAnchor).isActive = true
        
        progress6.translatesAutoresizingMaskIntoConstraints = false
        progress6.centerXAnchor.constraint(equalTo: viewContainer6.centerXAnchor).isActive = true
        progress6.centerYAnchor.constraint(equalTo: viewContainer6.centerYAnchor).isActive = true
    }
    
    func setModifyIcons(){
        
        addImageButton1.transform = CGAffineTransform(scaleX: 1, y: 1)
        addImageButton2.transform = CGAffineTransform(scaleX: 1, y: 1)
        addImageButton3.transform = CGAffineTransform(scaleX: 1, y: 1)
        addImageButton4.transform = CGAffineTransform(scaleX: 1, y: 1)
        addImageButton5.transform = CGAffineTransform(scaleX: 1, y: 1)
        addImageButton6.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        
    }
    
    func hideModifyIcons(){
        
        addImageButton1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addImageButton2.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addImageButton3.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addImageButton4.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addImageButton5.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addImageButton6.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        
    }
    
    @IBAction func addImageB1Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
        
    }
    @IBAction func addImageB2Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
       
    }
    @IBAction func addImageB3Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
    }
    @IBAction func addImageB6Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
    }
    @IBAction func addImageB5Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
    }
    @IBAction func addImageB4Pressed(_ sender: UIButton) {
        showPicker(value: sender.tag)
    }
    
    func showPicker(value: Int){
        let config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowVideoSelection = false
        
        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.imageLimit = 1
        imagePicker.delegate = self
        present(imagePicker, animated: true) {
            self.selectedImage = value
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "companySettings"{
            let vc = segue.destination as! CompanySettings
            vc.modifyImagesState = {(state: Bool)->() in
                if state == true{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.hideModifyIcons()
                    })
                }else{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.setModifyIcons()
                    })
                }
            }
            vc.exit = {(state: Bool) -> () in
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
            vc.onClick = {() -> () in
                self.performSegue(withIdentifier: "toNewPromotion", sender: nil)
            }
        }
    }
    
    func setImages(){
        if self.defaultValues.object(forKey: "companyPhoto1") as! String != ""{

            //progress1.progress = 0
            progress1.startAnimating()
            
            photo1.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto1") as! String)!).downloadProgress { (progress) in
                //self.progress1.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress1.stopAnimating()
                    //self.progress1.isHidden = true
                    self.photo1.image = UIImage(data: data.result
                        .value!)
                    self.photo1.layer.cornerRadius = self.photo1.frame.size.width/8
                    self.photo1.clipsToBounds = true
            }
        }
        if self.defaultValues.object(forKey: "companyPhoto2") as! String != ""{
            //progress2.progress = 0
            progress2.startAnimating()
            
            photo2.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto2") as! String)!).downloadProgress { (progress) in
                //self.progress2.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress2.stopAnimating()
                    self.photo2.image = UIImage(data: data.result
                        .value!)
                    self.photo2.layer.cornerRadius = self.photo2.frame.size.width/8
                    self.photo2.clipsToBounds = true
            }
        }
        if self.defaultValues.object(forKey: "companyPhoto3") as! String != ""{
            //progress3.progress = 0
            progress3.startAnimating()
            photo3.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto3") as! String)!).downloadProgress { (progress) in
                //self.progress3.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress3.stopAnimating()
                    self.photo3.image = UIImage(data: data.result
                        .value!)
                    self.photo3.layer.cornerRadius = self.photo3.frame.size.width/8
                    self.photo3.clipsToBounds = true
            }
        }
        if self.defaultValues.object(forKey: "companyPhoto4") as! String != ""{
            //progress4.progress = 0
            progress4.startAnimating()
            photo4.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto4") as! String)!).downloadProgress { (progress) in
                //self.progress4.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress4.stopAnimating()
                    self.photo4.image = UIImage(data: data.result
                        .value!)
                    self.photo4.layer.cornerRadius = self.photo4.frame.size.width/8
                    self.photo4.clipsToBounds = true
            }
        }
        if self.defaultValues.object(forKey: "companyPhoto5") as! String != ""{
            //progress5.progress = 0
            progress5.startAnimating()
            photo5.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto5") as! String)!).downloadProgress { (progress) in
                //self.progress5.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress5.stopAnimating()
                    self.photo5.image = UIImage(data: data.result
                        .value!)
                    self.photo5.layer.cornerRadius = self.photo5.frame.size.width/8
                    self.photo5.clipsToBounds = true
            }
        }
        if self.defaultValues.object(forKey: "companyPhoto6") as! String != ""{
            //progress6.progress = 0
            progress6.startAnimating()
            photo6.image = UIImage(color: .white)
            Alamofire.request(URL(string: self.defaultValues.object(forKey: "companyPhoto6") as! String)!).downloadProgress { (progress) in
                //self.progress6.progress = Float(progress.fractionCompleted)
                }.responseData { (data) in
                    self.progress6.stopAnimating()
                    self.photo6.image = UIImage(data: data.result
                        .value!)
                    self.photo6.layer.cornerRadius = self.photo6.frame.size.width/8
                    self.photo6.clipsToBounds = true
            }
        }
        
        
    }
    


}

extension CompanyAccountController : ImagePickerDelegate{
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
        imageViews[selectedImage-1].image = images[0]
        imageViews[selectedImage-1].layer.cornerRadius = imageViews[selectedImage-1].frame.size.width / 8
        imageViews[selectedImage-1].clipsToBounds = true
        
        //show upload progress
        SVProgressHUD.show(withStatus: "Uploading image!")
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(.black)
        //SVProgressHUD.setSuccessImage(UIImage(named: "successIcon")!)
        SVProgressHUD.setHapticsEnabled(true)

        
        //UINotificationFeedbackType.success = UINotificationFeedbackGenerator.FeedbackType.success
        //save photo
        self.netService.saveCompanyPhoto(photoID: selectedImage,userID: self.defaultValues.integer(forKey: "cid"), deleteRef: self.defaultValues.object(forKey: nameRefs[selectedImage-1]) as! String , photo: images[0], completion: { (url) in
            self.defaultValues.set(url as! String, forKey: self.nameRefs[self.selectedImage-1])
            SVProgressHUD.showSuccess(withStatus: "Upload complete!")
            UINotificationFeedbackType.success
            //let notification = UINotificationFeedbackTypeS
            
            print("Succes")
        })
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
}
