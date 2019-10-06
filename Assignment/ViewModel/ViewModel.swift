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
            } else {
                callBack(nil, error)
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

