//
//  AppointmentRepository.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

class AppointmentRepository{
    
    static func getAll(_ userName:String?, _protocol:AppointmentProtocol){
        
        let parameters:[String:AnyObject] = ["userName":userName as AnyObject]
        let action:String = NetworkEndpoint.Appointment_GeAll
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<[Appointment]>? = JSonUtil.decodeResponse(response.stringValue, action: action)
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
    
    static func delete(_ userName:String?, appointmentDate:String, _protocol:AppointmentProtocol){
        
        let parameters:[String:AnyObject] = ["userName":userName as AnyObject, "appointment":appointmentDate as AnyObject]
        let action:String = NetworkEndpoint.Appointment_Delete
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseResponse? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError()
                                                        return
                                                    }
                                                    
                                                    _protocol.onSuccess()
                                                }catch{
                                                    _protocol.onError()
                                                }
        }, onFailure: { (NSError) in
            _protocol.onError()
        })
    }
}
