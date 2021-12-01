//
//  QuestionsResponse.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 27.08.2021.
//

import Foundation

class QuestionResponse: Decodable, Encodable {
    var results: [Question]?
    var responseCode: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case responseCode = "response_code"
    }
    
}

class Question: Decodable, Encodable {
    var category: String?
    var question: String?
    var correctAnswer: String?
    var incorrectAnswers: [String]?
    var answers: [String]?
    
    enum CodingKeys: String, CodingKey {
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    func toString() -> String {
        return "\ncategory: \(String(describing: category))\nquestion: \(String(describing: question))\ncorrect: \(String(describing: correctAnswer))\nincorrect: \(String(describing: incorrectAnswers?.description))"
    }

   
}
