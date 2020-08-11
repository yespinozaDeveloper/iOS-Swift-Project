//
//  HistoryCell.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10
//


import UIKit


class HistoryCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
