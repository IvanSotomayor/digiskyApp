//
//  BusquedaViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit
import Firebase

class BusquedaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var firstDate: UIDatePicker!
    @IBOutlet weak var secondDate: UIDatePicker!
    @IBOutlet weak var optionSelected: UISegmentedControl!
    
    @IBOutlet weak var infoTableView: UITableView! {
        didSet{
            infoTableView.dataSource = self
        }
    }
    
    let databaseRef = Firestore.firestore()
    
    var siembras = [Siembra] ()
    var riegos = [Riego] ()
    var fertilizaciones = [Fertilizacion] ()
    var indexPathButton: IndexPath?
    
    var dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTableView.rowHeight = UITableView.automaticDimension
        infoTableView.estimatedRowHeight = 44.0
        
    }
    
    
    @IBAction func exportarPressed(_ sender: Any) {
        
        if optionSelected.selectedSegmentIndex == 0{
            riegos = [Riego] ()
            siembras = [Siembra] ()
            fertilizaciones = [Fertilizacion] ()
            infoTableView.reloadData()
            databaseRef.collection("irrigation").getDocuments() { [self] (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: (err)")
               } else {
                   let first = dateFormatter.string(from: firstDate.date)
                   let second = dateFormatter.string(from: secondDate.date)
                   for document in querySnapshot!.documents {
                       let datos = document.data()
                       
                       let fechaString = dateFormatter.date(from: datos["date"] as! String)
                       let fechaDate = dateFormatter.string(from: fechaString ?? Date())
                       
                       if fechaDate >= first && fechaDate <= second {
                           if let manager = datos["manager"] as? String, let hectares = datos["hectares"] as? String, let date = datos["date"] as? String, let type = datos["type"] as? String {
                               let riego = Riego(personaACargo: manager, tipoAgua: type, litrosDeAgua: hectares, fechaRiego: date, documentID: document.documentID)
                               self.riegos.append(riego)
                                   let indexPath = IndexPath(row: self.riegos.count - 1, section: 0)
                                   self.infoTableView.insertRows(at: [indexPath], with: .automatic)

                           }
                       }
                   }
               }
           } // Fin de getDocuments
        } // Fin de primer IF
        
        if optionSelected.selectedSegmentIndex == 1{
            riegos = [Riego] ()
            siembras = [Siembra] ()
            fertilizaciones = [Fertilizacion] ()
            infoTableView.reloadData()
            databaseRef.collection("cultivate").getDocuments() { [self] (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: (err)")
               } else {
                   let first = dateFormatter.string(from: firstDate.date)
                   let second = dateFormatter.string(from: secondDate.date)
                   for document in querySnapshot!.documents {
                       let datos = document.data()
                       
                       let fechaString = dateFormatter.date(from: datos["date"] as! String)
                       let fechaDate = dateFormatter.string(from: fechaString ?? Date())
                       
                       if fechaDate >= first && fechaDate <= second {
                           if let manager = datos["manager"] as? String, let cantidadSemillas = datos["quantity"] as? String, let marca = datos["brand"] as? String, let type = datos["type"] as? String, let date = datos["date"]  {
                               let siembra = Siembra(pesonaACargo: manager, cantidadSemillas: cantidadSemillas, marca: marca, tipoSemilla: type, fechaSiembra: date as! String, documentID: document.documentID)
                               self.siembras.append(siembra)
                                   let indexPath = IndexPath(row: self.siembras.count - 1, section: 0)
                                   self.infoTableView.insertRows(at: [indexPath], with: .automatic)
                           }
                       }
                   }
               }
           } // Fin de getDocuments
        }
        
        if optionSelected.selectedSegmentIndex == 2{
            riegos = [Riego] ()
            siembras = [Siembra] ()
            fertilizaciones = [Fertilizacion] ()
            infoTableView.reloadData()
            databaseRef.collection("fertilization").getDocuments() { [self] (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: (err)")
               } else {
                   let first = dateFormatter.string(from: firstDate.date)
                   let second = dateFormatter.string(from: secondDate.date)
                   for document in querySnapshot!.documents {
                       let datos = document.data()
                       
                       let fechaString = dateFormatter.date(from: datos["date"] as! String)
                       let fechaDate = dateFormatter.string(from: fechaString ?? Date())
                       
                       if fechaDate >= first && fechaDate <= second{
                           if let manager = datos["manager"] as? String, let tipoFertilizante = datos["type"] as? String, let cantidadFertilizante = datos["quantity"] as? String, let date = datos["date"]  {
                               
                               let fertilizacion = Fertilizacion(personaACargo: manager, tipoFertilizante: tipoFertilizante, cantidadFertilizante: cantidadFertilizante, fechaFertilizacion: date as! String, documentID: document.documentID)
                               self.fertilizaciones.append(fertilizacion)
                               let indexPath = IndexPath(row: self.fertilizaciones.count - 1, section: 0)
                               self.infoTableView.insertRows(at: [indexPath], with: .automatic)
                           }
                       }
                   }
               }
           } // Fin de getDocuments
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if optionSelected.selectedSegmentIndex == 0{
            return riegos.count
        }
        
        if optionSelected.selectedSegmentIndex == 1{
            return siembras.count
        }
        
        if optionSelected.selectedSegmentIndex == 2{
            return fertilizaciones.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if optionSelected.selectedSegmentIndex == 0{
            let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            let riego = riegos[indexPath.row]
            cell.update(with: riego)
            cell.showsReorderControl = true
                    
            return cell
        }
        
        if optionSelected.selectedSegmentIndex == 1{
            let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            let siembra = siembras[indexPath.row]
            cell.update2(with: siembra)
            cell.showsReorderControl = true
                    
            return cell
        }
        
        if optionSelected.selectedSegmentIndex == 2{
            let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            
            let fertilizacion = fertilizaciones[indexPath.row]
            cell.update3(with: fertilizacion)
            cell.showsReorderControl = true
                    
            return cell
        }
        
        return infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
    }
    
    func numberOfSections(in infoTableView: UITableView) -> Int {
        return 1
    }
    
    func buttonTapped(_ sender:AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: infoTableView)
        indexPathButton = infoTableView.indexPathForRow(at: buttonPosition)
    }
    
    @IBAction func verRegistro(_ sender: UIButton) {
        buttonTapped(sender.self)
        if optionSelected.selectedSegmentIndex == 0{
            self.performSegue(withIdentifier: "infoRiego", sender: self)
        }
        
        if optionSelected.selectedSegmentIndex == 1{
            self.performSegue(withIdentifier: "infoSiembra", sender: self)
        }
        
        if optionSelected.selectedSegmentIndex == 2{
            self.performSegue(withIdentifier: "infoFertilizacion", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if optionSelected.selectedSegmentIndex == 0 && segue.identifier == "infoRiego" {
            //let indexPath = infoTableView.indexPathForSelectedRow!
            let riego = riegos[indexPathButton?.row ?? 0]
            let navController = segue.destination as! UINavigationController
            let infoRiegoTableViewController = navController.topViewController as! InfoRiegoTableViewController
            
            infoRiegoTableViewController.riego = riego
        }
        
        if optionSelected.selectedSegmentIndex == 1 && segue.identifier == "infoSiembra" {
            //let indexPath = infoTableView.indexPathForSelectedRow!
            let siembra = siembras[indexPathButton?.row ?? 0]
            let navController = segue.destination as! UINavigationController
            let infoSiembraTableViewController = navController.topViewController as! InfoSiembraTableViewController
            
            infoSiembraTableViewController.siembra = siembra
        }
        
        if optionSelected.selectedSegmentIndex == 2 && segue.identifier == "infoFertilizacion" {
            let fertilizacion = fertilizaciones[indexPathButton?.row ?? 0]
            let navController = segue.destination as! UINavigationController
            let infoFertilizacionTableViewController = navController.topViewController as! InfoFertilizacionTableViewController
            
            infoFertilizacionTableViewController.fertilizacion = fertilizacion
        }
    }
    

}
