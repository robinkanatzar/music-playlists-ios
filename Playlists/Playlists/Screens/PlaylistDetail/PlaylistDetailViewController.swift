//
//  PlaylistDetailViewController.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class PlaylistDetailViewController: BaseViewController, StoryboardInitializable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var viewModel: PlaylistDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        startLoadingAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        view.accessibilityIdentifier = viewModel.accessibilityIdentifier
        
        titleLabel.text = viewModel.playlistViewModel.title
        durationLabel.text = viewModel.playlistViewModel.duration
        authorLabel.text = viewModel.playlistViewModel.author
        
        if let url = URL(string: viewModel.playlistViewModel.image),
            let placeholderImage = UIImage(named: "placeholder") {
            coverImageView.af.setImage(withURL: url, placeholderImage: placeholderImage)
        }
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true
    }
    
    private func setupBindings() {
        self.viewModel.output.tracks
            .do(onNext: { [weak self] _ in
                self?.stopLoadingAnimation()
            })
            .drive(self.tableView.rx.items(cellIdentifier: "TrackCell", cellType: TrackCell.self)) { [weak self] (_, track, cell) in
                self?.setupTrackCell(cell, track: track)
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.errorMessage
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.showError(errorMessage)
            })
            .disposed(by: disposeBag)
        
        self.viewModel.input.reload.accept(())
    }
    
    private func setupTrackCell(_ cell: TrackCell, track: TrackViewModel) {
        cell.selectionStyle = .none
        cell.update(with: track)
    }
}
