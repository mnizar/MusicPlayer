//
//  SearchNetworkProvider.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import Foundation

class SearchNetworkProvider {
    
    /**
        Search result using Itunes API
        see docs at https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api
     */
    func searchSong(with keyword:String, completion: @escaping (Result<SearchResultResponseModel, Error>) -> Void) {
        let percentageEncodingKeyword = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let searchUrl = MusicPlayerAPI.itunesSearch(keyword: percentageEncodingKeyword).urlString()
        
        NetworkManager.shared.get(urlString: searchUrl, completionBlock: { result in
                switch result {
                case .failure(let error):
                    print ("failure", error)
                    completion(.failure(error))
                case .success(let data) :
                    let decoder = JSONDecoder()
                    do {
                        completion(.success(try decoder.decode(SearchResultResponseModel.self, from: data)))
                    } catch let error {
                        print(error)
                    }
                }
            })
    }
}
