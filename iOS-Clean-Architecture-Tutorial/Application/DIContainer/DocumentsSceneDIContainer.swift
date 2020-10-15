//
//  DocumentsSceneDIContainer.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 16/10/20.
//

import Foundation

final class DocumentsSceneDIContainer {
    
    static func makeSearchDocumentsUseCase() -> SearchDocumentsUseCase {
        
        let storage: DocumentsStorage = DefaultDocumentsStorage()
        let repository: DocumentsRepository = DefaultDocumentsRepository(storage: storage)
        let useCase: SearchDocumentsUseCase = DefaultSearchDocumentsUseCase(repository: repository)
        
        return useCase
    }
}
