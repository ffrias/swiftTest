//
//  APIClient.swift
//  swiftTest
//
//  Created by Federico Frias on 8/25/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient{
    var url: String!

    
    init(url:String){
        self.url = url
    }
    
    func getData(completion:(result:JSON)->Void){

        var urlNew = NSURL(string: self.url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        Alamofire.request(.GET, urlNew!)
            .responseJSON { (request, response, data, error) in
                let json = JSON(data!)
                completion(result: json)
        }
    }
}