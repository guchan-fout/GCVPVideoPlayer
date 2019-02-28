//
//  GCVPPlayerView.swift
//  GCVideoPlayer
//
//  Created by gc on 2019/02/13.
//  Copyright © 2019 gc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class GCVPPlayerView: UIView {
    var player: AVPlayer? {
        get {
            playerLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

}
