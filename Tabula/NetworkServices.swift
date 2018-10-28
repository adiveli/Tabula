//
//  NetworkServices.swift
//  Tabula
//
//  Created by Adi Veliman on 24/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Foundation
import Alamofire


class NetworkServices{
    
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
                
                //printing all the hero names
                completion(categories)
            }catch let err{
                print(err)
            }
            
        }
    }
    
    
    
    func getItems(identifier: String, completion: @escaping (ItemArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getSpecificCategory.php"
        //getting the username and password
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
                    
                    //printing all the hero names
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getSpecializations(identifier: String, completion: @escaping (Specializations) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getSpecializations.php"
        //getting the username and password
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
                    
                    //printing all the hero names
                    completion(specializations)
                }catch let err{
                    print(err)
                }
        }
        
    }
    
    
    func getFilteredItems(identifier: Int, completion: @escaping (ItemArray) -> ()){
        
        let URL = "https://vaportofolio.ro/php/v1/getResults.php"
        //getting the username and password
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
                    
                    //printing all the hero names
                    completion(items)
                }catch let err{
                    print(err)
                }
        }
        
    }
    

    
    
    
}

