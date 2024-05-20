//
//  CGPointHasable.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/16/24.
//

import Foundation
import CoreGraphics

struct CGPointHashable: Hashable {
    let point: CGPoint
    
    init(_ point: CGPoint) {
        self.point = point
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(point.x)
        hasher.combine(point.y)
    }
    
    static func == (lhs: CGPointHashable, rhs: CGPointHashable) -> Bool {
        return lhs.point.x == rhs.point.x && lhs.point.y == rhs.point.y
    }
}
