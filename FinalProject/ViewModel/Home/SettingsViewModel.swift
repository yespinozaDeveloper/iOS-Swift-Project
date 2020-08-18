//
//  SettingsViewModel.swift
//  FinalProject
//
//  Created by yespinoza on 8/18/20.
//

import Foundation
import UIKit

struct SettingsViewModel{
    
    func UpdateUserValidate(_ email:String?, imageHasChanged:Bool, image:UIImage?, _protocol:SettingsProtocol){
        
     let validation = updateUserValidation(email, imageHasChanged:imageHasChanged, image: image)
        
        if validation.isSuccessful {
            CacheDataUtil.UserCache = AppBaseController.getCurrentUser()
            CacheDataUtil.UserCache.Email = email!
            
            if imageHasChanged {
                CacheDataUtil.UserCache.setUImage(image: image)
            }
            _protocol.UpdateUser(CacheDataUtil.UserCache, imageHasChanged: imageHasChanged)
         //_protocol.SaveUser(userName!, email:email!, password:password!)
        }
        else{
            _protocol.onError(validation.title, message: validation.message)
        }
    }
    
    func UpdateUserApply(_ user:User, imageHasChanged:Bool, _protocol:SettingsProtocol){
        UserRepository.update(user, hasImageChanged: imageHasChanged, _protocol: _protocol)
    }
    
    func updateUserValidation(_ email:String?, imageHasChanged:Bool, image:UIImage?) -> ViewModelValidation{
        var title:String?
        var message:String = ""
        
       if email == nil || email == ""
       {
           message = ConstantUtil.EmailRequiredMessage
       }
       else if !ValidateUtil.isValidEmail(email!){
           title = ConstantUtil.WrongEmailTittle
           message = ConstantUtil.WrongEmailMessage
       }
       else if imageHasChanged && image == nil{
           title = ConstantUtil.ErrorDefaultTitle
           message = ConstantUtil.ImageRequiredMessage
       }
       else if !imageHasChanged && email == AppBaseController.getCurrentUser().Email {
           title = ConstantUtil.NoChangesTittle
           message = ConstantUtil.NoChangesMessage
       }
        
        return ViewModelValidation.init(isSuccessful: message == "", title: title, message: message)
    }
}
