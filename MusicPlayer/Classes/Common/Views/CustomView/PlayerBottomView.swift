//
//  PlayerBottomView.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 30/05/21.
//

import UIKit

class PlayerBottomView: UIView {

    let kCONTENT_XIB_NAME = "PlayerBottomView"
    @IBOutlet weak var shadowImageArtView: UIView!
    @IBOutlet weak var cornerImageArtView: UIView!
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cornerView: UIView!
    
    static let defaultContentHeight: CGFloat = 60.0
    
    var currentPlay: SongPlayerModel?
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        contentView.layer.shadowColor = Constants.Colors.C4C4C4.color().cgColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowRadius = 7.0
        
        shadowImageArtView.layer.shadowColor = Constants.Colors.C4C4C4.color().withAlphaComponent(0.7).cgColor
        shadowImageArtView.layer.shadowOffset = CGSize.zero
        shadowImageArtView.layer.shadowOpacity = 0.7
        shadowImageArtView.layer.shadowRadius = 4.0
        shadowImageArtView.layer.cornerRadius = 10
        
        cornerImageArtView.makeItRounded(width: 0.0, borderColor: UIColor.clear.cgColor, cornerRadius: 10) 
    }
    
    //MARK: - Public Functions
    func playNewSong(model:SearchResultModel) {
        
    }
    //MARK: - Actions
    @IBAction func playPauseButtonAction() {
        
    }
    
    
}
