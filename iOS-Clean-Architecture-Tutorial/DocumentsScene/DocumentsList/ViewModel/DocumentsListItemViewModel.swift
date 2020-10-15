//
//  DocumentsListItemViewModel.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 16/10/20.
//

import Foundation

struct DocumentsListItemViewModel: Equatable {
    let title: String
    let content: String?
    let created: String
    let modified: String
}

extension DocumentsListItemViewModel {
    
    init(document: Document) {
        self.title = document.title ?? ""
        self.content = document.content ?? ""
        if let dateCreated = document.created {
            self.created = dateFormatter.string(from: dateCreated)
        } else {
            self.created = NSLocalizedString("", comment: "")
        }
        if let dateModified = document.modified {
            self.modified = dateFormatter.string(from: dateModified)
        } else {
            self.modified = NSLocalizedString("", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
