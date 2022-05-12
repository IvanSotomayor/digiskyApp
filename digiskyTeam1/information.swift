//
//  Information.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 29/04/22.
//

import Foundation

struct registro {
    
    struct riego {
        static let collectionName = "irrigation"
        static let personaACargo = "manager"
        static let tipoAgua = "type"
        static let litrosAgua = "hectares"
        static let fecha = "date"
    }
    
    struct siembra {
        static let collectionName = "cultivate"
        static let personaACargo = "manager"
        static let cantidadSemillas = "quantity"
        static let marca = "brand"
        static let tipoSemillas = "type"
        static let fecha = "date"
    }
    
    struct fertilizacion {
        static let collectionName = "fertilization"
        static let personaACargo = "manager"
        static let tipoFertilizante = "type"
        static let cantidadFertilizante = "quantity"
        static let fecha = "date"
    }
}
