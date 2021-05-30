//
//  NetworkConfiguration.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import Foundation

enum MusicPlayerAPI {
    case itunesSearch(keyword:String)
    
    func urlString() -> String {
        return self.apiString()
    }
    
    fileprivate func apiString() -> String {
        switch self {
        case .itunesSearch(let keyword):
            return "https://itunes.apple.com/search?term=\(keyword)&media=music&entity=song&limit=25"
        }
    }
}
