//
//  BigRadioButton.swift
//  testing
//
//  Created by Elizabeth Hernandez on 4/24/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI

struct BigRadioButton: View {
    
    @State private var animate: Bool = false
    let beginAnimation: () -> Void
    var outer: CGFloat
    var inner: CGFloat
    var triWidth: CGFloat
    var circleWidth: CGFloat
    var cicleHeight: CGFloat
    @State var alpha: CGFloat = 1
    @State var animateColor: Bool = true
    @State var animateColor1: Bool = true
    @State var insideFill: String = "play.fill"
    @State var insideToggle: Bool = false

    var body: some View {
        ZStack {
            Arc(radius: outer).fill(Color.color3)
                            .frame(width: 200, height: 200).scaleEffect(animateColor1 ? 1: 0.8)
                                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1.0)).onAppear(){
                                    self.animateColor1.toggle()
                            }
            Arc(radius: inner).fill(Color.color2)
                            .frame(width: 100, height: 100).scaleEffect(animateColor ? 1: 0.8)
                                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(1.0)).onAppear(){
                                    self.animateColor.toggle()
                            }
            VStack {
                ZStack {
                    Triangle(triWidth: triWidth).fill(Color.color1)
                                .frame(width: 45, height: 100)
                                .cornerRadius(15)
                        .offset(y: 45)
                    Circle().fill(Color.color1)
                                .frame(width: 45, height: 100)
                        .offset(y: 5).overlay(Image(systemName: insideFill).frame(width: 15, height: 25, alignment: .bottom
                        )).onTapGesture {
                            if(!self.insideToggle){
                                self.insideToggle.toggle()
                                self.insideFill = "pause.fill"
                                globalPlayer.playLive()

                            } else {
                                globalPlayer.stop()
                                self.insideFill = "play.fill"
                                self.insideToggle.toggle()


                            }
                            
                    }
                }
            }
        }
    }
    
 
}


extension Color {
    static let color1 = Color(red: 0.988, green: 0.361, blue: 0.361)
    static let color2 = Color(red: 0.839, green: 0.180, blue: 0.180)
    static let color3 = Color(red: 0.659, green: 0.035, blue: 0.035)
}

struct Arc : Shape {
    let radius: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius, startAngle: .degrees(60),
                    endAngle: .degrees(120), clockwise: true)
        return path.strokedPath(.init(lineWidth: 3))
        
    }
}

struct Triangle : Shape {
    var triWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path ()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct BigRadioButton_Previews: PreviewProvider {
        var outerArc: CGFloat = 80
              var innerArc: CGFloat = 60
             var triW: CGFloat = 20
           var circleWidth: CGFloat = 10
              var circleHeight: CGFloat = 10
      @State static var startAnimation = false
    static var previews: some View {
        BigRadioButton(beginAnimation: beginAnimation, outer:CGFloat(80), inner:CGFloat(60), triWidth: CGFloat(20), circleWidth: 10 ,cicleHeight: 10)
        
    }
    static func beginAnimation() {
        self.startAnimation.toggle()
            print("after call being animation")
        }
}
