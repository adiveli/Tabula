//
//  ContainerState.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import Foundation

class ContainerState : NSObject{
    
    @objc dynamic var stateValue : Int = 0
    
    
    func setState(state : Int){
        self.stateValue = state
    }
 
}
