//
//  PlayerBottomView.swift
//  MusicPlayer
//
//  Created by Muhammad Nizar on 30/05/21.
//

import UIKit

enum StatePlayer {
    case playing
    case pause
    case stop
    case error
}

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
    var audioPlayer = AudioPlayer.instance
    var currentState: Observable<StatePlayer> = Observable(.stop)
    
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        shadowImageArtView.layer.shadowColor = Constants.Colors.C4C4C4.color().withAlphaComponent(0.7).cgColor
        shadowImageArtView.layer.shadowOffset = CGSize.zero
        shadowImageArtView.layer.shadowOpacity = 0.7
        shadowImageArtView.layer.shadowRadius = 4.0
        shadowImageArtView.layer.cornerRadius = 10
        
        cornerImageArtView.makeItRounded(width: 0.0, borderColor: UIColor.clear.cgColor, cornerRadius: 10)
        
        
    }
    
    //MARK: - Public Functions
    func playSong(model:SongPlayerModel) {
        currentState.value = .stop
        audioPlayer.initPlayer(url: model.streamUrl)
        currentPlay = model
        albumArtImageView.setImage(model.imageUrl)
        songNameLabel.text = model.name
        playPauseButtonAction()
        
    }
    
    func stopSong() {
        currentState.value = .stop
        setButtonImageToPlay()
    }
    
    func setButtonImageToPlay() {
        let playImage = UIImage(systemName: "play.fill")
        playPauseButton.setImage(playImage, for: .normal)
    }
    
    func setButtonImageToPause() {
        let pauseImage = UIImage(systemName: "pause.fill")
        playPauseButton.setImage(pauseImage, for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func playPauseButtonAction() {
        if (currentState.value == .pause || currentState.value == .stop) {
            currentState.value = .playing
            setButtonImageToPause()
            audioPlayer.play()
        } else if (currentState.value == .playing) {
            currentState.value = .pause
            setButtonImageToPlay()
            audioPlayer.pause()
        }
    }
}
