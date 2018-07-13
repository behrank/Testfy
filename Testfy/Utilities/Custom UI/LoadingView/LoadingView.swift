//
//  LoadingView.swift
//  Testfy
//
//  Created by Behran Kankul on 10.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import UIKit
import Lottie
import PureLayout
class LoadingView:UIView {
    
    let animationView:LOTAnimationView = LOTAnimationView(name: "loading_animation")
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var isOnFire : Bool = false {
        willSet {
            if newValue == isOnFire { return }
            if newValue {
                guard let window = UIApplication.shared.keyWindow else { return }
                window.addSubview(self)
                window.bringSubview(toFront: self)
                autoPinEdgesToSuperviewEdges()
                animationView.contentMode = .scaleAspectFill
                
                self.container.addSubview(animationView)
                animationView.translatesAutoresizingMaskIntoConstraints = false
                animationView.autoPinEdgesToSuperviewEdges()
                animationView.loopAnimation = true
                animationView.play()
            } else {
                removeFromSuperview()
            }
        }
    }
}
