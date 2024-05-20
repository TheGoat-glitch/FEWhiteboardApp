import SwiftUI

struct ContentView: View {
    @StateObject private var pollModel = PollModel()
    @State private var showPollView = false
    @State private var showToolsView = false
    @State private var points: [String: Int] = [:]

    var body: some View {
        HStack {
            VStack {
                LeaderboardView(points: $pollModel.options)
                ProgressBarView(pollModel: pollModel)
            }
            .frame(width: 150)
            .border(Color.black)

            VStack {
                WhiteboardView(pollModel: pollModel, showPollView: $showPollView, showToolsView: $showToolsView, updatePoints: { updatedPoints in
                    // Update the points in ContentView
                    self.points = updatedPoints
                })
                .padding()

                HStack {
                    Button(action: speak) {
                        Text("Speak")
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(Color.black)

            VStack {
                ChatView()
                TeamPickerView()
            }
            .frame(width: 200)
            .border(Color.black)
        }
        .padding()
    }


    func comment() {
        // Handle comment action
    }

    func speak() {
        // Handle speak action
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
