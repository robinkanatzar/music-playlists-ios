//
//  PlaylistViewModel.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation

class PlaylistViewModel: Equatable {
    
    let title: String
    let id: Int
    let image: String
    let duration: String
    let author: String

    init(playlist: Playlist) {
        self.title = playlist.title
        self.id = playlist.id
        self.image = playlist.image
        self.duration = playlist.duration.secondsToTime()
        self.author = L10n.PlaylistDetail.author(playlist.author)
    }
    
    static func == (lhs: PlaylistViewModel, rhs: PlaylistViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
