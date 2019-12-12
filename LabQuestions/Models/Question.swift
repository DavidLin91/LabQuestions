//
//  Question.swift
//  LabQuestions
//
//  Created by David Lin on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct Question: Decodable {
    let id: String
    //let createAt: String
    let name: String // random user name
    let avatar: String // random user avatar
    let title: String
    let description: String
    let labName: String
}
