//
//  GameScene.swift
//  iAds and AdMob Helper
//
//  Created by Dominik on 04/09/2015.


import SpriteKit

extension GameScene: SwiftyAdsDelegate {
    
    func adDidOpen() {
        print("Ad did open")
    }
    
    func adDidClose() {
        print("Ad did close")
    }
    
    func adDidRewardUser(withAmount rewardAmount: Int) {
        // e.g self.coins += rewardAmount
        
        // Will not work with this sample project, adMob just shows a black banner in test mode
        // It only works with 3rd party mediation partners you set up through your adMob account
    }
}

class GameScene: SKScene {
    
    var myLabel: SKLabelNode!
    var touchCounter = 25 {
        didSet {
           guard touchCounter >= 0 else {return }
           myLabel.text = "Remove ads in \(touchCounter) clicks"
        }
    }
    
    override func didMove(to view: SKView) {
        myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Remove ads in \(touchCounter) clicks"
        myLabel.fontSize = 25;
        myLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(myLabel)
        
        /// Set ads helper delegate
        SwiftyAdsManager.delegate = self
        
        // Show banner ad
        SwiftyAdsManager.showBanner()
        
        // TV custom ads controls
        #if os(tvOS)
        let tapMain = UITapGestureRecognizer(target: self, action: #selector(pressedMainButtonTVRemote))
        tapMain.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue)]
        view?.addGestureRecognizer(tapMain)
        
        let tapMenu = UITapGestureRecognizer(target: self, action: #selector(pressedMenuButtonTVRemote))
        tapMenu.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)]
        view?.addGestureRecognizer(tapMenu)
        #endif
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        /* Called when a touch begins */
        
        // Show inter
        SwiftyAdsManager.showInterstitial(withInterval: 2)
        
        // Remove ads after 3 clicks
        touchCounter -= 1
        if touchCounter == 0 {
            SwiftyAdsManager.removeAll()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}