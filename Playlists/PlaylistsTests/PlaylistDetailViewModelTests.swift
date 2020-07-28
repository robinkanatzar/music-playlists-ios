//
//  PlaylistDetailViewModelTests.swift
//  PlaylistsTests
//
//  Created by Robin Kanatzar on 7/28/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Playlists

class PlaylistDetailViewModelTests: XCTestCase {
    
    var viewModel: PlaylistDetailViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    fileprivate var service: MockPlaylistService!

    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.service = MockPlaylistService()
        
        let playlist = Playlist(id: 5, title: "Playlist title", image: "", duration: 12345, author: "None")
        let playlistViewModel = PlaylistViewModel(playlist: playlist)
        self.viewModel = PlaylistDetailViewModel(playlistViewModel: playlistViewModel, playlistService: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchTracks() {
        let tracks = scheduler.createObserver([TrackViewModel].self)
        
        let track1 = Track(title: "Track 1", artist: "Unknown", duration: 12345)
        let track2 = Track(title: "Track 2", artist: "Unknown", duration: 12345)
        let track3 = Track(title: "Track 3", artist: "Unknown", duration: 12345)
        
        let expectedTracks: [Track] = [track1, track2, track3]
        service.tracks = expectedTracks
        
        let expectedTrackViewModels: [TrackViewModel] = [TrackViewModel(track: track1), TrackViewModel(track: track2), TrackViewModel(track: track3)]
        
        viewModel.output.tracks
            .drive(tracks)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ()), .next(30, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(tracks.events, [next(10, expectedTrackViewModels), next(30, expectedTrackViewModels)])
    }
    
}

fileprivate class MockPlaylistService: PlaylistServiceProtocol {
    
    var tracks: [Track]?
    
    func getAllPlaylists() -> Observable<[Playlist]> {
        return Observable.empty()
    }
    
    func getTracks(for playlistID: Int) -> Observable<[Track]> {
        return Observable.from(optional: tracks)
    }
}
