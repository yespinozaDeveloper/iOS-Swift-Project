//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class HistoryViewController: AppBaseController {
    
    
    @IBOutlet weak var tableViewHistory: UITableView!
    var medicalHistory:[MedicalHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMedicalHistory()
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    
    func getMedicalHistory(){
        print("UI => [Fetch History]")
        showLoader()
        MedicalRepository.getHistory(getCurrentUser().UserName, _protocol: self)
        
    }
    
    
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        medicalHistory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        let item:MedicalHistory = self.medicalHistory[indexPath.row]
        cell.lblDate.text = item.Date
        cell.txtDescription.text = item.Detail
        
        return cell
    }
    
    func refreshData(){
        print("UI => [Refresh Data]")
        tableViewHistory.reloadData()
    }
}

extension HistoryViewController : MedicalProtocol{
    func onSuccess(_ data: [MedicalHistory]) {
        print("UI => [Fetch History] => SUCCESS")
        medicalHistory = data
        dismissLoader { self.refreshData() }
    }
    
    func onError() {
        print("UI => [Fetch History] => ERROR")
        dismissLoader { self.showDefaultError() }
    }
}
