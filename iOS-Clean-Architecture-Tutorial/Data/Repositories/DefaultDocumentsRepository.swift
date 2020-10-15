//
//  DefaultDocumentsRepository.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

protocol DocumentsRepository {
    func fetchDocumentsList(requestValue: SearchDocumentsUseCaseRequestValue,
                            completion: @escaping (Result<[Document], Error>) -> Void)
}

final class DefaultDocumentsRepository: DocumentsRepository {
    
    private let storage : DefaultDocumentsStorage
    
    init(storage: DefaultDocumentsStorage) {
        self.storage = storage
    }
    
    func fetchDocumentsList(requestValue: SearchDocumentsUseCaseRequestValue, completion: @escaping (Result<[Document], Error>) -> Void) {
        storage.fetchDocuments(requestValue: requestValue) { result in
            switch result {
            case .success(let documents):
                completion(.success(documents))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
