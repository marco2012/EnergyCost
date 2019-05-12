//
//  ViewController.swift
//  LedConvert
//
//  Created by Marco on 15/09/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//  https://www.saveonenergy.com/energy-consumption/

import Eureka

class ViewController: FormViewController {
    
    let defaults = UserDefaults.standard

    var potenza:Double?
    var ore_utilizzo:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            
            <<< IntRow() {
                $0.title = "Potenza dispositivo"
                $0.placeholder = "W"
                $0.tag = "potenza"
                
                let formatter = DecimalFormatter()
                formatter.locale = .current
                formatter.positiveSuffix = "W"
                $0.formatter = formatter
                }.onCellHighlightChanged { cell, row in
                    if row.isHighlighted {
                        let position = cell.textField.position(from: cell.textField.endOfDocument, offset: 0)!
                        cell.textField.selectedTextRange = cell.textField.textRange(from: position, to: position)
                    }
                }
            
            <<< DecimalRow() {
                $0.title = "Ore utilizzo giornaliero"
                $0.tag = "ore_utilizzo"
                let formatter = DecimalFormatter()
                formatter.locale = .current
                formatter.positiveSuffix = "h"
                $0.formatter = formatter
                }.onCellHighlightChanged { cell, row in
                    if row.isHighlighted {
                        let position = cell.textField.position(from: cell.textField.endOfDocument, offset: 0)!
                        cell.textField.selectedTextRange = cell.textField.textRange(from: position, to: position)
                    }
        }
        
        form +++ Section()
            
            <<< DecimalRow() {
                $0.title = "Costo elettricità"
                $0.placeholder = "€/kWh"
                $0.tag = "costo_corrente"
                $0.value = defaults.double(forKey: "costo_corrente")
                let formatter = DecimalFormatter()
                formatter.locale = .current
                formatter.positiveSuffix = "€/kWh"
                $0.formatter = formatter
                }.onCellHighlightChanged { cell, row in
                    if row.isHighlighted {
                        let position = cell.textField.position(from: cell.textField.endOfDocument, offset: 0)!
                        cell.textField.selectedTextRange = cell.textField.textRange(from: position, to: position)
                    }
            }
        
        
        
        form +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Calcola"
                }
                .onCellSelection { [weak self] (cell, row) in
                    
                    let costo_corrente: DecimalRow? = self?.form.rowBy(tag: "costo_corrente")
                    self?.defaults.set(Double((costo_corrente?.value)!), forKey: "costo_corrente")
                    
                    let potenza: IntRow? = self?.form.rowBy(tag: "potenza")

                    let ore_utilizzo: DecimalRow? = self?.form.rowBy(tag: "ore_utilizzo")

                    if costo_corrente?.value==nil || potenza?.value==nil || ore_utilizzo?.value==nil {
                        self?.showAlert(title: "Errore", message: "Compila tutti i campi")
                    } else {
                        self?.potenza           = Double((potenza?.value)!)
                        self?.ore_utilizzo      = Double((ore_utilizzo?.value)!)
                        

                        self?.performSegue(withIdentifier: "calculateSegue", sender: self)
                    }
                    
        }
                
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculateSegue"{
            if let destinationVC = segue.destination as? CalcViewController {
                destinationVC.potenza               = potenza
                destinationVC.costo_corrente        = defaults.double(forKey: "costo_corrente")
                destinationVC.ore_utilizzo          = ore_utilizzo
            }
        }
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
        
    }
    
}
