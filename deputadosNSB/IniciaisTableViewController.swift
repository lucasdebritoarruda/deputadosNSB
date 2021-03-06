//
//  IniciaisTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 01/09/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class IniciaisTableViewController: UITableViewController {
    
// MARK: - Properties
    var itens = ["A - B - C","C - D - E - F - G - H","H - I - J - K - L","L - M - N - O - P","R - S - T - U - V - W","W - X - Y - Z"]
    
    var links = ["https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=1&ordenarPor=nome&itens=100",
                 "https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=2&ordenarPor=nome&itens=100",
                 "https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=3&ordenarPor=nome&itens=100",
                 "https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=4&ordenarPor=nome&itens=100",
                 "https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=5&ordenarPor=nome&itens=100",
                 "https://dadosabertos.camara.leg.br/api/v2/deputados?pagina=6&ordenarPor=nome&itens=100"]
    var idComNome: [String:String] = [:]

// MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Iniciais"
        self.tableView.tableFooterView = UIView()
        tableView.register(InicialCell.self, forCellReuseIdentifier: "inicialCellId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source
extension IniciaisTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "inicialCellId")
        cell.textLabel?.text = itens[indexPath.row]
        return cell
    }
}

// MARK: - Navigation
extension IniciaisTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let x = tableView.cellForRow(at: indexPath)?.textLabel?.text
        let y = UserDefaults.standard.object(forKey: x!)
        
        tableView.allowsSelection = false
        
        if let lista = y as? [String]{
            
            let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.dicionarioIdNome) as! Data
            self.idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, String>
            
            let listaTableViewController = ListaTableViewController()
            listaTableViewController.lista = lista
            listaTableViewController.tituloDaTabela = self.itens[indexPath.row]
            let iniciaisButton = UIBarButtonItem()
            iniciaisButton.title = "Voltar"
            self.navigationItem.backBarButtonItem = iniciaisButton
            self.navigationController?.pushViewController(listaTableViewController, animated: true)
            print("lista recuperada")
            print(self.idComNome)
            tableView.allowsSelection = true
        }else{
            downloadList(link: links[indexPath.row]){
                nomes,ids in
                
                var dict = [String:String]()
                for(index,element) in nomes.enumerated(){
                    dict[element] = ids[index]
                }
                
                dict.forEach({ (k,v) in
                    self.idComNome[k] = v
                })
               // print(self.idComNome)
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject: self.idComNome)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.dicionarioIdNome)
                
                saveToUserDefaults(lista: nomes, row: indexPath.row)
                let listaTableViewController = ListaTableViewController()
                listaTableViewController.lista = nomes
                listaTableViewController.tituloDaTabela = self.itens[indexPath.row]
                let iniciaisButton = UIBarButtonItem()
                iniciaisButton.title = "Voltar"
                self.navigationItem.backBarButtonItem = iniciaisButton
                tableView.allowsSelection = true
                self.navigationController?.pushViewController(listaTableViewController, animated: true)
               // print("lista baixada e salva")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Auxiliar Classes
class InicialCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}

// MARK: - Auxiliar Functions
func downloadList(link:String,completion: @escaping ([String],[String])->Void){
    let url = URL(string: link)
    Alamofire.request(url!)
        .responseJSON { (response) in
            guard response.result.isSuccess,
                let value = response.result.value else{
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
            }
            let nomes = JSON(value)["dados"].arrayValue.map({$0["nome"].stringValue})
            let ids = JSON(value)["dados"].arrayValue.map({$0["id"].stringValue})
            completion(nomes,ids)
            //print(nomes)
    }
}
func saveToUserDefaults(lista:[String], row:Int){
    if row == 0{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.abc)
    }
    if row == 1{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.cdefgh)
    }
    if row == 2{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.hijkl)
    }
    if row == 3{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.lmnop)
    }
    if row == 4{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.rstuvw)
    }
    if row == 5{
        UserDefaults.standard.set(lista, forKey: UserDefaults.Keys.wxyz)
    }
}

// MARK: - UserDefaults Keys
extension UserDefaults{
    enum Keys{
        static let abc = "A - B - C"
        static let cdefgh = "C - D - E - F - G - H"
        static let hijkl = "H - I - J - K - L"
        static let lmnop = "L - M - N - O - P"
        static let rstuvw = "R - S - T - U - V - W"
        static let wxyz = "W - X - Y - Z"
        static let dicionarioIdNome = "dicionarioIdNome"
        static let seguidos = "seguidos"
    }
}
