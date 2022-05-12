//
//  Fertilizacion.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import Foundation

struct Fertilizacion : Codable {
    let personaACargo : String
    let tipoFertilizante : String
    let cantidadFertilizante : String
    let fechaFertilizacion : String
    let documentID : String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("fetilizantes").appendingPathExtension("plist")
    
    static func loadFromFile() -> [Fertilizacion]?  {
        guard let codedFertilizaciones = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Fertilizacion>.self, from: codedFertilizaciones)
    }
    
    static func saveToFile(fertilizaciones: [Fertilizacion]) {
        let encoder = PropertyListEncoder()
        let codedFertilizaciones = try? encoder.encode(fertilizaciones)
        try? codedFertilizaciones?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
}

