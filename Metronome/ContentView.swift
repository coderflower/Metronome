//
//  ContentView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

struct ContentView: View {
    @State @Clamping(0...1) private var progress: CGFloat = 120 / 300.0
    var numbers = Array(10...300)
    let gradient = Gradient(colors: [.green, .orange, .red])
    @State private var selectedValue = 110
    @State private var isPlay: Bool = false
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                ZStack {
                    Color.black.opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
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
                                Image(isPlay ? "metronome_pause" : "metronome_play")
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .onTapGesture {
                                        isPlay = !isPlay
                                    }
                            }
                        }
                        Spacer()
                        Rectangle()
                            .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                            .padding(.vertical)
                            .frame(height: 100)
                            .mask(Image("bgBottom"))
                    }
                    .navigationBarItems(trailing: Image("settings"))
                    .navigationBarTitle("跑呗节拍器")
                    .onAppear {
                        UINavigationBar.appearance()
                            .largeTitleTextAttributes = [
                                .foregroundColor: UIColor.white
                            ]
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
