//
//  ReviewsController.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Kingfisher

class ReviewsController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var netService = NetworkServices()
    var reviews = ReviewsArray()
    var companyID = Int()
    var finishedSaving = Bool()
    var viewStatus = [Bool]()
    @IBOutlet weak var shadowView: UIView!
    let defaultValues = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //tableView.layer.borderColor = UIColor.black.cgColor
        //tableView.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1.2
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowPath = UIBezierPath(rect: CGRect(x: shadowView.bounds.origin.x, y: shadowView.bounds.origin.y, width: shadowView.bounds.width-30, height: shadowView.bounds.height+15)).cgPath
        
        //shadowView.layer.cornerRadius = shadowView.frame.size.width/30
        //shadowView.clipsToBounds = true
        tableView.layer.cornerRadius = tableView.frame.size.width/30
        tableView.clipsToBounds = true
        titleLabel.layer.cornerRadius = titleLabel.frame.size.width/4
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.black.cgColor
    }
    

    
    @IBAction func reviewPressed(_ sender: Any) {
    }
    
    
    func fetchData(company id: Int){
        
        netService.getReviews(identifier: id) { (reviews) in
            self.reviews = reviews
            for item in self.reviews.Reviews{
                self.viewStatus.append(false)
            }
            self.tableView.reloadData()
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopUpReview"{
            let popUp = segue.destination as! ReviewPopUpController
            popUp.onSave = {(rating: Int, description: String, date: String)->() in
                self.netService.saveReview(companyID: self.companyID, IDClient: 8, review: description, rating: rating, date: date, photo: self.defaultValues.object(forKey: "userPhoto") as! String, completion: { (isSaved) in
                    if(isSaved){
                        self.fetchData(company: self.companyID)
                        self.tableView.reloadData()
                    }
                })

                
            }
            
        }
    }
 

}

extension ReviewsController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.creationDateLabel.text = reviews.Reviews[indexPath.row].Created_at
        cell.ratingStack.rating = Double(reviews.Reviews[indexPath.row].Stars!)
        cell.nameLabel.text = "\(reviews.Reviews[indexPath.row].FirstName as! String) \(reviews.Reviews[indexPath.row].LastName as! String)"
        if reviews.Reviews[indexPath.row].Photo != ""{
        let url = URL(string: reviews.Reviews[indexPath.row].Photo!)
        cell.profileImage.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (receivedSize, totalSize) in
            print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
        }) { (image, error, cacheType, imageURL) in
            print("\(indexPath.row + 1): Finished")
            }
        }else{
            cell.profileImage.image = UIImage(named: "no_image")
        }
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width / 2
        cell.profileImage.clipsToBounds = true
        cell.index = indexPath
        cell.delegate = self
        cell.selectionStyle = .none
        cell.viewCommentBtn.setTitle(viewStatus[indexPath.row] ? "Hide comment" : "View comment", for: .normal)
        cell.commentText.text = viewStatus[indexPath.row] ? reviews.Reviews[indexPath.row].Descriere : ""
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.Reviews.count
    }
    
    
}

extension ReviewsController: ReviewDropdownDelegate{
    
    func viewCommentPressed(_ sender: ReviewCell, status: Bool, indexPath : IndexPath) {
        viewStatus[indexPath.row] = !viewStatus[indexPath.row]
        
        let cell = sender
        cell.commentText.text = viewStatus[indexPath.row] ? reviews.Reviews[indexPath.row].Descriere : ""
        cell.viewCommentBtn.setTitle(viewStatus[indexPath.row] ? "Hide comment" : "View comment", for: .normal)
        tableView.beginUpdates()
        tableView.endUpdates()
        //tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        cell.commentText.textColor = UIColor.black
        
    }
    
}
