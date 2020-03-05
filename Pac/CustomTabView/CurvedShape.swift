//
//  CurvedShape.swift
//  Pac
//
//  Created by Robert Pacheco on 12/31/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CurvedShape: View {
    var body: some View {
        Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 55))
            
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2, y: 55), radius: 30, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)

            path.addLine(to: CGPoint(x: 0, y: 55))

            
        }.fill(Color("dark"))
            .rotationEffect(.init(degrees: 180))
    }
}

struct CurvedShape_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedShape()
            CurvedShape()
            Rounded()
            Round()
            Shapeed()
        }
        .padding()
    }
}

struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 25, height: 25))
        
        return Path(path.cgPath)
    }
}

struct Round : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}

struct Shapeed: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomLeft, cornerRadii: CGSize(width: 12, height: 25))
        return Path(path.cgPath)
    }
}

struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 40
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: cornerRadius), control: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
