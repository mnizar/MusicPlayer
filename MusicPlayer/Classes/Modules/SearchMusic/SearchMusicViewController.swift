//
//  SearchMusicViewController.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import UIKit

class SearchMusicViewController: UIViewController {

    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTextfield: UITextField!
    @IBOutlet private weak var playerView: PlayerBottomView!
    @IBOutlet private weak var playerViewHeightConstraint: NSLayoutConstraint!
    
    let viewModel = SearchMusicViewModel()
    
    var workItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()
        bindViewModel()
    }
    
    // MARK:- UI
    private func setupUI() {
        self.title = "Search Song"
        searchView.layer.borderWidth = 0.5
        searchView.layer.borderColor = Constants.Colors.F3F3F3.color().cgColor
        searchView.layer.cornerRadius = 10
        searchView.layer.applySketchShadow(color: Constants.Colors.C4C4C4.color(),
                                           alpha: 1.0,
                                           x: 0,
                                           y: 1,
                                           blur: 4,
                                           spread: 0)
        searchTextfield.returnKeyType = .search
        searchTextfield.placeholder = "Search song"
        
        playerViewHeightConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    private func setupTableView() {
        
        for cellType in SearchMusicResultCellType.allCases {
            let nibToRegister = UINib(nibName: String(describing: cellType.cellIdentifier()), bundle: Bundle.main)
            tableView.register(nibToRegister, forCellReuseIdentifier: String(describing: cellType.cellIdentifier()))
        }
        let emptyNib = UINib(nibName: String(describing: EmptyTableViewCell.self), bundle: Bundle.main)
        tableView.register(emptyNib, forCellReuseIdentifier: String(describing: EmptyTableViewCell.self))
        
        let loadingNib = UINib(nibName: String(describing: LoadingTableViewCell.self), bundle: Bundle.main)
        tableView.register(loadingNib, forCellReuseIdentifier: String(describing: LoadingTableViewCell.self))
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        self.tableView.contentInset = insets
        tableView.separatorStyle = .none
    }
    
    private func bindViewModel() {
        
        viewModel.dataSource.bind { (_) in
            // Perform table updates on UI thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
         }
    }
}

// MARK: UITableViewDataSource
extension SearchMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = viewModel.numberOfCellModels()
        if (numberOfRows == 0) {
            numberOfRows = 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let numberOfRows = viewModel.numberOfCellModels()
        if (numberOfRows == 0) {
            if (viewModel.stateLoading.value == .loading) {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingTableViewCell.self), for: indexPath) as! LoadingTableViewCell
                cell.loadingIndicatorView.startAnimating()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmptyTableViewCell.self), for: indexPath) as! EmptyTableViewCell
                if (searchTextfield.text?.isEmpty == true) {
                    cell.configureCell("Search all song from itunes here", imageName: "initialSearch")
                } else {
                    cell.configureCell("No Results. Try a new search", imageName: "noResult")
                }
                return cell
            }
        } else {
            if let cellModel = viewModel.cellModelAtIndex(indexPath.row) {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellType.cellIdentifier(), for: indexPath) as! SongTableViewCell
                cell.configureWithCellModel(cellModel)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

extension SearchMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (viewModel.numberOfCellModels() == 0) {
            return tableView.frame.height
        }
        return viewModel.heightForCellAtIndex(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


// MARK: UITextFieldDelegate
extension SearchMusicViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Cancel any outstanding search
        self.workItem?.cancel()
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return true
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        // Set up a DispatchWorkItem to perform the search
        let workItem = DispatchWorkItem { [weak self] in
            self?.viewModel.performSearch(updatedText)
        }
        
        // Run this block after 1 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        
        // Keep a reference to it so it can be cancelled
        self.workItem = workItem
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.clearAllFetchedData()
        return true
    }
}
