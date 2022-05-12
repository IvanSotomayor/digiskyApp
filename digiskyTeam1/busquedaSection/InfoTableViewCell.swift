//
//  InfoTableViewCell.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with riego: Riego) {
        nombre.text = riego.personaACargo
        fecha.text = riego.fechaRiego
    }
    
    func update2(with siembra: Siembra) {
        nombre.text = siembra.pesonaACargo
        fecha.text = siembra.fechaSiembra
    }
    
    func update3(with fertilizacion: Fertilizacion) {
        nombre.text = fertilizacion.personaACargo
        fecha.text = fertilizacion.fechaFertilizacion
    }
    

}
