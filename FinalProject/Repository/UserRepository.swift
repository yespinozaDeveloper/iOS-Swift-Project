//
//  UserRepository.swift
//  FinalProject
//
//  Created by yespinoza on 8/14/20.
//

import Foundation

class UserRepository{
    
    
    static func login(_ userName:String?, password:String?, userProtocol:LoginProtocol){
        CacheDataUtil.initUser(userName)
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"password":password as AnyObject]
        let action:String = NetworkEndpoint.User_Login
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<User>? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        userProtocol.onError()
                                                        return
                                                    }
                                                    
                                                    if let user:User = responseObject.data {
                                                        userProtocol.onSuccess(user)
                                                    }else{
                                                        userProtocol.onError()
                                                    }
                                                }catch{
                                                    userProtocol.onError()
                                                }
        }, onFailure: { (NSError) in
            userProtocol.onError()
        })
    }
    
    
    static func create(_ userName:String?, password:String?, email:String?, userProtocol:UserProtocol){
        
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"password":password as AnyObject,"email":email as AnyObject]
        let action:String = NetworkEndpoint.User_Create
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseResponse? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        userProtocol.onError()
                                                        return
                                                    }
                                                    
                                                    userProtocol.onSuccess(nil)
                                                }catch{
                                                    userProtocol.onError()
                                                }
        }, onFailure: { (NSError) in
            userProtocol.onError()
        })
    }
    
    static func update(_ user:User, hasImageChanged:Bool, userProtocol:UserProtocol){
        
        let parameters:[String:AnyObject] = user.getParameters(hasImageChanged)
        let action:String = NetworkEndpoint.User_Update
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseDataResponse<User>? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        userProtocol.onError()
                                                        return
                                                    }
                                                    
                                                    if let user:User = responseObject.data {
                                                        userProtocol.onSuccess(user)
                                                    }else{
                                                        userProtocol.onError()
                                                    }
                                                }catch{
                                                    userProtocol.onError()
                                                }
        }, onFailure: { (NSError) in
            userProtocol.onError()
        })
    }
    
    static func changePassword(_ userName:String?, currentPassword:String?, newPassword:String?, userProtocol:UserProtocol){
        
        let parameters:[String:AnyObject] = ["user":userName as AnyObject,"currentPassword":currentPassword as AnyObject,"newPassword":newPassword as AnyObject]
        let action:String = NetworkEndpoint.User_ChangePassword
        
        NetworkHelper.getInstance().request(action: action, type: .post, param:parameters,
                                            onSuccess: { (response) in
                                                
                                                do{
                                                    let responseDecoded:BaseResponse? = JSonUtil.decodeResponse(response.stringValue, action: action)
                                                    guard let responseObject = responseDecoded, responseObject.isSuccessful else {
                                                        userProtocol.onError()
                                                        return
                                                    }
                                                    
                                                    userProtocol.onSuccess(nil)
                                                }catch{
                                                    userProtocol.onError()
                                                }
        }, onFailure: { (NSError) in
            userProtocol.onError()
        })
    }
}
