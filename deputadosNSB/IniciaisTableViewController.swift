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
    var listaDeNomes = [String]()

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
        tableView.allowsSelection = false
        downloadList(link: links[indexPath.row]){
            nomes in
            let listaTableViewController = ListaTableViewController()
            listaTableViewController.lista = nomes
            listaTableViewController.tituloDaTabela = self.itens[indexPath.row]
            let iniciaisButton = UIBarButtonItem()
            iniciaisButton.title = "Voltar"
            self.navigationItem.backBarButtonItem = iniciaisButton
            tableView.allowsSelection = true
            self.navigationController?.pushViewController(listaTableViewController, animated: true)
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
func downloadList(link:String,completion: @escaping ([String])->Void){
    let url = URL(string: link)
    Alamofire.request(url!)
        .responseJSON { (response) in
            guard response.result.isSuccess,
                let value = response.result.value else{
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
            }
            let nomes = JSON(value)["dados"].arrayValue.map({$0["nome"].stringValue})
            completion(nomes)
            //print(nomes)
    }
}




/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
