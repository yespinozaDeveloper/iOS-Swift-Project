//
//  MessageUtil.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import Foundation

class ConstantUtil{
    
    static let AppSuccessCode = "00"
    static let LocationList = ["San José", "Alajuela", "Heredia", "Cartago", "Puntarenas", "Guanacaste", "Limón"]
    
    static let HistoryDateFormat:String = "yyyy/MM/dd"
    
    static let AcceptOption:String = "Accept"
    static let CancelOption:String = "Cancel"
    static let LogoutOption:String = "Logout"
    static let ChangeOption:String = "Change"
    static let GalleryOption:String = "Gallery"
    static let CameraOption:String = "Camera"
    static let DeleteOption:String = "Delete"
    
    static let UserRequiredMessage:String = "User is required."
    static let EmailRequiredMessage:String = "Email is required."
    static let PasswordRequiredMessage:String = "Password is required."
    static let CurrentPasswordRequiredMessage:String = "Current password is required."
    static let NewPasswordRequiredMessage:String = "New password is required."
    static let ConfirmPasswordRequiredMessage:String = "Confirm password is required."
    static let LocationRequiredMessage:String = "Location is required. Please select a location and try again."
    static let ReasonRequiredMessage:String = "Reason is required. Please type your appointment reason and try again."
    static let ImageRequiredMessage:String = "Profile image is required. Please select an image and try again."
    
    static let RememberPasswordConfirmationMessage:String = "Would you like to also remeber you password?"
    static let LogoutConfirmationMessage:String = "Are you sure you want to logout?"
    static let ChangePasswordConfirmationMessage:String = "Are you sure you want to change your password?"
    static let DeleteAppointmentConfirmationMessage:String = "Are you sure you want to delete this appointment?"
    
    static let LoaderMessage:String = "Please wait..."
    static let DeleteAppointmentTittle:String = "Delete Appointment"
    static let PasswordNotMatchTittle:String = "Password isn't matching"
    static let PasswordNotMatchMessage:String = "Please check your confirm password and try again."
    static let SamePasswordTittle:String = "Same password"
    static let SamePasswordMessage:String = "New password must be different than current password. Please check them and try again."
    static let WrongEmailTittle:String = "Wrong email address"
    static let WrongEmailMessage:String = "Wrong email address"
    static let NoChangesTittle:String = "Any change was detected"
    static let NoChangesMessage:String = "Please type your new email or choose your new image and try again."
    static let UploadImageTittle:String = "Upload Image"
    static let UploadImageMessage:String = "Choose image location"
    static let CameraUnavailableTittle:String = "Camera isn't available"
    static let CameraUnavailableMessage:String = "Please check your device camera and try again."
    static let CameraForbidPermissonMessage:String = "Camera permisson was denied. If you want to use this feature, please go to settings and turn it on"
    
    static let SuccessUserCreate:String = "User has been created successful!"
    static let SuccessUserUpdate:String = "User has been updated successful!"
    static let SuccessPasswordChange:String = "Password has been changed successful!"
    static let SuccessAppointmentDelete:String = "Appointment has been deleted successful!"
    static let SuccessAppointmentSave:String = "Appointment has been save successful!"
    
    static let ErrorDefaultTitle = "Attention"
    static let ErrorDefaultMessage = "An error has ocurred, please try again."
    static let DuplicityAppointmentError = "You already have an appointment for date selected."
    static let NotFoundAppointmentError = "Appointment not found. Please try again."
    
    static let defaultDescription:String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley"
    static let defaultImage:String = "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"

}
