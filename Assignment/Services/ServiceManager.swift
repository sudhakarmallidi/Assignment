//
//  ServiceManager.swift
//  Assignment
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import Foundation

typealias GetDataCallBack = ((ResponseDataModel?, Error?) -> Void)
class ServiceManager {
    static let urlStr: String = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"//&limit=10
    static func getData(offset: Int, callBack: @escaping GetDataCallBack) {
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("Error: \(String(describing: error))")
                callBack(nil, error)
            } else {
                if let jsonData = data {
                    print("httpResponseData: \(String(describing: String(data: jsonData, encoding: .utf8)))")
                    let dataModel = try? JSONDecoder().decode(ResponseDataModel.self, from: jsonData)
                    callBack(dataModel, nil)
                }
            }
        })
        dataTask.resume()
    }
}
