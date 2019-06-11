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
    
    //    var timer: Timer!
    private var startDate: Date!
    private var minutesCount: MinutesCount!
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
        changeMinutesCount(minutes)
        let seconds = Int(date)
        
        return "\(hours):\(minutes):\(seconds - (60 * minutesCount))"
        
    }
    
    public func stop() -> Time {
        guard timerIsWorking == true else { preconditionFailure("StopWatch isn't runing") }
        let time = getTime()
        timerIsWorking = false
        return time
    }
    
    private func changeMinutesCount(_ minutes:Int) {
        minutesCount = minutes
    }
}
