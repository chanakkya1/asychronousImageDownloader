//
//  NetworkOperation.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/27/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import Foundation
import UIKit

class NetworkOperation :Operation {
    private var _executing:Bool
    private var _finished:Bool
    let albumStore:AlbumsStore
    let album:Album
    let completionHandler:(UIImage?)->()
    
    
    init(albumsStore:AlbumsStore, album:Album,completionHandler:@escaping (UIImage?)->()) {
        self._executing = false
        self._finished = false
        self.albumStore = albumsStore
        self.album = album
        self.completionHandler = completionHandler
        super.init()
    }
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isConcurrent: Bool {
        return true
    }
    
    override var  isExecuting: Bool {
        return _executing
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override func start() {
        if self.isCancelled{
            self.willChangeValue(forKey: "isFinished")
            _finished = true
            didChangeValue(forKey: "isFinished")
            return
        }
        self.willChangeValue(forKey: "isExecuting")
        albumStore.fetchImage(forAlbum: album){[unowned self] image in
            self.completionHandler(image)
            self.completeOperation()
        }
        _executing = true
        didChangeValue(forKey: "isExecuting")
        
    }
    
    private func completeOperation(){
        self.willChangeValue(forKey: "isFinished")
        self.willChangeValue(forKey: "isExecuting")
        _finished = true
        _executing = false
        didChangeValue(forKey: "isFinished")
        didChangeValue(forKey: "isExecuting")
    }
    
    deinit {
        print("operation deallocated")
    }
}
