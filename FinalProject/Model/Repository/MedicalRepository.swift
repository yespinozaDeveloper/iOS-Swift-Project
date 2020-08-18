//
//  MedicalRepository.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

class MedicalRepository{
    
    static func getHistory(_ userName:String?, _protocol:MedicalProtocol){
        
        let parameters:[String:AnyObject] = ["userName":userName as AnyObject]
        let action:String = NetworkEndpoint.Medical_GetHistory
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<[MedicalHistory]>? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError()
                                                        return
                                                    }
                                                    
                                                    if let data = responseObject.data {
                                                        _protocol.onSuccess(data)
                                                    }else{
                                                        _protocol.onError()
                                                    }
                                                }catch{
                                                    _protocol.onError()
                                                }
        }, onFailure: { (NSError) in
            _protocol.onError()
        })
    }
}
