//
//  ToolType.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/15/24.
//

import Foundation
import SwiftUI

enum ToolType: String, CaseIterable {
    case pencil = "pencil"
    case eraser = "eraser"
    case rectangle = "rectangle"
    case circle = "circle"
    case line = "line.diagonal"
    case select = "lasso"
    
    var systemImageName: String {
        return rawValue
    }
}
