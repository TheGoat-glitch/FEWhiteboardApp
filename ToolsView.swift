//
//  ToolsView.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/15/24.
//

import Foundation
// ToolsView.swift
import SwiftUI

struct ToolsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var toolType: ToolType
    
    var body: some View {
        VStack {
            HStack {
                Text("Tools")
                    .font(.title)
                    .padding()
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            Divider()
            HStack {
                ToolButton(toolType: $toolType, type: .pencil)
                ToolButton(toolType: $toolType, type: .eraser)
                ToolButton(toolType: $toolType, type: .rectangle)
                ToolButton(toolType: $toolType, type: .circle)
                ToolButton(toolType: $toolType, type: .line)
                ToolButton(toolType: $toolType, type: .select)
            }
            Spacer()
        }
        .padding()
    }
}

struct ToolButton: View {
    @Binding var toolType: ToolType
    let type: ToolType
    
    var body: some View {
        Button(action: {
            toolType = type
        }) {
            Image(systemName: type.systemImageName)
                .font(.title)
                .foregroundColor(toolType == type ? .accentColor : .secondary)
                .padding()
        }
    }
}
