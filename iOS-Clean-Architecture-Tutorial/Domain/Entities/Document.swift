//
//  Document.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

struct Document: Identifiable {
    typealias Identifier = String
    let id: Identifier
    let title: String?
    let content: String?
    let created: Date?
    let modified: Date?
}
