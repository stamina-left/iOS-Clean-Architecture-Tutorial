//
//  AppDIContainer.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 16/10/20.
//

import Foundation

final class AppDIContainer {
    
    func makeDocumentsSceneDIContainer() -> DocumentsSceneDIContainer {
        return DocumentsSceneDIContainer()
    }
}
