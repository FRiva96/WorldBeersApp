//
//  DetailViewController.swift
//  WorldBeersApp
//
//  Created by Francesco Riva on 27/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nameBeer = ""
    var firstBrewed = ""
    var foodPairing: [String] = []
    var brewersTips = ""
    
    // Label First Brewed View
    @IBOutlet weak var firstBrewedLabel: UILabel!
    
    // Label Food Pairing View
    @IBOutlet weak var foodPairingLabel: UILabel!
    
    // Label Brewers Tips View
    @IBOutlet weak var brewersTipsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodPairingLabel.numberOfLines = 0
        foodPairingLabel.adjustsFontSizeToFitWidth = true
        foodPairingLabel.minimumScaleFactor = 0.5
        
        brewersTipsLabel.numberOfLines = 0
        brewersTipsLabel.adjustsFontSizeToFitWidth = true
        brewersTipsLabel.minimumScaleFactor = 0.5
        
        navigationItem.title = nameBeer
        firstBrewedLabel.text = firstBrewed
        foodPairingLabel.text = createBulledPoint(elements: foodPairing)
        brewersTipsLabel.text = brewersTips
    }
    
    // Funzione per creare l'elenco puntato per il food pairing
    func createBulledPoint(elements: [String]) -> String{
        
        var result = ""
        
        for el in elements {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint)\(el)\n"
            result = result + formattedString
        }
        return result
    }
}
