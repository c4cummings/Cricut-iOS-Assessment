//
//  Stencils.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import Foundation
import SwiftUI

struct Stencils {
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            return path
        }
    }
    
    struct Circle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            //path.addCurve(to: <#T##CGPoint#>, control1: <#T##CGPoint#>, control2: <#T##CGPoint#>)
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY))
            return path
        }
    }
    
    struct Square: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            return path
        }
    }
    
    struct Diamond: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: CGPoint(x: center.x, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: center.y))
            path.addLine(to: CGPoint(x: center.x, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: center.y))
            path.addLine(to: CGPoint(x: center.x, y: 0))
            return path
        }
    }
}
