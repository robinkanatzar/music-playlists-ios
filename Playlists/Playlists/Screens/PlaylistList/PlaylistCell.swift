//
//  PlaylistCell.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaylistCell: UICollectionViewCell {
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let playImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupHierarcy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.layer.masksToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        if let playImage = UIImage(named: "play") {
            playImageView.image = playImage
            playImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
    }
    
    private func setupHierarcy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playImageView)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left, .right, .top])
        titleLabel.pinToSuperviewEdges([.left, .right])
        titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        playImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        playImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor).isActive = true
        playImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func update(with viewModel: PlaylistViewModel) {
        titleLabel.text = viewModel.title
        self.accessibilityLabel = viewModel.title
        
        if let url = URL(string: viewModel.image),
            let placeholderImage = UIImage(named: "placeholder") {
            backgroundImageView.af.setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
}
