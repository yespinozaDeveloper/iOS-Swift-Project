//
//  MaintenanceViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/12
//

import UIKit

class MaintenanceViewController: AppBaseController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var actionBtnLocation: UIButton!
    @IBOutlet weak var txtReason: UITextView!
    var SelectedAppointment:Appointment?
    
    override func viewDidLoad() {
        if let appointment = SelectedAppointment{
            datePicker.date = appointment.AppointmentDate
            txtReason.text = appointment.Reason
            actionBtnLocation.setTitle(appointment.Place, for: .normal)
            if appointment.AppointmentDate < Date.init()
            {
                datePicker.minimumDate = appointment.AppointmentDate
            }else{
                datePicker.minimumDate = Date.init()
            }
        
        }else{
            datePicker.minimumDate = Date.init()
        }
    }
    
    @IBAction func actionBtnSave(_ sender: Any) {
        showLoader()
        //TODO - Call service
        dismissLoader({self.showInfoAlert(ConstantUtil.SuccessAppointmentSave)})
        dismiss(animated: true)
    }
    @IBAction func actionBtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
