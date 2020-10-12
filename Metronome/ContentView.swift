//
//  ContentView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/12.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 1
    let gradient = Gradient(colors: [.green, .orange, .red])
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                ZStack {
                    ZStack(alignment: .bottom) {
                        ArcProgressView(progress)
                        Image("metronome_play")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .offset(x: 0, y: 30)
                    }
                    .frame(width: proxy.size.width - 100,
                           height: proxy.size.width - 100)
                }
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
                    ).padding(.vertical)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .mask(Image("bgBottom"))
            }
        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
