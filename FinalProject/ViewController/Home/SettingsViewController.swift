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
        print("Gallery...")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        self.dismissKey()
    }
    
    func openCamera(){
        print("Camera...")
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
        /*
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        self.dismissKey()
         */
    }
    
    func uploadUser(){
        showLoader()
        print("Save Email...")
        dismissLoader({
            var currentUser:User = self.getCurrentUser()
            currentUser.Email = self.txtEmail.text!
            if self.ImageHasChanged {
                currentUser.setUImage(image: self.imgProfile.image)
            }
            self.setCurrentUser(currentUser)
            self.showInfoAlert(ConstantUtil.SuccessUserUpdate)
        })
    }
}



extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        IsTakingPhoto = true
        ImageHasChanged = true
        if let selectedImage:UIImage? = info[.editedImage] as? UIImage
        {
            imgProfile.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
