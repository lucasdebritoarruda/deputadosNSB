//
//  InfoTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 31/08/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    // MARK: - Properties
    var itens = ["O QUE FAZ UM DEPUTADO FEDERAL?","QUAIS SÃO AS ATRIBUIÇÕES DO CARGO?","COMO ELES SÃO ELEITOS?", "QUEM PODE SER DEPUTADO FEDERAL?","QUANTO GANHA UM DEPUTADO FEDERAL?"]
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Informações Relevantes"
        self.tableView.tableFooterView = UIView()
        tableView.register(InfoCell.self, forCellReuseIdentifier: "infoCellId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - Table view data source
extension InfoTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "infoCellId")
        cell.textLabel?.text = itens[indexPath.row].lowercased().capitalized
        return cell
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoDetailTableViewController = InfoDetailViewController()
        infoDetailTableViewController.index = indexPath.row
        let iniciaisButton = UIBarButtonItem()
        iniciaisButton.title = "Informaçoes"
        navigationItem.backBarButtonItem = iniciaisButton
        navigationController?.pushViewController(infoDetailTableViewController, animated: true)
    }
}

// MARK: - Auxiliar
class InfoCell: UITableViewCell {
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
