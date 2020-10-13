//
//  NavigationBarModifier.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    init(textColor: Color) {
        if var attributes = UINavigationBar.appearance().largeTitleTextAttributes {
            attributes[.foregroundColor] = UIColor(textColor)
            UINavigationBar.appearance().largeTitleTextAttributes = attributes
        } else {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(textColor)]
        }
        UINavigationBar.appearance().tintColor = UIColor(textColor)
    }
    
    func body(content: Content) -> some View {
        content
    }
}
