//
//  SearchMusicViewModel.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import UIKit

enum SearchMusicResultCellType: String, CaseIterable {
    case Song
    func cellIdentifier() -> String {
        return self.rawValue + "TableViewCell"
    }
    
}

enum LoadingState : Int {
    case notLoad
    case loading
    case finished
    case failed
}

protocol SearchMusicViewModelProtocol {
    var dataSource: Observable<[SearchMusicContentCellModel]?> { get  set } //1
    var stateLoading: Observable<LoadingState> { get set }
    var error: Observable<Error?> { get set }
}

class SearchMusicViewModel: SearchMusicViewModelProtocol {

    var searchNetworkProvider = SearchNetworkProvider()
    
    var dataSource: Observable<[SearchMusicContentCellModel]?> = Observable(nil)
    var stateLoading: Observable<LoadingState> = Observable(.notLoad)
    var error: Observable<Error?> = Observable(nil)
    
    
    func buildSearchResultContentCellModels(_ searchResultModels: [SearchResultModel]? = nil) {
        var cellModels = [SearchMusicContentCellModel]()
        if let validSearchResultModels = searchResultModels {
            for searchResult in validSearchResultModels {
                cellModels.append(SearchMusicContentCellModel(cellType: .Song, data: searchResult))
            }
        }
        
        self.dataSource.value = cellModels
    }
    
    
    func clearAllFetchedData() {
        self.dataSource.value = nil
    }
    
    func performSearch(_ text: String) {
        if (text.isEmpty) {
            clearAllFetchedData()
        } else {
            getSearchResult(keyword: text)
        }
    }
}

// MARK: get API
extension SearchMusicViewModel {
    func getSearchResult(keyword:String) {
        clearAllFetchedData()
        self.stateLoading.value = .loading
        searchNetworkProvider.searchSong(with: keyword, completion: { result in
            switch result {
            case .success(let searchResultResponseModel):
                print("success data :\(searchResultResponseModel)")
                if let searchResults = searchResultResponseModel.results, searchResults.count > 0 {
                    self.buildSearchResultContentCellModels(searchResults)
                } else {
                    self.dataSource.value = nil
                }
            case .failure(let error):
                print("error :\(error)")
            }
            
            self.stateLoading.value = .finished
        })
    }
}

// MARK: DataSource
extension SearchMusicViewModel {
    
    func numberOfCellModels() -> Int {
        return dataSource.value?.count ?? 0
    }
    
    func cellModelAtIndex(_ index: Int) -> SearchMusicContentCellModel? {
        guard index >= 0 && index < numberOfCellModels() else {
            return nil
        }
        return dataSource.value?.item(at: index)
    }
    
    func heightForCellAtIndex(_ index: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
