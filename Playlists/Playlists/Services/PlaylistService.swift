//
//  PlaylistService.swift
//  Playlists
//
//  Created by Robin Kanatzar on 7/27/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

enum ServiceError: Error {
    case cannotParse
}

protocol PlaylistServiceProtocol {
    func getAllPlaylists() -> Observable<[Playlist]>
    func getTracks(for playlistID: Int) -> Observable<[Track]>
}

class PlaylistService: PlaylistServiceProtocol {
    
    static let shared = PlaylistService()
    
    func getAllPlaylists() -> Observable<[Playlist]> {
        return Observable.create { observer -> Disposable in
            let url = URL(string: "https://api.deezer.com/user/5/playlists")!

            AF.request(url).response { response in
                if response.data != nil {
                    if let data = response.data {
                        do {
                            let json = try JSON(data: data)
                            let playlists = json["data"]
                            var playlistArray: [Playlist] = []
                            
                            for (_, item) in playlists {
                                let id = item["id"].int
                                let title = item["title"].string
                                let duration = item["duration"].int
                                let image = item["picture"].string
                                let author = item["creator"]["name"].string
                                let playlist = Playlist(id: id ?? 0, title: title ?? L10n.unknown, image: image ?? "", duration: duration ?? 0, author: author ?? L10n.unknown)
                                playlistArray.append(playlist)
                            }
                            observer.onNext(playlistArray)
                        } catch {
                            observer.onError(error)
                        }
                    }
                } else {
                    observer.onError(ServiceError.cannotParse)
                }
            }
            return Disposables.create()
        }
    }
    
    func getTracks(for playlistID: Int) -> Observable<[Track]> {
        return Observable.create { observer -> Disposable in
            let url = URL(string: "https://api.deezer.com/playlist/\(playlistID)/tracks")!

            AF.request(url).response { response in
                if response.data != nil {
                    if let data = response.data {
                        do {
                            let json = try JSON(data: data)
                            let tracks = json["data"]
                            var tracksArray: [Track] = []
                            for (_, item) in tracks {
                                let title = item["title"].string
                                let duration = item["duration"].int
                                let artist = item["artist"]["name"].string
                                let track = Track(title: title ?? L10n.unknown, artist: artist ?? L10n.unknown, duration: duration ?? 0)
                                tracksArray.append(track)
                            }
                            observer.onNext(tracksArray)
                        } catch {
                            observer.onError(error)
                        }
                    }
                } else {
                    observer.onError(ServiceError.cannotParse)
                }
            }
            return Disposables.create()
        }
    }
}
