//
//  RefreshTableViewCell.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit

class RefreshViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    static let nibName = "RefreshViewCell"
    static let cellReuseIdentifier = "RefreshViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelected = false
    }
    
    func startAnimating() {
        activityIndicatorView?.startAnimating()
    }
}
