//
//  SettingsView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        ZStack {
            Color.red
            VStack(spacing: 20) {
                Text("Hello, World!")
                Text("设置节拍类型")
                Text("五星好评")
                Text("反馈问题")
                Text("联系我们")
            }
        }
        .foregroundColor(.white)
        .modifier(NavigationBarModifier(textColor: .white))
        .ignoresSafeArea()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
