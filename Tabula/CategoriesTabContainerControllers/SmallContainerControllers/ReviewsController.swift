//
//  ReviewsController.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class ReviewsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var netService = NetworkServices()
    var reviews = ReviewsArray()
    var companyID = Int()
    var finishedSaving = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reviewPressed(_ sender: Any) {
    }
    
    
    func fetchData(company id: Int){
        
        netService.getReviews(identifier: id) { (reviews) in
            self.reviews = reviews
            self.tableView.reloadData()
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopUpReview"{
            let popUp = segue.destination as! ReviewPopUpController
            popUp.onSave = {(rating: Int, description: String, date: String)->() in
                self.netService.saveReview(companyID: self.companyID, IDClient: 8, review: description, rating: rating, date: date, completion: { (isSaved) in
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
        cell.commentLabel.text = reviews.Reviews[indexPath.row].Descriere
        cell.creationDateLabel.text = reviews.Reviews[indexPath.row].Created_at
        cell.ratingStack.rating = Double(reviews.Reviews[indexPath.row].Stars!)
        cell.nameLabel.text = "\(reviews.Reviews[indexPath.row].FirstName as! String) \(reviews.Reviews[indexPath.row].LastName as! String)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.Reviews.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
