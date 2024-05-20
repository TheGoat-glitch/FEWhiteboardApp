//
//  CommentView.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/17/24.
//

import Foundation
import SwiftUI

struct CommentView: View {
    @Binding var comment: Comment

    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        Text(comment.text)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
            .position(x: comment.position.x + dragOffset.width, y: comment.position.y + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        comment.position.x += value.translation.width
                        comment.position.y += value.translation.height
                    }
            )
    }
}

struct CommentView_Previews: PreviewProvider {
    @State static var comment = Comment(text: "Sample Comment", position: CGPoint(x: 100, y: 100))
    
    static var previews: some View {
        CommentView(comment: $comment)
    }
}
