//
//  ListaTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 02/09/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController {
    // MARK: - properties
    var lista: [String] = []
    var tituloDaTabela: String = " "
    var idComNome: [String:String] = [:]
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        navigationItem.title = tituloDaTabela
        tableView.register(ListaCell.self, forCellReuseIdentifier: "listaCellId")
        let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.dicionarioIdNome) as! Data
        idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, String>
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    // MARK: - Table view data source
extension ListaTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lista.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listaCellId") as! ListaCell
        cell.nomeLabel.text = lista[indexPath.row].lowercased().capitalized
        cell.cellSwitch.tag = Int(idComNome[lista[indexPath.row]]!)!
        if let y = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos){
            let x = y as! [String]
            if x.contains(String(cell.cellSwitch.tag)){
               cell.cellSwitch.isOn = true
            }else{
               cell.cellSwitch.isOn = false
            }
        }else{
            cell.cellSwitch.isOn = false
        }
        return cell
    }
    
}
    // MARK: - Auxiliar functions
    extension ListaTableViewController{}

    // MARK: - Auxiliar classes
class ListaCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellSwitch: UISwitch = {
        let cellswitch = UISwitch()
        cellswitch.translatesAutoresizingMaskIntoConstraints = false
        return cellswitch
    }()
    
    let nomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func setupViews(){
        addSubview(nomeLabel)
        addSubview(cellSwitch)
        cellSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel,"v1":cellSwitch]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellSwitch]))
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch){
        if (sender.isOn == true){
            print("Switch "+String(sender.tag)+" state is now ON")
            let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos)
            if var y = x as? [String]{
                y.append(String(sender.tag))
                UserDefaults.standard.set(y, forKey: UserDefaults.Keys.seguidos)
            }else{
                var x: [String] = []
                x.append(String(sender.tag))
                UserDefaults.standard.set(x, forKey: UserDefaults.Keys.seguidos)
            }
        }
        else{
            print("Switch "+String(sender.tag)+" state is now OFF")
            let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos)
            var y = x as? [String]
            y = y?.filter { $0 != String(sender.tag) }
            UserDefaults.standard.set(y, forKey: UserDefaults.Keys.seguidos)
        }
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
