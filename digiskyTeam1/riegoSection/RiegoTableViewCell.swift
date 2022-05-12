//
//  RiegoTableViewCell.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 02/05/22.
//

import UIKit

class RiegoTableViewCell: UITableViewCell {
    
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
    
    func update(with riego: Riego) {
        nombre.text = riego.personaACargo
        fecha.text = riego.fechaRiego
    }


}
