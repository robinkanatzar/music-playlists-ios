//
//  PlaylistListCoordinator.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import UIKit

final class PlaylistListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let playlistListViewController: PlaylistListViewController = .initFromStoryboard()
        let playlistListViewModel = PlaylistListViewModel()
        playlistListViewModel.coordinator = self
        playlistListViewController.viewModel = playlistListViewModel
        navigationController.setViewControllers([playlistListViewController], animated: false)
    }
    
    func onSelect(_ playlistViewModel: PlaylistViewModel) {
        let playlistDetailCoordinator = PlaylistDetailCoordinator(playlistViewModel: playlistViewModel, navigationController: navigationController)
        playlistDetailCoordinator.parentCoordinator = self
        childCoordinators.append(playlistDetailCoordinator)
        playlistDetailCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            if childCoordinator === coordinator {
                return true
            } else {
                return false
            }
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
