//
//  Models.swift
//  Tabula
//
//  Created by Adi Veliman on 24/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Foundation
/////////////////////////////////////////////////////////////
struct Categories: Codable{
    var Categories : [Category]
    init() {
        Categories = []
    }
}

struct Category: Codable{
    var Name : String?
}
/////////////////////////////////////////////////////////////
struct Specialization: Codable{
    var Specialization: String?
    var ID : Int?
}

struct Specializations: Codable{
    var Specializations : [Specialization]
    init(){
        Specializations = []
    }
}

/////////////////////////////////////////////////////////////
struct Item: Codable{
    
    let Name : String?
    let Description : String?
    let Address :  String?
    let Photos : String?
    let Rating : Double?
    let ID : Int?
}

struct ItemArray: Codable{
    
    var items : [Item]
    init() {
        items = []
    }
    
}
/////////////////////////////////////////////////////////////

struct Service: Codable{
    
    let Name : String?
    let Price : Int?
    
    init(nume: String, pret: Int){
        self.Name = nume
        self.Price = pret
    }
}

struct ServiceArray: Codable{
    
    var Services : [Service]
    init() {
        Services = []
    }
    
}


/////////////////////////////////////////////////////////////


struct Review: Codable{
    
    let Descriere : String?
    let Stars : Int?
    let Created_at : String?
    let FirstName : String?
    let LastName : String?
    
    init(descriere: String, stars: Int, creationDate: String, Fname: String, LName:String){
        self.Descriere = descriere
        self.Stars = stars
        self.Created_at = creationDate
        self.FirstName = Fname
        self.LastName = LName
    }
}

struct ReviewsArray: Codable{
    
    var Reviews : [Review]
    init() {
        Reviews = []
    }
    
}

/////////////////////////////////////////////////////////////
struct Promotion: Codable{
    
    let CompanyID : Int?
    let Name : String?
    let Description : String?
    let VoucherType : Int?
    let VoucherCode : String?
    let Date : String?
    let Specilization : String?
    
    init(id: Int, nume: String, descriere: String, tipVoucher: Int, codVoucher: String, calendar:String, specializare: String){
        self.CompanyID = id
        self.Name = nume
        self.Description = descriere
        self.VoucherType = tipVoucher
        self.VoucherCode = codVoucher
        self.Date = calendar
        self.Specilization = specializare
        
        
    }
}

struct PromotionsArray: Codable{
    
    var Promotions : [Promotion]
    init() {
        Promotions = []
    }
    
}

/////////////////////////////////////////////////////////////
