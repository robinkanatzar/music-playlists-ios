//
//  H1Label.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit

class H1Label: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textColor = ColorName.textColor.color
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = .systemFont(ofSize: 22, weight: .bold)
        self.accessibilityTraits = .header
    }
}
