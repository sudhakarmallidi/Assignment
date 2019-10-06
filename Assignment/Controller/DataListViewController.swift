//
//  ViewController.swift
//  Assignment
//
//  Created by sudhakar reddy on 22/09/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layOut = UICollectionViewFlowLayout()
            layOut.scrollDirection = .vertical
            layOut.minimumLineSpacing = 1
            layOut.minimumInteritemSpacing = 0
            self.collectionView.collectionViewLayout = layOut
            self.collectionView.register(CustomCollectionViewCell.nib, forCellWithReuseIdentifier: CustomCollectionViewCell.reusableIdentifier)
            self.collectionView.register(CollectionViewHeaderReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeaderReusableView.reusableIdentifier)
        }
    }
    var viewModel: DataListViewModel = DataListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = "Mobile data used in a year"
        self.viewModel.getMobileDataUsageData(offset: 0) { (responseDataModel, error) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.getNumberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfItems(sectionIndex: section)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView: CollectionViewHeaderReusableView? = nil
        if kind == UICollectionView.elementKindSectionHeader{
            headerView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeaderReusableView.reusableIdentifier, for: indexPath) as? CollectionViewHeaderReusableView
            headerView!.addBorders(edges: [.bottom], color: .lightGray)
            let sectionObj = self.viewModel.dataArray[indexPath.section]
            headerView!.yearLabel.text = sectionObj.year
            headerView!.avgLabel.text = String(sectionObj.totalVolumeOfData)
            return headerView!
        }
        return CollectionViewHeaderReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reusableIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.containerView.addBorders(edges: [.bottom], color: .lightGray)
        if let sectionObj = self.viewModel.dataArray[safe: indexPath.section],
            let record = sectionObj.rows[safe: indexPath.row] {
            cell.loadData(record: record, isMinVolOfMobileData: record.volumeOfMobileData == sectionObj.minVolOfMobileData)
        }
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 64.0)
    }
}


