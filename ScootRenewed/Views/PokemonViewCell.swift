//
//  PokemonViewCell.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit

class PokemonViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView?
    static let nibName = "PokemonViewCell"
    static let cellReuseIdentifier = "PokemonViewCell"
    
    enum Kind {
        case error(String)
        case information(String)
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
       isSelected = false
    }
    
    func configureWith(kind:Kind){
        switch kind {
        case .error(let message):
            break
        case .information(let image):
            imageCell?.image = UIImage(named: image)
      
        }
    }

}
