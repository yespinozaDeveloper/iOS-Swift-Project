//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class HistoryViewController: AppBaseController {
    
    @IBOutlet weak var tableViewHistory: UITableView!
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        //TODO - Call service
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        let date = Date()
        let dateEdited = Calendar.current.date(byAdding: .day, value: -indexPath.row, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = ConstantUtil.HistoryDateFormat

        if let dateEdited = dateEdited{
            cell.lblDate.text = formatter.string(from: dateEdited)
            cell.txtDescription.text = ConstantUtil.defaultDescription
        }
        
        return cell
    }
    
    
}
