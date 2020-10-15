//
//  DefaultDocumentsStorage.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation
import UIKit
import CoreData

protocol DocumentsStorage {
    func fetchDocuments(requestValue: SearchDocumentsUseCaseRequestValue,
                        completion: (Result<[Document], Error>) -> Void)
}

final class DefaultDocumentsStorage: DocumentsStorage {
    
    func fetchDocuments(requestValue: SearchDocumentsUseCaseRequestValue, completion: (Result<[Document], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest = DocumentEntity.fetchRequest()
        
        var documentResult = [Document]()
        
        do {
            let result = try managedObjectContext.fetch(request)
            
            for data in result {
                guard let created = data.created else { return }
                guard let modified = data.modified else { return }
                
                let document = Document(id: String(data.id),
                                        title: data.title,
                                        content: data.content,
                                        created: dateFormatter.date(from: created),
                                        modified: dateFormatter.date(from: modified))
                documentResult.append(document)
            }
            completion(.success(documentResult))
        } catch {
            completion(.failure(error))
        }
    }
    // MARK: - Private
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
