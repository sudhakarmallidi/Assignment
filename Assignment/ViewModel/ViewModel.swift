//
//  ViewModel.swift
//  Assignment
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    var responseDataModel: ResponseDataModel?
    var dataArray: [Section] = []
    func getMobileDataUsageData(offset: Int, callBack: @escaping GetDataCallBack) {
        ServiceManager.getData(offset: 0) { (responseDataModel, error) in
            if let _ = responseDataModel {
                self.responseDataModel = responseDataModel
                self.dataArray = self.getDataArray(responseDataModel: responseDataModel)
                callBack(responseDataModel, error)
            }
        }
    }
    func getDataArray(responseDataModel: ResponseDataModel?) -> [Section] {
        var dataArray: [Section] = []
        if let resDataModel = responseDataModel {
            let array = resDataModel.result?.records ?? [Record]()
            let filteredYears = array.map{$0.quarter!.components(separatedBy: "-").first!}
            let sortedYears = Array(Set(filteredYears)).sorted(by: {$0<$1})
            print(sortedYears)
            sortedYears.forEach { year in
                //let records = array.prefix(while: { $0.quarter!.contains(year) })
                let records = array.filter {$0.quarter!.contains(year)}
                let sortedRecords = records.sorted { $0.quarter! < $1.quarter! }
                let sectionObj = Section(records: sortedRecords, yearObj: year)
                dataArray.append(sectionObj)
            }
        }
        return dataArray
    }
    func getNumberOfSections() -> Int {
        return self.dataArray.count
    }
    func getNumberOfItems(sectionIndex: Int) -> Int {
        return self.dataArray[sectionIndex].rows.count
    }
}
struct Section: Sequence, IteratorProtocol {
    var year: String = ""
    var rows: [Record] = []
    var currentIndex = 0
    var totalVolumeOfData: Double {
        return self.rows.map({Double($0.volumeOfMobileData ?? "0") ?? 0}).reduce(0, +)
    }
    var minVolOfMobileData: String {
        return rows.min()?.volumeOfMobileData ?? ""
    }

    init(records: [Record], yearObj: String) {
        self.year = yearObj
        self.rows = records
    }
    mutating func next() -> Record? {
        defer {
            print("pre: \(currentIndex)")
            currentIndex = currentIndex + 1
            print("post: \(currentIndex)")
        }
        return rows[safe: currentIndex]
    }
}
