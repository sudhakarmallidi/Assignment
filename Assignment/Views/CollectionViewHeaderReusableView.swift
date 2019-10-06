//
//  CollectionViewHeaderReusableView.swift
//  Assignment
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import UIKit

class CollectionViewHeaderReusableView: BaseCollectionReusableView {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class BaseCollectionReusableView: UICollectionReusableView {
    public static var reusableIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reusableIdentifier, bundle: Bundle(for: self))
    }
}
