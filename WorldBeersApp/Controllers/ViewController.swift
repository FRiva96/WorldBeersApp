//
//  ViewController.swift
//  WorldBeersApp
//
//  Created by Francesco Riva on 26/11/21.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // Variabile per memorizzare la birra cliccata tra quelle nella tabella
    var clickedBeer: Beer?
    var beersViewModel: BeersViewModel!
    
    // Search Bar View
    @IBOutlet weak var searchBarView: UISearchBar!
    
    // Table View Beers
    @IBOutlet weak var beersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beersTableView.delegate = self
        beersTableView.dataSource = self
        searchBarView.delegate = self
        
        searchBarView.searchTextField.backgroundColor = UIColor.white
        searchBarView.barTintColor = UIColor.lightGray
        searchBarView.tintColor = UIColor.black
        
        if let textField = searchBarView.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.black
            }
        }
        
        loadBeersData()
    }
    
    // Funzione per il caricamento dei dati delle birre
    func loadBeersData(){
        beersViewModel = BeersViewModel()
    }
    
    // Funzione per definire la dimensione delle righe delle tabella
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Funzione per definire il numero di righe della tabella
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersList.count
    }
    
    // Funzione per popolare le celle con i dati delle birre
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cella") as! BeerTableViewCell
        
        cell.nameLabelCell.text = beersList[indexPath.row].name
        cell.descriptionLabelCell.text = beersList[indexPath.row].description
        
        cell.abvLabelCell.text = beersList[indexPath.row].abv + "% VOL."
        cell.ibuLabelCell.text = beersList[indexPath.row].ibu
        
        let image = try! Data(contentsOf: URL(string: beersList[indexPath.row].imageUrl)!)
        cell.imageViewCell.image = UIImage(data: image)
        cell.imageViewCell.layer.borderColor = UIColor.black.cgColor
        cell.imageViewCell.layer.borderWidth = 1
        cell.imageViewCell.layer.cornerRadius = 30
        cell.imageViewCell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    // Tramite questa funzione verrà visualizzata la pagina di dettaglio della birra selezionata
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        clickedBeer = beersList[indexPath.row]
        searchBarView.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "beersListTOdetail", sender: nil)
    }
    
    // Funzione per visualizzare la tastiera al click sulla searchBar e visualizzare il tasto cancel
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBarView.setShowsCancelButton(true, animated: true)
        return true
    }
    
    // Funzione richiamata al click del tasto cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarView.text = ""
        beersTableView.reloadData()
        searchBarView.setShowsCancelButton(false, animated: true)
        searchBarView.endEditing(true)
    }
    
    // Funzione utilizzata per filtrare i contenuti della tabella in base al testo inserito nella searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchBarView.text!.isEmpty {
            beersList = beersList.filter({(word: Beer) -> Bool in
                
                let result: Range<String.Index>?
                let filterName = word.name.range(of: searchBarView.text!)
                let filterDescription = word.description.range(of: searchBarView.text!)
                
                if filterName != nil {
                    result = filterName
                }else{
                    result = filterDescription
                }
                return result != nil
            })
        }else{
            loadBeersData()
        }
        self.beersTableView.reloadData()
    }
    
    // Funzione richiamata al click del bottone "Cerca"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarView.endEditing(true)
    }
    
    // Funzione per chiudere la tastiera quando si clicca sulla view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBarView.endEditing(true)
    }
    
    // Funzione standard per il passaggio delle informazioni alla view di dettaglio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier != nil else {
            return
        }
        
        let dest = segue.destination as! DetailViewController
        
        switch segue.identifier {
        case "beersListTOdetail":
            dest.nameBeer = clickedBeer!.name
            dest.firstBrewed = clickedBeer!.firstBrewed
            dest.foodPairing = clickedBeer!.foodPairing
            dest.brewersTips = clickedBeer!.brewersTips
        default:
            break
        }
    }
}





