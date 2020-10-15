//
//  SearchDocumentsUseCase.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

protocol SearchDocumentsUseCase {
    func execute(requestValue: SearchDocumentsUseCaseRequestValue,
                 completion: @escaping (Result<[Document], Error>) -> Void)
}

final class DefaultSearchDocumentsUseCase: SearchDocumentsUseCase {
    
    private let repository: DefaultDocumentsRepository
    
    init(repository: DefaultDocumentsRepository) {
        self.repository = repository
    }
    func execute(requestValue: SearchDocumentsUseCaseRequestValue, completion: @escaping (Result<[Document], Error>) -> Void) {
        repository.fetchDocumentsList(requestValue: requestValue) { result in
            switch result {
            case .success(let documents):
                completion(.success(documents))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct SearchDocumentsUseCaseRequestValue {
    let name: String
}
