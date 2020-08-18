//
//  CreateUserViewModel.swift
//  FinalProject
//
//  Created by yespinoza on 8/18/20.
//

import Foundation

struct CreateUserViewModel{
    
       func CreateUserValidate(_ userName:String?, email:String?, password:String?, confirmPassword:String?, _protocol:UserProtocol){
           
        let validation = createUserValidation(userName, email:email, password: password, confirmPassword: confirmPassword)
           
           if validation.isSuccessful {
            _protocol.SaveUser(userName!, email:email!, password:password!)
           }
           else{
               _protocol.onError(validation.title, message: validation.message)
           }
       }
       
       func CreateUserApply(_ userName:String, email:String, password:String, _protocol:UserProtocol){
           UserRepository.create(userName, password:password, email:email, _protocol:_protocol)
       }
       
       func createUserValidation(_ userName:String?, email:String?, password:String?, confirmPassword:String?) -> ViewModelValidation{
           var title:String?
           var message:String = ""
        
          if userName == nil || userName == ""
           {
               message = ConstantUtil.UserRequiredMessage
           }
           else if email == nil || email == ""
           {
               message = ConstantUtil.EmailRequiredMessage
           }
           else if password == nil || password == ""
           {
               message = ConstantUtil.PasswordRequiredMessage              
           }
           else if confirmPassword == nil || confirmPassword == ""
           {
               message = ConstantUtil.ConfirmPasswordRequiredMessage
              
           }
           else if password != confirmPassword {
               title = ConstantUtil.PasswordNotMatchTittle
               message = ConstantUtil.PasswordNotMatchMessage
           }
           else if !ValidateUtil.isValidEmail(email!){
               title = ConstantUtil.WrongEmailTittle
               message = ConstantUtil.WrongEmailMessage
           }
           
           return ViewModelValidation.init(isSuccessful: message == "", title: title, message: message)
       }
}
