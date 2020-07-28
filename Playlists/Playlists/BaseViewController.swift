//
//  BaseViewController.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/28/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingAnimation()
    }
    
    private func setupLoadingAnimation() {
        animationView = .init(name: "loading-animation")
        animationView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        animationView?.center = self.view.center
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        
        if let animationView = animationView {
            view.addSubview(animationView)
        }
        animationView?.isHidden = true
    }
    
    func startLoadingAnimation() {
        if let animationView = animationView {
            view.bringSubviewToFront(animationView)
        }
        animationView?.isHidden = false
        animationView?.play()
    }
    
    func stopLoadingAnimation() {
        animationView?.stop()
        animationView?.isHidden = true
    }
    
    func showError(_ errorMessage: String) {
        let controller = UIAlertController(title: L10n.Error.unknown, message: "", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: L10n.ok, style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
