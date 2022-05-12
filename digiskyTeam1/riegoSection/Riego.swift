//
//  Riego.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 02/05/22.
//

import Foundation

struct Riego : Codable {
    let personaACargo : String
    let tipoAgua : String
    let litrosDeAgua : String
    let fechaRiego : String
    let documentID: String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("riegos").appendingPathExtension("plist")
    
    static func loadFromFile() -> [Riego]?  {
        guard let codedRiegos = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Riego>.self, from: codedRiegos)
    }
    
   /* static func loadSampleRiegos() -> [Riego] {
        let currentDateTime = Date()
        return [
            Riego(personaACargo: "Ivan", tipoAgua: "Agua de Noria", litrosDeAgua: 1000, fechaRiego: currentDateTime)
        ]
    } */
    
    static func saveToFile(riegos: [Riego]) {
        let encoder = PropertyListEncoder()
        let codedRiegos = try? encoder.encode(riegos)
        try? codedRiegos?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
