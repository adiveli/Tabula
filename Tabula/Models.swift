//
//  Models.swift
//  Tabula
//
//  Created by Adi Veliman on 24/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Foundation

struct Categories: Codable{
    var Categories : [Category]
    init() {
        Categories = []
    }
}

struct Category: Codable{
    var Name : String?
}

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


struct Item: Codable{
    
    let Name : String?
    let Description : String?
    let Address :  String?
    let Photos : String?
    let Rating : Int?
    let ID : Int?
}

struct ItemArray: Codable{
    
    var items : [Item]
    init() {
        items = []
    }
    
}



