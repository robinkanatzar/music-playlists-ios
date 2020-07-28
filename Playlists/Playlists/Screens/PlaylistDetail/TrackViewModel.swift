//
//  TrackViewModel.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation

class TrackViewModel: Equatable {
    let title: String
    let artist: String
    let duration: String
    
    init(track: Track) {
        self.title = track.title
        self.artist = track.artist
        self.duration = track.duration.secondsToTime()
    }
    
    static func == (lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
