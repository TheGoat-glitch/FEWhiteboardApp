//
//  DrawingPath.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/15/24.
//

import Foundation
import SwiftUI

struct DrawingPath: Hashable {
    var points: [CGPointHashable] = []
    var path: Path? = nil
    var lineWidth: CGFloat

    init(points: [CGPointHashable], lineWidth: CGFloat) {
        self.points = points
        self.lineWidth = lineWidth
    }

    init(path: Path, lineWidth: CGFloat) {
        self.path = path
        self.lineWidth = lineWidth
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(points)
        hasher.combine(lineWidth)
    }

    static func == (lhs: DrawingPath, rhs: DrawingPath) -> Bool {
        return lhs.points == rhs.points && lhs.lineWidth == rhs.lineWidth
    }
}


