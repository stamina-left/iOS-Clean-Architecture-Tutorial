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
        
        // when
        
        //then
        
    }
}
