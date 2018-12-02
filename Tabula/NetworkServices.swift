//
//  NetworkServices.swift
//  Tabula
//
//  Created by Adi Veliman on 24/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Foundation
import Alamofire
//import Firebase
import FirebaseStorage


class NetworkServices{
    
    //////////////////////FIREBASE////////////////////////////
    
    // Get a reference to the storage service using the default Firebase App
    


    func savePhoto(userID : Int, deleteRef: String, photo:UIImage,completion: @escaping (String)->()){
        
        
        
        let URL = "https://vaportofolio.ro/php/v1/saveUserPhoto.php"
        if deleteRef != ""{
        let deleteRef = Storage.storage().reference(forURL: deleteRef)
        deleteRef.delete { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        }
        let metaDataForImage = StorageMetadata()
        metaDataForImage.contentType = "image/jpeg"
        let storage = Storage.storage().reference().child("images")
        
        if let imageData = UIImageJPEGRepresentation(photo, 0.6){
           let uid = NSUUID().uuidString
           let imageRef = storage.child("\(uid)")
            
            imageRef.putData(imageData, metadata: metaDataForImage) { (metadata, error) in
                guard let metadata = metadata else {
                    print(error?.localizedDescription)
                    return
                }
              
                
                imageRef.downloadURL { (url, error) in
                    let parameters: Parameters=[
                        "Photo":url?.absoluteString as! String,
                        "ID":userID as! Int,
                        ]
                    
                    Alamofire.request(URL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
                        print(response.data)
                    })
                    completion((url?.absoluteString)!)
                }
                
            }
            
            
        }

    }
    
    
    
    
    func saveCompanyPhoto(photoID : Int, userID : Int, deleteRef: String, photo:UIImage,completion: @escaping (String)->()){
        
        let URL = "https://vaportofolio.ro/php/v1/saveCompanyPhotos.php"
        if deleteRef != ""{
            let deleteRef = Storage.storage().reference(forURL: deleteRef)
            deleteRef.delete { (error) in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
        let metaDataForImage = StorageMetadata()
        metaDataForImage.contentType = "image/jpeg"
        let storage = Storage.storage().reference().child("images")
        
        if let imageData = UIImageJPEGRepresentation(photo, 0.6){
            let uid = NSUUID().uuidString
            let imageRef = storage.child("\(uid)")
            
            imageRef.putData(imageData, metadata: metaDataForImage) { (metadata, error) in
                guard metadata != nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                
                imageRef.downloadURL { (url, error) in
                    let parameters: Parameters=[
                        "Value":photoID ,
                        "Photo":url?.absoluteString as! String,
                        "ID":userID ,
                        ]
                    
                    Alamofire.request(URL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
                        print(response.data)
                        completion((url?.absoluteString)!)
                    })
                    //imageURL = (url?.absoluteString)!
                    
                }
                
                }
        }
    }
    ///////////////////////////////////////////////////////////
    
    func getCategories(completion: @escaping (Categories) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getCategories.php"
        
        
        Alamofire.request(URL).responseJSON { (response) in
            let json = response.data
            var categories = Categories()
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                categories = try decoder.decode(Categories.self, from: json!)
  
                completion(categories)
            }catch let err{
                print(err)
            }
            
        }
    }
    
    
    
    func getItems(identifier: String, completion: @escaping (ItemArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getSpecificCategory.php"
        let parameters: Parameters=[
            "Name":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var items = ItemArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    items = try decoder.decode(ItemArray.self, from: json!)
                    
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getSpecializations(identifier: String, completion: @escaping (Specializations) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getSpecializations.php"
        let parameters: Parameters=[
            "Name":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var specializations = Specializations()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    specializations = try decoder.decode(Specializations.self, from: json!)
                    
                    completion(specializations)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getFilteredItems(identifier: Int, completion: @escaping (ItemArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getResults.php"
        let parameters: Parameters=[
            "Category":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var items = ItemArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    items = try decoder.decode(ItemArray.self, from: json!)
                    
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getServices(identifier: Int, completion: @escaping (ServiceArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getServicesByCompany.php"
        let parameters: Parameters=[
            "Company":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var items = ServiceArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    items = try decoder.decode(ServiceArray.self, from: json!)
                    
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getReviews(identifier: Int, completion: @escaping (ReviewsArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getReviewsByCompany.php"
        let parameters: Parameters=[
            "Company":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var items = ReviewsArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    items = try decoder.decode(ReviewsArray.self, from: json!)
                    
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    func saveReview(companyID: Int,IDClient : Int, review : String, rating: Int, date: String, photo: String, completion: @escaping (Bool) -> ()){
        
        let URL = "https://www.vaportofolio.ro/php/v1/review.php"
        //creating parameters for the post request
        let parameters: Parameters=[
            "Company":companyID,
            "ID_Client":IDClient,
            "Descriere":review,
            "Stars":rating,
            "Created_at":date,
            "Photo":photo,
            ]
        
        //Sending http post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    

                }
                
                completion(true)
        }
        
    }
    
    
    func getPromotions(completion: @escaping (PromotionsArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getPromotions.php"
       
        
        Alamofire.request(URL, method: .get).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var promotions = PromotionsArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    promotions = try decoder.decode(PromotionsArray.self, from: json!)
                    
                    
                    completion(promotions)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func downloadPhoto(url: String, completion: @escaping (UIImage)->()){
        
        let session = URLSession(configuration: .default)
        let photoURL = URL(string: url)
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: photoURL!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        completion(image!)
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
    }
    
    
    func getCompanyDetails(identifier: Int, completion: @escaping (ItemArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getCompanyDetails.php"
        let parameters: Parameters=[
            "ID":identifier,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                let json = response.data
                var items = ItemArray()
                
                do{
                    //created the json decoder
                    let decoder = JSONDecoder()
                    
                    //using the array to put values
                    items = try decoder.decode(ItemArray.self, from: json!)
                    
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func savePromotion(companyID: Int,description : String, type : Int, color: String, code: String, date: String, completion: @escaping (Bool) -> ()){
        
        let URL = "https://www.vaportofolio.ro/php/v1/savePromotion.php"
        //creating parameters for the post request
        let parameters: Parameters=[
            "CompanyID":companyID,
            "Descriere":description,
            "Type":type,
            "Color":color,
            "Code":code,
            "Created_at":date,
            ]
        
        //Sending http post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    
                    
                }
                
                completion(true)
        }
        
    }
    
    func submitPasswordReset(email: String, completion: @escaping (Bool) -> ()){
        
        let URL = "https://vaportofolio.ro/php/mail/sendMails.php"
        let parameters: Parameters=[
            "Email":email,
            ]
        
        //making a post request
        Alamofire.request(URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    

                }
                
                completion(true)
        }
        
    }
    
    

    
    
    
}

