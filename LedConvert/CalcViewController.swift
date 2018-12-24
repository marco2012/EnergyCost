//
//  CalcViewController.swift
//  LedConvert
//
//  Created by Marco on 15/09/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import Eureka

class CalcViewController: FormViewController {
    
    var costo_corrente:Double!
    var potenza:Double!
    var ore_utilizzo:Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let watt_hours = potenza * ore_utilizzo
        let kWh = (watt_hours / 1000)
        let kWh_month = (kWh * 30)
        let kWh_year = (kWh * 365)
        let cost_month = kWh_month * costo_corrente
        let cost_year = kWh_year * costo_corrente

        form +++ Section("Costo")
            
            <<< LabelRow () {
                $0.title = "Costo annuale"
                $0.value = "€ " + String(format: "%.2f", cost_year)
            }
            
            <<< LabelRow () {
                $0.title = "Costo mensile"
                $0.value = "€ " + String(format: "%.2f", cost_month)
            }
            
        +++ Section("Consumo")
        
            <<< LabelRow () {
                $0.title = "Consumo annuale"
                $0.value = String(format: "%.2f", kWh_year) + " kWh"
        }
        
            <<< LabelRow () {
                $0.title = "Consumo mensile"
                $0.value = String(format: "%.2f", kWh_month) + " kWh"
        }
        
    }

}
