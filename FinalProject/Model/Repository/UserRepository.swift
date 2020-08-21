//
//  UserRepository.swift
//  FinalProject
//
//  Created by yespinoza on 8/14/20.
//

import Foundation

class UserRepository{
    
    
    static func login(_ userName:String?, password:String?, _protocol:LoginProtocol){
        CacheDataUtil.initUser(userName)
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"password":password as AnyObject]
        let action:String = NetworkEndpoint.User_Login
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<User>? = JSonUtil.decodeResponse(response.rawString() ?? "", action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError(responseDecoded?.title, message:responseDecoded?.description)
                                                        return
                                                    }
                                                    
                                                    if let user:User = responseObject.data {
                                                        _protocol.onSuccess(user)
                                                    }else {
                                                        _protocol.onError(responseObject.title, message:responseObject.description)
                                                    }
                                                }catch{
                                                    _protocol.onError()
                                                }
        }, onFailure: { (NSError) in
            _protocol.onError()
        })
    }
    
    
    static func create(_ userName:String?, password:String?, email:String?, _protocol: UserProtocol){
        
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"password":password as AnyObject,"email":email as AnyObject]
        let action:String = NetworkEndpoint.User_Create
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseResponse? = JSonUtil.decodeResponse(response.rawString() ?? "", action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError(responseDecoded?.title, message:responseDecoded?.description)
                                                        return
                                                    }
                                                    
                                                    _protocol.onSuccess(nil)
                                                }catch{
                                                    _protocol.onError()
                                                }
        }, onFailure: { (NSError) in
            _protocol.onError()
        })
    }
    
    static func update(_ user:User, hasImageChanged:Bool, _protocol: SettingsProtocol){
        
        let parameters:[String:AnyObject] = user.getParameters(hasImageChanged)
        let action:String = NetworkEndpoint.User_Update
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<User>? = JSonUtil.decodeResponse(response.rawString() ?? "", action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError(responseDecoded?.title, message:responseDecoded?.description)
                                                        return
                                                    }
                                                    
                                                    if let user:User = responseObject.data {
                                                        _protocol.onSuccess(user)
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
    
    static func changePassword(_ userName:String?, currentPassword:String?, newPassword:String?, _protocol: ChangePasswordProtocol){
        
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"currentPassword":currentPassword as AnyObject,"newPassword":newPassword as AnyObject]
        let action:String = NetworkEndpoint.User_ChangePassword
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseResponse? = JSonUtil.decodeResponse(response.rawString() ?? "", action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        _protocol.onError(responseDecoded?.title, message:responseDecoded?.description)
                                                        return
                                                    }
                                                    
                                                    _protocol.onSuccess(nil)
                                                }catch{
                                                    _protocol.onError()
                                                }
        }, onFailure: { (NSError) in
            _protocol.onError()
        })
    }
}
