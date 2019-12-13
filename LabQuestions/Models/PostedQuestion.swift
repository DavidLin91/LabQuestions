//
//  PostedQuestion.swift
//  LabQuestions
//
//  Created by David Lin on 12/13/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// encoding gets you data
// decoding gets you swift model

struct PostedQuestion: Encodable { // conforms to encodable because we are posting
    let title: String
    let labName: String
    let description: String
    let createdAt: String // timestamp of the created date of the Question
}
