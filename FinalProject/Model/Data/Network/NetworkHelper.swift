//
//  NetworkUtil.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/14.
//

import Alamofire
import SwiftyJSON

struct NetworkHelper {
    public typealias Parameters = [String: AnyObject]

    static var instance:NetworkHelper!
    let rootAPIURL:String
    
    init(){
        rootAPIURL = NetworkEndpoint.rootAPIURL
    }
    
    static func getInstance()->NetworkHelper{
        if instance == nil
        {
            instance = NetworkHelper.init()
        }
        return instance
    }

    func request(action:String, type: HTTPMethod,  onSuccess:@escaping (JSON) -> Void, onFailure:@escaping (NSError?) -> Void) {
        
        let URL:String  = "\(self.rootAPIURL)\(action)"
        print("<===============================>\n")
        print("REQUEST URL: \n\(URL)\n")
        print("<===============================>\n")
        print("PARAMETERS: \nNONE\n")
        AF.request(URL, method: type).responseJSON
            {
                response in
                    
                    do{
                        guard case .failure(_) = response.result else {
                        if let result = response.value {
                            let responseJSON = JSON(result)
                            print("<===============================>\n")
                            print("RESPONSE: \n\(responseJSON)\n")
                            onSuccess(responseJSON)
                               } else {
                                   print("<===============================>\n")
                                   print("RESPONSE: NULL\n")
                            onFailure(nil)
                               }
                        return
                    }
                    print("<===============================>\n")
                    print("Unexpected error...")
                    onFailure(nil)
                }
            catch {
                print("<===============================>\n")
                print("Unexpected error: \(error).")
                onFailure(nil)
            }
        }
    }

    func request(action:String, type: HTTPMethod, param:Parameters,  onSuccess:@escaping (JSON) -> Void, onFailure:@escaping (NSError?) -> Void) {
        
        let URL:String  = "\(self.rootAPIURL)\(action)"
        print("<===============================>\n")
        print("REQUEST URL: \n\(URL)\n")
        print("<===============================>\n")
        print("PARAMETERS: \n\(param)\n")
        AF.request(URL, method: type, parameters: param).responseJSON
            {
                response in
                    
                    do{
                        guard case .failure(_) = response.result else {
                        if let result = response.value {
                            let responseJSON = JSON(result)
                            print("<===============================>\n")
                            print("RESPONSE: \n\(responseJSON)\n")
                            onSuccess(responseJSON)
                               } else {
                                   print("<===============================>\n")
                                   print("RESPONSE: NULL\n")
                            onFailure(nil)
                               }
                        return
                    }
                    print("<===============================>\n")
                    print("Unexpected error...")
                    onFailure(nil)
                }
            catch {
                print("<===============================>\n")
                print("Unexpected error: \(error).")
                onFailure(nil)
            }
        }
    }
}
