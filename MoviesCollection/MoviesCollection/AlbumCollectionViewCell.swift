//
//  AlbumCollectionViewCell.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/26/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var label: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
        label.text = nil
    }
}
