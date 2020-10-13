//
//  ContentView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

struct ContentView: View {
    var numbers = Array(10...300)
    let gradient = Gradient(colors: [.green, .orange, .red])
    @State private var isPlay: Bool = false
    @EnvironmentObject var settings: UserSettings
    @State private var progress: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                ZStack {
                    Color.black.opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                    contentView
                        .navigationBarItems(
                            trailing:NavigationLink(destination: SettingsView()) {
                                Image("settings")
                            }
                        )
                        .navigationBarTitle("节拍器")
                }
            }
        }
    }
    
    var contentView: some View {
        VStack {
            Spacer()
            VStack {
                ZStack(alignment: .bottom) {
                    progressView
                    Image(isPlay ? "metronome_pause" : "metronome_play")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .offset(x: 0, y: 25)
                        .onTapGesture {
                            isPlay = !isPlay
                        }
                }
            }
            Spacer()
            bottomBackgroundView
        }
    }
    
    var progressView: some View {
        ZStack {
            Group {
                Circle().fill(Color.black.opacity(0.7))
                valueView
                ArcProgressView(progress: $progress)
            }
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 35)
        }
    }
    
    var valueView: some View {
        HStack(spacing: 0) {
            Image("metronome_minus")
                .onTapGesture {
                    if settings.selectedValue > settings.minValue {
                        settings.selectedValue -= 1
                    }
                }
            Text("\(settings.value)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: 150)
            Image("metronome_plus")
                .onTapGesture {
                    if settings.selectedValue < settings.maxValue {
                        settings.selectedValue += 1
                    }
                }
        }
    }
    
    var bottomBackgroundView: some View {
        Rectangle()
            .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
            .padding(.vertical)
            .frame(height: 100)
            .mask(Image("bgBottom"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modifier(NavigationBarModifier(textColor: .white))
            .environmentObject(UserSettings())
    }
}
