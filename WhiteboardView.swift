import SwiftUI

struct WhiteboardView: View {
    @StateObject private var drawingModel = DrawingModel()
    @ObservedObject var pollModel: PollModel
    @Binding var showPollView: Bool
    @Binding var showToolsView: Bool
    let updatePoints: ([String: Int]) -> Void // Closure to update points in ContentView
    
    @State private var comments: [Comment] = []
    @State private var newCommentText: String = ""
    @State private var showComments: Bool = false // Toggle to show/hide comments bar

    var body: some View {
        VStack {
            Canvas { context, size in
                // Draw existing paths
                for drawingPath in drawingModel.paths {
                    let strokeColor = drawingModel.selectedPaths.contains(drawingPath) ? Color.red : Color.black
                    if let path = drawingPath.path {
                        context.stroke(path, with: .color(strokeColor), lineWidth: drawingPath.lineWidth)
                    } else {
                        let path = Path { path in
                            path.addLines(drawingPath.points.map { $0.point })
                        }
                        context.stroke(path, with: .color(strokeColor), lineWidth: drawingPath.lineWidth)
                    }
                }

                // Draw current path if drawing
                if drawingModel.isDrawing {
                    let strokeColor = Color.black
                    if let path = drawingModel.currentPath.path {
                        context.stroke(path, with: .color(strokeColor), lineWidth: drawingModel.currentPath.lineWidth)
                    } else {
                        let path = Path { path in
                            path.addLines(drawingModel.currentPath.points.map { $0.point })
                        }
                        context.stroke(path, with: .color(strokeColor), lineWidth: drawingModel.currentPath.lineWidth)
                    }
                }

                // Draw selection rectangle
                if let selectionRect = drawingModel.selectionRect {
                    context.stroke(Path(selectionRect), with: .color(.blue), lineWidth: 1)
                }
            }
            .gesture(drawingGesture())
            .border(Color.black)
            .frame(width: 700, height: 500)
            
            // Comments Bar
            if showComments {
                VStack {
                    HStack {
                        TextField("Enter comment", text: $newCommentText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: addComment) {
                            Text("Add Comment")
                        }
                        .padding()
                    }
                    
                    // Display comments
                    ForEach($comments) { $comment in
                        CommentView(comment: $comment)
                    }
                }
            }

            HStack {
                Button(action: { showPollView = true }) {
                    Text("Poll")
                }
                .padding()
                Button(action: { showToolsView = true }) {
                    Text("Tools")
                }
                .padding()
                Button(action: { showComments.toggle() }) { // Toggle comments bar visibility
                    Text("Comments")
                }
                .padding()
            }
        }
        .padding()
        .sheet(isPresented: $showPollView) {
            VStack {
                PollView(pollModel: pollModel) { updatedPoints in
                    // Call the closure to update points in ContentView
                    updatePoints(updatedPoints)
                    // Dismiss the PollView
                    showPollView = false
                }
                // Dismiss button
                Button(action: {
                    showPollView = false
                }) {
                    Text("Dismiss")
                }
                .padding()
            }
        }
        .sheet(isPresented: $showToolsView) {
            ToolsView(toolType: $drawingModel.toolType)
        }
    }
    
    func drawingGesture() -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let currentLocation = value.location
                drawingModel.addPoint(currentLocation)
            }
            .onEnded { value in
                let endLocation = value.location
                drawingModel.endDrawing(at: endLocation)
            }
    }
    
    func addComment() {
        let newComment = Comment(text: newCommentText, position: CGPoint(x: 150, y: 150))
        comments.append(newComment)
        newCommentText = ""
    }
}

