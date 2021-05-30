//
//  SearchResultModel.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import Foundation


struct SearchResultResponseModel: Codable {
    
    let resultCount: Int?
    let results: [SearchResultModel]?
}

struct SearchResultModel: Codable {
    let trackName: String?
    let trackId: Int?
    let previewUrl: String?
    let artistName: String?
    let artworkUrl100: String?
    let collectionName: String?
    var isPlaying: Bool?
}

struct SearchMusicContentCellModel {
    var cellType: SearchMusicResultCellType = .Song
    var data: Any?
}
