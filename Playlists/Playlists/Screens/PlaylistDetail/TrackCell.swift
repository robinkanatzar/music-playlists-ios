//
//  TrackCell.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func update(with viewModel: TrackViewModel) {
        titleLabel.text = viewModel.title
        artistLabel.text = viewModel.artist
        durationLabel.text = viewModel.duration
    }
}
