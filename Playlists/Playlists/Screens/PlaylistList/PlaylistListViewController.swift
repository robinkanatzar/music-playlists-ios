//
//  PlaylistListViewController.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaylistListViewController: BaseViewController, StoryboardInitializable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PlaylistListViewModel!
    private let disposeBag = DisposeBag()
    private let numPlaylists: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
        startLoadingAnimation()
    }
    
    private func setupUI() {
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.accessibilityIdentifier = viewModel.accessibilityIdentifier
        
        collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: "PlaylistCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupBindings() {
        self.viewModel.output.playlists
            .do(onNext: { [weak self] _ in
                self?.stopLoadingAnimation()
            })
            .drive(collectionView.rx.items(cellIdentifier: "PlaylistCell", cellType: PlaylistCell.self)) { [weak self] (_, playlist, cell) in
                self?.setupPlaylistCollectionViewCell(cell, playlist: playlist)
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.errorMessage
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.showError(errorMessage)
            })
            .disposed(by: disposeBag)
        
        self.viewModel.input.reload.accept(())
        
        collectionView.rx.modelSelected(PlaylistViewModel.self)
            .bind { [unowned self] playlistViewModel in
                self.viewModel.didSelect(playlistViewModel: playlistViewModel)
        }
        .disposed(by: disposeBag)
    }
    
    private func setupPlaylistCollectionViewCell(_ cell: PlaylistCell, playlist: PlaylistViewModel) {
        cell.update(with: playlist)
    }
    
}
