//
//  TeamPickerView.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/15/24.
//

import Foundation

import SwiftUI

struct TeamPickerView: View {
    var body: some View {
        VStack {
            Text("Pick Teams")
                .font(.headline)
            Button(action: { /* Handle Create Link */ }) {
                Text("Create Link")
            }
        }
        .border(Color.black)
    }
}

struct TeamPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TeamPickerView()
    }
}
