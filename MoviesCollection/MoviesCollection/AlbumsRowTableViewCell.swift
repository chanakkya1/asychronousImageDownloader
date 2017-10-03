//
//  AlbumsRowTableViewCell.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/25/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import UIKit

class AlbumsRowTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        collectionView.tag = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
