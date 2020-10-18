//
//  DocumentsListViewModel.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import Foundation

protocol DocumentsListViewModelInput {
    func didSearch(query: String)
}

protocol DocumentsListViewModelOutput {
    var items: [Document] { get }
    var error: String { get }
}

protocol DocumentsListViewModel: DocumentsListViewModelInput, DocumentsListViewModelOutput {}

final class DefaultDocumentsListViewModel: DocumentsListViewModel {
    
    private let searchDocumentsUseCase: DefaultSearchDocumentsUseCase
    
    // MARK: - OUTPUT
    
    var items = [Document]()
    var error = ""
    
    // MARK: - Init
    
    init(searchDocumentsUseCase: DefaultSearchDocumentsUseCase) {
        self.searchDocumentsUseCase = searchDocumentsUseCase
    }
    
    // MARK: - Private
    
    private func load(requestDTO: SearchDocumentsUseCaseRequestDTO) {
        
        searchDocumentsUseCase.execute(requestDTO: requestDTO) { result in
            switch result {
            case .success(let documents):
                self.items = documents
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}

// MARK: - INPUT. View event methods

extension DefaultDocumentsListViewModel {
    
    func didSearch(query: String) {
        load(requestDTO: SearchDocumentsUseCaseRequestDTO(name: query))
    }
}
