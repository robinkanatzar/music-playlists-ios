//
//  Int+Extensions.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation

extension Int {
    func secondsToTime() -> String {

        let (hour, minute, second) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteString =  minute < 10 ? "0\(minute)" : "\(minute)"
        let secondString =  second < 10 ? "0\(second)" : "\(second)"

        return "\(hourString):\(minuteString):\(secondString)"
    }
}
