//
//  ContentView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/12.
//

import SwiftUI

struct ContentView: View {
    @State @Clamping(0...1) private var progress: CGFloat = 1
    var numbers = Array(10...300)
    let gradient = Gradient(colors: [.green, .orange, .red])
    @State private var selectedValue = 110
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                VStack {
                    ZStack(alignment: .bottom) {
                    ZStack {
                        Group {
                            Circle()
                            Picker(selection: $selectedValue, label: Text("")){
                                ForEach(0..<numbers.count) {
                                    Text("\(numbers[$0])").font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                            }.offset(x: 0, y: -10)
                            ArcProgressView(progress:$progress)
                        }
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 35)
                    }
                        Image("metronome_play")
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .offset(x: 0, y: 0)
                    }
                }
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                    .padding(.vertical)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .mask(Image("bgBottom"))
            }
        }
        .background(Color.black.opacity(0.9))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
