//
//  CustomCollectionViewCell.swift
//  Assignment
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var quarterLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var downArrowBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData(record: Record, isMinVolOfMobileData: Bool) {
        self.quarterLabel.text = (record.quarter!.components(separatedBy: "-"))[1]
        self.volumeLabel.text = record.volumeOfMobileData ?? ""
        self.downArrowBtn.isHidden = !isMinVolOfMobileData
    }
}
extension UICollectionViewCell {
    public static var reusableIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reusableIdentifier, bundle: Bundle(for: self))
    }
}
