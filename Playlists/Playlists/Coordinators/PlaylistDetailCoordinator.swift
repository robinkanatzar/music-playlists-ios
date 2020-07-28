//
//  PlaylistDetailCoordinator.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit

final class PlaylistDetailCoordinator: Coordinator {
    let childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let playlistViewModel: PlaylistViewModel
    var parentCoordinator: PlaylistListCoordinator?
    
    init(playlistViewModel: PlaylistViewModel, navigationController: UINavigationController) {
        self.playlistViewModel = playlistViewModel
        self.navigationController = navigationController
    }
    
    func start() {
        let playlistDetailViewController: PlaylistDetailViewController = .initFromStoryboard()
        let playlistDetailViewModel = PlaylistDetailViewModel(playlistViewModel: playlistViewModel)
        playlistDetailViewModel.coordinator = self
        playlistDetailViewController.viewModel = playlistDetailViewModel
        navigationController.pushViewController(playlistDetailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
