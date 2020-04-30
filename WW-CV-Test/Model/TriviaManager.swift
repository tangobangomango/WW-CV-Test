//
//  TriviaManager.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/27/20.
//  Copyright © 2020 TDG. All rights reserved.
//


import Foundation
import Alamofire

protocol TriviaManagerDelegate {
    
    func didUpdateTriviaData(_ triviaManager: TriviaManager, triviaModels: [[TriviaModel]])
    func didFailWithError(error: String)
        
}


struct TriviaManager {
    
    var delegate: TriviaManagerDelegate?
    
    
    func fetch(_ categoryIDList: [Int], for gameType: TriviaModel.gameType) {
        var items: [[TriviaModel]] = []
        
        let fetchGroup = DispatchGroup()
        
        var urls: [String] = []
        
        for categoryID in categoryIDList {
            urls.append("http://jservice.io/api/category?id=\(categoryID)")
        }
        
        urls.forEach { (url) in
            
            fetchGroup.enter()
            
            AF.request(url)
                .validate()
                .responseDecodable(of: TriviaData.self) { (response) in
                    guard response.value != nil else {
                        self.delegate?.didFailWithError(error: "Decoding error")
                        return
                    }
                    if let value = response.value {
                        print(value.id)
                        let preparedCategory = self.prepareCategory(from: value, for: gameType)
                        if !preparedCategory.isEmpty {
                            items.append(preparedCategory)
                        }
                        
                    }
                    fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            print(items.count)
            
            self.delegate?.didUpdateTriviaData(self, triviaModels: items)
            
            
        }
        
    }
    
    func prepareCategory(from triviaData: TriviaData, for gameType: TriviaModel.gameType) -> [TriviaModel] {
        
        let category = triviaData.title
        
        let allClues = triviaData.clues
        
        var content = [TriviaModel]()
        
        for clue in allClues {
            let oneAnswer = clue.answer
            let oneQuestion = clue.question
            let oneValue = clue.value
            
            
            if category != "" && oneAnswer != "" && oneQuestion != "" && oneValue != nil {
                content.append(TriviaModel(categoryName: category, correctResponse: oneAnswer, cardContent: oneQuestion, value: oneValue))
            }
        }
        
        let selectedContent = selectContent(contentArray: content, forType: gameType)
        return selectedContent
    }
    
    func selectContent(contentArray: [TriviaModel], forType: TriviaModel.gameType) -> [TriviaModel] {
        
        var selected = [TriviaModel]()
        let gameToPlay = forType.gameValue
        
        let shuffledArray = contentArray.shuffled()
        let sortedArray = shuffledArray.sorted(by: { $0.value! < $1.value! })
        
        for content in sortedArray {
            for index in 1...5 {
                if content.value == (100 * index * gameToPlay) {
                    while selected.count == index - 1 {
                        selected.append(content)
                    }
                }
            }
        }
        //        print(selected.count)
        return selected
        
    }
    
    
    
}


