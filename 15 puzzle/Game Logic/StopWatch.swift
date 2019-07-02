//
//  StopWatch.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 6/11/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import Foundation

class StopWatch {
    typealias Time = String
    typealias MinutesCount = Int
    typealias HourCount = Int
    
    private var startDate: Date!
    private var minutesCount: MinutesCount!
    private var hourCount: HourCount!
    private var timerIsWorking: Bool!
    
    public func startStopWatch()  {
        startDate = Date()
        minutesCount = 0
        timerIsWorking = true
    }
    
    public func getTime() -> Time {
        guard timerIsWorking == true else { preconditionFailure("StopWatch isn't runing") }
        let date = Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
        let hours = Int(date / 3600)
        let minutes = Int(date / 60)
        changeCountOf(minutes: minutes)
        changeCountOf(hours: hours)
        
        let seconds = Int(date)
        
        return "\(hours):\(minutes - (60 * hours)):\(seconds - (60 * minutesCount))"
    }
    
    public func stop() -> Time {
        guard timerIsWorking == true else { preconditionFailure("StopWatch isn't runing") }
        let time = getTime()
        timerIsWorking = false
        return time
    }
    
    private func changeCountOf(minutes: MinutesCount) {
        minutesCount = minutes
    }
    
    private func changeCountOf(hours: HourCount) {
        hourCount = hours
    }
}
