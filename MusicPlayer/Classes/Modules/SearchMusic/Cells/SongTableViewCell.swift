//
//  SongTableViewCell.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 29/05/21.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var shadowImageArtView: UIView!
    @IBOutlet weak var containerImageArtView: UIView!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowImageArtView.layer.shadowColor = Constants.Colors.C4C4C4.color().withAlphaComponent(0.7).cgColor
        shadowImageArtView.layer.shadowOffset = CGSize.zero
        shadowImageArtView.layer.shadowOpacity = 0.7
        shadowImageArtView.layer.shadowRadius = 4.0
        shadowImageArtView.layer.cornerRadius = 10
        
        containerImageArtView.makeItRounded(width: 0.0, borderColor: UIColor.clear.cgColor, cornerRadius: 10) 
        
        separatorHeightConstraint.constant = 0.5
        containerView.layoutIfNeeded()
        
        albumArtImageView.setImage("https://is5-ssl.mzstatic.com/image/thumb/Music114/v4/7a/f5/26/7af526b3-ff21-43d3-7e03-a25f7011b715/source/100x100bb.jpg")
    }
    
    func configureWithCellModel(_ cellModel: SearchMusicContentCellModel?) {
        
        if let searchResultModel = cellModel?.data as? SearchResultModel {
            songNameLabel.text = searchResultModel.trackName
            artistameLabel.text = searchResultModel.artistName
            albumNameLabel.text = searchResultModel.collectionName
            albumArtImageView.setImage(searchResultModel.artworkUrl100 ?? "")
        }
    }
}
