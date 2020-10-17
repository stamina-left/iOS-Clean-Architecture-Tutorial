//
//  SearchDocumentsUseCaseTests.swift
//  iOS-Clean-Architecture-TutorialTests
//
//  Created by Albert Pangestu on 16/10/20.
//

import XCTest
@testable import iOS_Clean_Architecture_Tutorial

class SearchDocumentsUseCaseTests: XCTestCase {
    
    static let documents: [Document] = [
        Document(id: "1", title: "American Psycho", content: "Hey Paul!", created: Date(), modified: Date()),
        Document(id: "2", title: "Flowers for Algernon", content: "I did it!", created: Date(), modified: Date()),
        Document(id: "0", title: "", content: "", created: nil, modified: nil)
    ]

    func testSearchDocumentsUseCase_whenSuccessfullySaveDocument_thenFetchesDocuments() {
        
        // given
        let expectation = self.expectation(description: "Recent document saved.")
        expectation.expectedFulfillmentCount = 2
        let coreDataStorage = CoreDataStorage()
        let storage = DefaultDocumentsStorage(coreDataStorage: coreDataStorage)
        let repository = DefaultDocumentsRepository(storage: storage)
        let searchDocumentsUseCase = DefaultSearchDocumentsUseCase(repository: repository)
        let saveDocumentUseCase = DefaultSaveDocumentUseCase(repository: repository)
        var resultDocument: Document = SearchDocumentsUseCaseTests.documents[2]
        
        // when
        let responseDTO = SaveDocumentUseCaseResponseDTO(document: SearchDocumentsUseCaseTests.documents[0])
        saveDocumentUseCase.execute(responseDTO: responseDTO, completion: { result in
            switch result {
            case .success(let document):
                resultDocument = Document(id: document.id, title: document.title, content: document.content, created: document.created, modified: document.modified)
                expectation.fulfill()
            case .failure(let error):
                XCTFail()
                print(error.localizedDescription)
            }
        })
        
        //then
        var recentDocuments = [Document]()
        let requestDTO = SearchDocumentsUseCaseRequestDTO(name: "American Psycho")
        searchDocumentsUseCase.execute(requestDTO: requestDTO, completion: { result in
            switch result {
            case .success(let documents):
                recentDocuments = documents
                expectation.fulfill()
            case .failure(let error):
                XCTFail()
                print(error.localizedDescription)
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recentDocuments.contains(resultDocument))
    }
}
