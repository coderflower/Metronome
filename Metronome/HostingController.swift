//
//  HostingController.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

class HostingController: UIHostingController<ContentView> {
    
    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    @objc override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
}
