//
//  PlaylistListViewModel.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PlaylistListViewModel {
    
    var coordinator: PlaylistListCoordinator?
    private let playlistService: PlaylistServiceProtocol
    
    let title = L10n.PlaylistList.title
    let accessibilityIdentifier = "playlistListView"
    
    let input: Input
    let output: Output
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let playlists: Driver<[PlaylistViewModel]>
        let errorMessage: Driver<String>
    }
    
    init(playlistService: PlaylistServiceProtocol = PlaylistService.shared) {
        
        self.playlistService = playlistService
        
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let playlists = reloadRelay
            .asObservable()
            .flatMapLatest({ playlistService.getAllPlaylists() })
            .map({ playlists in playlists.map(PlaylistViewModel.init) })
            .asDriver { (error) -> Driver<[PlaylistViewModel]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
        }
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(playlists: playlists, errorMessage: errorRelay.asDriver(onErrorJustReturn: L10n.Error.unknown))
            
    }
    
    func didSelect(playlistViewModel: PlaylistViewModel) {
        coordinator?.onSelect(playlistViewModel)
    }
    
}
