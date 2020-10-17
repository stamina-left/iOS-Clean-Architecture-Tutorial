//
//  DefaultDocumentsRepository.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

protocol DocumentsRepository {
    func fetchDocumentsList(requestDTO: SearchDocumentsUseCaseRequestDTO,
                            completion: @escaping (Result<[Document], Error>) -> Void)
    func saveDocument(responseDTO: SaveDocumentUseCaseResponseDTO,
                      completion: @escaping (Result<Document, Error>) -> Void)
}

final class DefaultDocumentsRepository: DocumentsRepository {
    
    private let storage : DocumentsStorage
    
    init(storage: DocumentsStorage) {
        self.storage = storage
    }
    
    func fetchDocumentsList(requestDTO: SearchDocumentsUseCaseRequestDTO, completion: @escaping (Result<[Document], Error>) -> Void) {
        
        storage.fetchDocuments(requestDTO: requestDTO) { result in
            switch result {
            case .success(let documents):
                completion(.success(documents))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveDocument(responseDTO: SaveDocumentUseCaseResponseDTO, completion: @escaping (Result<Document, Error>) -> Void) {
        
        storage.saveDocument(responseDTO: responseDTO)
        guard let documentTitle = responseDTO.document.title else { return }
        let requestDTO = SearchDocumentsUseCaseRequestDTO.init(name: documentTitle)
        
        fetchDocumentsList(requestDTO: requestDTO) { result in
            switch result {
            case .success(let documents):
                guard let document = documents.first else { return }
                completion(.success(document))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
