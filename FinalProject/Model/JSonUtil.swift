//
//  JSonUtil.swift
//  FinalProject
//
//  Created by yespinoza on 8/14/20.
//

import Foundation

class JSonUtil{
    
    static func decode<D: Codable>(_ json:String) -> D? {
        do{
            let jsonData = json.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(D.self, from: jsonData)
        }catch{
            return nil
        }
    }
    
    static func decodeResponse<D: Codable>(_ json:String, action:String) -> D? {
        do{
            var jsonResponse:String = json
            if DummyUtil.IsDummyEnabled{
                print("###DUMMY ENABLED###")
                jsonResponse = DummyUtil.getDummyResponse(action)
            }
            let jsonData = jsonResponse.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(D.self, from: jsonData)
        }catch{
            return nil
        }
    }
}
