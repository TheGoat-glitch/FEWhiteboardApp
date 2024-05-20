//
//  Comment.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/17/24.
//

import Foundation
import SwiftUI

struct Comment: Identifiable {
    let id = UUID()
    var text: String
    var position: CGPoint
}
