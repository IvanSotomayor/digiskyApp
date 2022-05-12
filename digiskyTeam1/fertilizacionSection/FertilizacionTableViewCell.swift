//
//  FertilizacionTableViewCell.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit

class FertilizacionTableViewCell: UITableViewCell {
    
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
    
    func update(with fertilizacion: Fertilizacion) {
        nombre.text = fertilizacion.personaACargo
        fecha.text = fertilizacion.fechaFertilizacion
    }

}
