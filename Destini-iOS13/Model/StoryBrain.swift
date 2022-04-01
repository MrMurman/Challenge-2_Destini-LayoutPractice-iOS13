//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


struct StoryBrain {
    
    var stories: [Story] = Story.sampleData
    var currentStory: Int = 0
    
    
    mutating func nextStory(userChoice: String?) {
        guard let userChoice = userChoice else {
            return
        }

        switch userChoice {
        case stories[currentStory].choice1:
            self.currentStory = self.stories[currentStory].choice1Destination
        case stories[currentStory].choice2:
            self.currentStory = self.stories[currentStory].choice2Destination
        default: return
        }
    }
    
}
