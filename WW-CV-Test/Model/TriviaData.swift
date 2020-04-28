//
//  TriviaData.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/27/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import Foundation

struct TriviaData: Codable {
    let id: Int
    let title: String
    let clues: [AnswerQuestion]
}

struct AnswerQuestion: Codable {
    let answer: String
    let question: String
    let value: Int?

    
    
    enum CodingKeys: String, CodingKey {
        case answer
        case question
        case value
 
        
        
    }
}
