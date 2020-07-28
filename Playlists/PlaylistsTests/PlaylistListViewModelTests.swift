//
//  PlaylistListViewModelTests.swift
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

class PlaylistListViewModelTests: XCTestCase {

    var viewModel: PlaylistListViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    fileprivate var service: MockPlaylistService!
    
    override func setUp() {
        super.setUp()
        
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.service = MockPlaylistService()
        self.viewModel = PlaylistListViewModel(playlistService: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchPlaylists() {
        let playlists = scheduler.createObserver([PlaylistViewModel].self)
        
        let playlist1 = Playlist(id: 1, title: "Playlist 1", image: "", duration: 1234, author: "Unknown")
        let playlist2 = Playlist(id: 2, title: "Playlist 2", image: "", duration: 1234, author: "Unknown")
        let playlist3 = Playlist(id: 3, title: "Playlist 3", image: "", duration: 1234, author: "Unknown")
        
        let expectedPlaylists: [Playlist] = [playlist1, playlist2, playlist3]
        service.playlists = expectedPlaylists
        
        let expectedPlaylistViewModels: [PlaylistViewModel] = [PlaylistViewModel(playlist: playlist1), PlaylistViewModel(playlist: playlist2), PlaylistViewModel(playlist: playlist3)]
        
        viewModel.output.playlists
            .drive(playlists)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ()), .next(30, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(playlists.events, [next(10, expectedPlaylistViewModels), next(30, expectedPlaylistViewModels)])
    }
}

fileprivate class MockPlaylistService: PlaylistServiceProtocol {
    
    var playlists: [Playlist]?
    
    func getAllPlaylists() -> Observable<[Playlist]> {
        return Observable.from(optional: playlists)
    }
    
    func getTracks(for playlistID: Int) -> Observable<[Track]> {
        return Observable.empty()
    }

}
