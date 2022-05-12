//
//  FertilizacionTableViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit
import Firebase

class FertilizacionTableViewController: UITableViewController {
    
    @IBOutlet var fertilizationList: UITableView! {
        didSet{
            fertilizationList.dataSource = self
        }
    }
    
    var fertilizaciones = [Fertilizacion] ()
    let databaseRef = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        databaseRef.collection("fertilization").getDocuments() {
            [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err) ")
            } else {
                for document in querySnapshot!.documents {
                    let datos = document.data()
                    
                    if let manager = datos["manager"] as? String, let tipoFertilizante = datos["type"] as? String, let cantidadFertilizante = datos["quantity"] as? String, let date = datos["date"]  {
                        
                        let fertilizacion = Fertilizacion(personaACargo: manager, tipoFertilizante: tipoFertilizante, cantidadFertilizante: cantidadFertilizante, fechaFertilizacion: date as! String, documentID: document.documentID)
                        self.fertilizaciones.append(fertilizacion)
                        let indexPath = IndexPath(row: self.fertilizaciones.count - 1, section: 0)
                        self.fertilizationList.insertRows(at: [indexPath], with: .automatic)
    
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fertilizaciones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fertilizacionCell", for: indexPath) as! FertilizacionTableViewCell
        
        let fertilizacion = fertilizaciones[indexPath.row]
        cell.update(with: fertilizacion)
        cell.showsReorderControl = true
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
    UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                let post = self.fertilizaciones[indexPath.row]
        
                if editingStyle == .delete {
                    fertilizaciones.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    databaseRef.collection("fertilization").document(post.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
    }
    
    @IBAction func unwindFromAddFertilizacion(unwindSegue: UIStoryboardSegue) {
        
        let addFertilizacionTableViewController = unwindSegue.source as! AddEditFertilizacionTableViewController
        if let fertilizacion = addFertilizacionTableViewController.fertilizacion{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                fertilizaciones[selectedIndexPath.row] = fertilizacion
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                tableView.reloadData()
                databaseRef.collection("fertilization").document(fertilizacion.documentID).setData(["manager" : fertilizacion.personaACargo, "type" : fertilizacion.tipoFertilizante, "quantity" : fertilizacion.cantidadFertilizante, "date": fertilizacion.fechaFertilizacion])
                
            } else {
                let newIndexPath = IndexPath(row: fertilizaciones.count, section: 0)
                fertilizaciones.append(fertilizacion)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFertilizacion" {
            let indexPath = tableView.indexPathForSelectedRow!
            let fertilizacion = fertilizaciones[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditFertilizacionTableViewController = navController.topViewController as! AddEditFertilizacionTableViewController
            
            addEditFertilizacionTableViewController.fertilizacion = fertilizacion
            
        }
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }

    
}
