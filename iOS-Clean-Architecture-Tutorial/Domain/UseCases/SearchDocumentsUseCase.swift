//
//  SearchDocumentsUseCase.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

protocol SearchDocumentsUseCase {
    func execute(requestDTO: SearchDocumentsUseCaseRequestDTO,
                 completion: @escaping (Result<[Document], Error>) -> Void)
}

final class DefaultSearchDocumentsUseCase: SearchDocumentsUseCase {
    
    private let repository: DocumentsRepository
    
    init(repository: DocumentsRepository) {
        self.repository = repository
    }
    func execute(requestDTO: SearchDocumentsUseCaseRequestDTO, completion: @escaping (Result<[Document], Error>) -> Void) {
        repository.fetchDocumentsList(requestDTO: requestDTO) { result in
            switch result {
            case .success(let documents):
                completion(.success(documents))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct SearchDocumentsUseCaseRequestDTO {
    let name: String
}
