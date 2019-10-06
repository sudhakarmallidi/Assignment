//
//  DataModel.swift
//  Assignment
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//
//

import Foundation

// MARK: - Welcome
struct ResponseDataModel: Codable, Equatable {
    let help: String?
    let success: Bool?
    let result: DataResult?
}

// MARK: - Result
struct DataResult: Codable, Equatable {
    let resourceID: String?
    let fields: [Field]?
    let records: [Record]?
    let links: Links?
    let limit, total: Int?
}

// MARK: - Field
struct Field: Codable, Equatable {
    let type, id: String?
}

// MARK: - Links
struct Links: Codable, Equatable {
    let start, next: String?
}

// MARK: - Record
struct Record: Codable, Equatable,Comparable {
    static func < (lhs: Record, rhs: Record) -> Bool {
        if let volumeOfMobileData1 = lhs.volumeOfMobileData,
            let value1 = Double(volumeOfMobileData1),
            let volumeOfMobileData2 = rhs.volumeOfMobileData,
            let value2 = Double(volumeOfMobileData2)
        {
            return value1 < value2
        }
        return false
    }
    
    let volumeOfMobileData : String?
    let quarter : String?
    let id : Int?
    enum CodingKeys: String, CodingKey {
        case volumeOfMobileData = "volume_of_mobile_data"
        case quarter = "quarter"
        case id = "_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        volumeOfMobileData = try values.decodeIfPresent(String.self, forKey: .volumeOfMobileData)
        quarter = try values.decodeIfPresent(String.self, forKey: .quarter)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
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
