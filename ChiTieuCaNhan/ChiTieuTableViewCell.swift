//
//  ChiTIeuTableViewCell.swift
//  Quản Lý Chi Tiêu
//
//  Created by Phạm Quý Thịnh on 29/12/2023.
//

import UIKit

class ChiTieuTableViewCell: UITableViewCell {
    @IBOutlet var dateLB: UILabel!
    @IBOutlet var moneyLB: UILabel!
    @IBOutlet var propertyLB: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with chitieu : ChiTieu){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLB.text = dateFormatter.string(from: chitieu.date)
        moneyLB.text = chitieu.money
        propertyLB.text = chitieu.property
        if(propertyLB.text == "-"){
            propertyLB.textColor = UIColor.red
        }
        else{
            propertyLB.textColor = UIColor.systemBlue

        }

    }

}
