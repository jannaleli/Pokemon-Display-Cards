//
//  File.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit
struct Pokemon {
    let image: UIImage
}

extension Pokemon {
    init?(image: UIImage?) {
        guard let uid = image as? UIImage else { return nil }
        self.image = image!
    }
}
