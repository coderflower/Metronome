//
//  ArcProgressView.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import SwiftUI

struct ArcProgressView: View {
    var gradient = Gradient(colors: [.green, .orange, .red])
    @Clamping(0...1) var progress: CGFloat = 0 {
        didSet {
            value = Int(300 * progress)
        }
    }
    @Clamping(10...300) var value: Int = 10
    var strokeGradient: AngularGradient {
        AngularGradient(
            gradient: gradient,
            center: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/,
            angle: .degrees(130)
        )
    }

    init(_ progress: CGFloat = 0.3) {
        self.progress = progress
    }
    
    private func strokeStyle(_ proxy: GeometryProxy) -> StrokeStyle {
        StrokeStyle(
            lineWidth: 0.1 * min(proxy.size.width, proxy.size.height),
            lineCap: .round
        )
    }
    
    
    public var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    Circle()
                        .stroke(Color("progressBackground"),
                                style: self.strokeStyle(proxy))
                        .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    ArcShape(sliceDegress: 100)
                        .trim(from: 0, to: progress)
                        .stroke(self.strokeGradient,
                                style: self.strokeStyle(proxy))
                        .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .animation(.easeInOut)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.width)
        }
    }
}


fileprivate struct ArcShape: Shape {
    var sliceDegress: Double = 0
    
    private var startAngle: Angle {
        .degrees(90 + sliceDegress * 0.5)
    }
    
    private var endAngle: Angle {
        // 避免出现类似90 - 90 不会画圆弧
        .degrees(450 - sliceDegress * 0.5)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = min(rect.width, rect.height) * 0.5
        
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}


struct ArcProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ArcProgressView(0.8).padding(.all, 50)
    }
}
