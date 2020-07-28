//
//  PlaylistDetailViewModel.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PlaylistDetailViewModel {
    var coordinator: PlaylistDetailCoordinator?
    private let playlistService: PlaylistServiceProtocol
    let playlistViewModel: PlaylistViewModel
    
    let accessibilityIdentifier = "playlistDetailView"
    
    let input: Input
    let output: Output
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let tracks: Driver<[TrackViewModel]>
        let errorMessage: Driver<String>
    }
    
    init(playlistViewModel: PlaylistViewModel, playlistService: PlaylistServiceProtocol = PlaylistService.shared) {
        
        self.playlistService = playlistService
        self.playlistViewModel = playlistViewModel
        
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let tracks = reloadRelay
            .asObservable()
            .flatMapLatest({ playlistService.getTracks(for: playlistViewModel.id)})
            .map({ tracks in tracks.map(TrackViewModel.init) })
            .asDriver { (error) -> Driver<[TrackViewModel]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
        }
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(tracks: tracks, errorMessage: errorRelay.asDriver(onErrorJustReturn: L10n.Error.unknown))
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
