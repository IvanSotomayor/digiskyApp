//
//  Siembra.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 04/05/22.
//

import Foundation

struct Siembra : Codable {
    let pesonaACargo : String
    let cantidadSemillas : String
    let marca : String
    let tipoSemilla : String
    let fechaSiembra : String
    let documentID : String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("siembras").appendingPathExtension("plist")
    
    static func loadFromFile() -> [Siembra]?  {
        guard let codedSiembras = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Siembra>.self, from: codedSiembras)
    }
    
    /*
    static func loadSampleSiembras() -> [Siembra] {
         let currentDateTime = Date()
         return [
            Siembra(pesonaACargo: "Ivan", cantidadSemillas: "100", marca: "marca", tipoSemilla: "tipo semilla", documentID: "exampleID")
         ]
     }
     */
    
    static func saveToFile(siembras: [Siembra]) {
        let encoder = PropertyListEncoder()
        let codedSiembras = try? encoder.encode(siembras)
        try? codedSiembras?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    
}
