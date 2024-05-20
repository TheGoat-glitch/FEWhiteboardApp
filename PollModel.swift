//
//  PollModel.swift
//  WhiteboardAppFE
//
//  Created by Aditya Padia on 5/17/24.
//

import Foundation

class PollModel: ObservableObject {
    @Published var options: [String: Int] = [:]

    // Function to add a new poll option
    func addOption(_ option: String) {
        options[option] = 0
    }

    // Function to remove a poll option
    func removeOption(_ option: String) {
        options.removeValue(forKey: option)
    }

    // Function to update the points for a poll option
    func updatePoints(for option: String, with points: Int) {
        options[option] = points
    }
    
    // Function to vote for an option with a given rank
    func voteForOption(_ option: String, rank: Int) {
        // Update the points for the selected option based on its rank
        options[option] = rank
    }
}


