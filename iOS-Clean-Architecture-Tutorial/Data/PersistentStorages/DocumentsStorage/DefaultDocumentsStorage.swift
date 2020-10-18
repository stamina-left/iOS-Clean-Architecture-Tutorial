//
//  DefaultDocumentsStorage.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation
import CoreData

protocol DocumentsStorage {
    func fetchDocuments(requestDTO: SearchDocumentsUseCaseRequestDTO,
                        completion: @escaping (Result<[Document], Error>) -> Void)
    func saveDocument(responseDTO: SaveDocumentUseCaseResponseDTO)
}

final class DefaultDocumentsStorage: DocumentsStorage {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
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

extension DefaultDocumentsStorage {
    
    func fetchDocuments(requestDTO: SearchDocumentsUseCaseRequestDTO, completion: @escaping (Result<[Document], Error>) -> Void) {
        
        let request: NSFetchRequest = DocumentEntity.fetchRequest()
        
        var documentResult = [Document]()
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let result = try context.fetch(request)
                
                for data in result {
                    guard let created = data.created else { return }
                    guard let modified = data.modified else { return }
                    
                    let document = Document(id: String(data.id),
                                            title: data.title,
                                            content: data.content,
                                            created: self.dateFormatter.date(from: created),
                                            modified: self.dateFormatter.date(from: modified))
                    documentResult.append(document)
                }
                completion(.success(documentResult))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveDocument(responseDTO: SaveDocumentUseCaseResponseDTO) {
        
        coreDataStorage.performBackgroundTask { context in
            guard let document = NSEntityDescription.insertNewObject(forEntityName: "DocumentEntity", into: context) as? DocumentEntity else { return }
            
            guard let created = responseDTO.document.created else { return }
            guard let modified = responseDTO.document.modified else { return }
            
            document.title = responseDTO.document.title
            document.content = responseDTO.document.content
            document.created = self.dateFormatter.string(from: created)
            document.modified = self.dateFormatter.string(from: modified)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
