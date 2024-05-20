import SwiftUI

struct PollView: View {
    @ObservedObject var pollModel: PollModel
    let updatePoints: ([String: Int]) -> Void

    @State private var newOption: String = ""
    @State private var selectedOptions: [String] = []

    var body: some View {
        VStack {
            Text("Poll")
                .font(.headline)

            // Display existing options with points
            ForEach(pollModel.options.keys.sorted(by: { pollModel.options[$0]! > pollModel.options[$1]! }), id: \.self) { option in
                HStack {
                    Text("\(option): \(pollModel.options[option]!) points")
                    Spacer()
                }
                .padding()
            }

            // Adding a new option
            HStack {
                TextField("New option", text: $newOption)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: {
                    if !newOption.isEmpty {
                        pollModel.addOption(newOption)
                        newOption = ""
                    }
                }) {
                    Text("Add")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.trailing)
            }
            .padding()

            // Vote for top three options
            Text("Vote for your top three options:")
            ForEach(Array(pollModel.options.keys), id: \.self) { option in
                Button(action: {
                    if selectedOptions.count < 3 {
                        selectedOptions.append(option)
                    } else if selectedOptions.contains(option) {
                        if let index = selectedOptions.firstIndex(of: option) {
                            selectedOptions.remove(at: index)
                        }
                    } else {
                        selectedOptions.removeFirst()
                        selectedOptions.append(option)
                    }
                }) {
                    HStack {
                        Image(systemName: selectedOptions.contains(option) ? "checkmark.square" : "square")
                        Text(option)
                    }
                }
            }

            // Submit button
            Button(action: {
                // Vote for the selected options
                for (index, option) in selectedOptions.enumerated() {
                    pollModel.voteForOption(option, rank: index + 1)
                }
                updatePoints(pollModel.options) // Call the closure to update points
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

        }
        .frame(width: 300)
        .border(Color.black)
    }
}

struct PollView_Previews: PreviewProvider {
    static var previews: some View {
        PollView(pollModel: PollModel(), updatePoints: { _ in })
    }
}
