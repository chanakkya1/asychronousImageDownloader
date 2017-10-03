//
//  ViewController.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/25/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var albumStore:AlbumsStore! = AlbumsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 114
        // Do any additional setup after loading the view, typically from a nib.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return albumStore.artistIds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let id = albumStore.artistIds[indexPath.section]
        albumStore.fetchAlbum(forArtist: id) { [weak self] (result)->Void in
            if let sectionindex = self?.albumStore.artistIds.index(of: id){
                if let cell = self?.tableView.cellForRow(at: IndexPath(row: 0, section: sectionindex)) as? AlbumsRowTableViewCell{
                    cell.collectionView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsRowTableViewCell", for: indexPath) as! AlbumsRowTableViewCell
        cell.collectionView.tag = albumStore.artistIds[indexPath.section]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumStore.artistAlbums[collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = collectionView.tag
        let album = albumStore.artistAlbums[id]![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.label.text = album.collectionName
        
       // cell.backgroundColor = UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let id = collectionView.tag
        let album = albumStore.artistAlbums[id]![indexPath.row]
        albumStore.fetchImage(forAlbum: albumStore.artistAlbums[collectionView.tag]![indexPath.row]) { (image) in
            let indexPath = IndexPath(row: 0, section: self.albumStore.artistIds.index(of: id)!)
            if let tablecell = self.tableView.cellForRow(at:indexPath) as? AlbumsRowTableViewCell{
                let item = self.albumStore.artistAlbums[id]!.index(of: album)!
                let collectionViewcell =  tablecell.collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? AlbumCollectionViewCell
                if let collectioncell = collectionViewcell{
                    collectioncell.imageView.image = image
                }
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

