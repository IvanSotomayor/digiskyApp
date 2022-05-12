//
//  SiembraTableViewCell.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 04/05/22.
//

import UIKit

class SiembraTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    var dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func update(with siembra: Siembra) {
        nombre.text = siembra.pesonaACargo
        fecha.text = siembra.fechaSiembra
    }
    
    

}
