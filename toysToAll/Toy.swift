//
//  Toy.swift
//  toysToAll
//
//  Created by Splhead on 26/12/21.
//

import Foundation

struct Toy {
    let id: String
    let name: String
    let state: Int
    let donorName: String
    let address: String
    let phone: String
    
    var stateName: String {
        switch state {
        case 0:
            return "Novo"
        case 1:
            return "Usado"
        default:
            return "Precisa de reparo"
        }
    }
}
