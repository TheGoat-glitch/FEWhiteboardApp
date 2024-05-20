import SwiftUI

struct LeaderboardView: View {
    @Binding var points: [String: Int] // Accept points dictionary as a binding

    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.headline)

            // Sort options based on points in descending order
            let sortedOptions = points.sorted(by: { $0.value > $1.value })

            List {
                ForEach(0..<min(sortedOptions.count, 5), id: \.self) { index in
                    if index < sortedOptions.count {
                        let option = sortedOptions[index]
                        Text("\(index + 1). \(option.key) - \(option.value) points")
                    }
                }
            }
        }
        .frame(height: 200)
        .border(Color.black)
    }
    func update(point_map: [String: Int]) {
        let points = point_map
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        let points: [String: Int] = ["Option 1": 10, "Option 2": 5, "Option 3": 8, "Option 4": 3, "Option 5": 12]
        return LeaderboardView(points: .constant(points))
    }
}
