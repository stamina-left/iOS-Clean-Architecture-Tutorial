//
//  ViewController.swift
//  iOS-Clean-Architecture-Tutorial
//
//  Created by Albert Pangestu on 15/10/20.
//

import UIKit

final class ViewController: UIViewController {

    private var viewModel: DocumentsListViewModel!
    
    @IBOutlet weak var documentNameSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchBarButtonClicked(_ sender: UIButton) {
        guard let searchValue = documentNameSearchBar.text else { return }
        viewModel.didSearch(query: searchValue)
        print(viewModel.items)
    }
    
}

