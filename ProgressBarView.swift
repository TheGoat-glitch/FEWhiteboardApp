import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var pollModel: PollModel

    var body: some View {
        VStack {
            Text("Progress")
                .font(.headline)
            
            if let firstOptionPoints = pollModel.options.values.first {
                ProgressBar(points: firstOptionPoints)
                    .frame(height: 20)
            }
        }
        .frame(height: 100)
        .border(Color.black)
    }
}

struct ProgressBar: View {
    var points: Int
    @State private var level: Int = 1

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.teal)
                
                let maxPoints = Double(level * 10)
                let adjustedValue = Double(points) / maxPoints
                Rectangle()
                    .frame(width: min(CGFloat(adjustedValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(adjustedValue >= 1.0 ? Color.red : Color.blue)
                    .animation(.linear, value: adjustedValue)
            }
        }
        .onChange(of: points) { newValue in
            adjustLevel(for: newValue)
        }
    }
    
    private func adjustLevel(for points: Int) {
        while points >= level * 10 {
            level += 1
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(pollModel: PollModel())
    }
}
