//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class SettingsViewController: AppBaseController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    var ImageHasChanged:Bool!
    var IsTakingPhoto:Bool!
    
    override func viewDidAppear(_ animated: Bool) {
        if IsTakingPhoto == nil {
            self.IsTakingPhoto = false
        }
        if  !IsTakingPhoto!{
            lblUserName.text = getCurrentUser().UserName
            txtEmail.text = getCurrentUser().Email
            imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
            ImageHasChanged = false
        }
        IsTakingPhoto = false
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionBtnChangeImage(_ sender: Any) {
        self.showConfirmAlert(ConstantUtil.UploadImageTittle, message: ConstantUtil.UploadImageMessage,
                              acceptButton: ConstantUtil.CameraOption, acceptHandler: {_ in self.openCamera()},
                              cancelButtton: ConstantUtil.GalleryOption, cancelHandler: {_ in self.openGallery()})
    }
    
    @IBAction func actionBtnSave(_ sender: Any) {
        var title:String?
        var message:String = ""
        if txtEmail.text == ""
        {
            message = ConstantUtil.EmailRequiredMessage
        }
        else if !ValidateUtil.isValidEmail(txtEmail.text!){
            title = ConstantUtil.WrongEmailTittle
            message = ConstantUtil.WrongEmailMessage
        }
        else if !ImageHasChanged && txtEmail.text == getCurrentUser().Email {
            title = ConstantUtil.NoChangesTittle
            message = ConstantUtil.NoChangesMessage
        }
        if message != ""
        {
            showInfoAlert(title, message: message)
        }
        else{
            uploadUser()
        }
    }
    
    func openGallery(){
        print("UI => Open Gallery...")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        self.dismissKey()
    }
    
    func openCamera(){
        print("UI => Open Camera...")
        //TODO - Fix camera problem
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            showInfoAlert(ConstantUtil.CameraUnavailableTittle, message: ConstantUtil.CameraUnavailableMessage)
        }
    }
    
    func uploadUser(){
        print("UI => [Update User]")
        showLoader()
        CacheDataUtil.UserCache = self.getCurrentUser()
        if let email =  self.txtEmail.text {
            CacheDataUtil.UserCache.Email = email
        }
        if ImageHasChanged{
            CacheDataUtil.UserCache.setUImage(image: imgProfile.image)
        }
        UserRepository.update(CacheDataUtil.UserCache, hasImageChanged: ImageHasChanged, userProtocol: self)
        
    }
}

extension SettingsViewController: UserProtocol{
    func onSuccess(_ user: User?) {
            print("UI => [Update User] => SUCCESS")
        dismissLoader({
            guard let user = user else{
                self.showDefaultError()
                return
            }
            self.setCurrentUser(user)
            self.showInfoAlert(ConstantUtil.SuccessUserUpdate)
        })
    }
    
    func onError() {
        print("UI => [Update User] => ERROR")
        CacheDataUtil.UserCache = getCurrentUser()
        dismissLoader({self.showDefaultError()})
    }
    
    
}


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        IsTakingPhoto = true
        ImageHasChanged = true
        if let selectedImage:UIImage = info[.editedImage] as? UIImage
        {
            imgProfile.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
