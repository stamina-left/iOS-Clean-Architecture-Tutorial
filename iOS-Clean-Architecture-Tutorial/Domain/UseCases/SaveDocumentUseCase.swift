//
//  SaveDocumentUseCase.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 17/10/20.
//

import Foundation

protocol SaveDocumentUseCase {
    func execute(responseDTO: SaveDocumentUseCaseResponseDTO,
                 completion: @escaping (Result<Document, Error>) -> Void)
}

final class DefaultSaveDocumentUseCase: SaveDocumentUseCase {
    
    private let repository: DocumentsRepository
    
    init(repository: DocumentsRepository) {
        self.repository = repository
    }
    func execute(responseDTO: SaveDocumentUseCaseResponseDTO, completion: @escaping (Result<Document, Error>) -> Void) {
        repository.saveDocument(responseDTO: responseDTO) { result in
            switch result {
            case .success(let document):
                completion(.success(document))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct SaveDocumentUseCaseResponseDTO {
    let document: Document
}
