//
//  TriviaModel.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/27/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import Foundation


struct TriviaModel {
    let categoryName: String
    let correctResponse: String
    let cardContent: String
    let value: Int?

    
    var correctResponseString: String {
        return "What is " + correctResponse + "?"
    }
    
    enum gameType {
        case single
        case double
        
        var gameValue: Int {
            
            switch self {
            case .single:
                return 1
            case .double:
                return 2
            }
        }
    }
}
