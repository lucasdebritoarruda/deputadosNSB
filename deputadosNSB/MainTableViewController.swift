//
//  MainTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 30/08/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var nomes = ["Lucas","Tais","Luma","Claudia"]
    //var idComNome: [String:Int] = [:]
    var listaDosNomesDosSeguidos:[String] = [ ]
    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Políticos no Radar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"plus"), style: .plain, target: self, action: #selector(toList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .plain, target: self, action: #selector(toInfo))
        tableView.register(MainCell.self, forCellReuseIdentifier: "mainCellId")
        self.tableView.tableFooterView = UIView()
        if let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaNomesDosSeguidos) as? [String] {
            listaDosNomesDosSeguidos = x
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaNomesDosSeguidos) as? [String] {
            listaDosNomesDosSeguidos = x
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Auxiliar Functions
extension MainTableViewController{
    @objc func toList(){
        let iniciaisTableViewController = IniciaisTableViewController()
        let iniciaisButton = UIBarButtonItem()
        iniciaisButton.title = "Voltar"
        navigationItem.backBarButtonItem = iniciaisButton
        navigationController?.pushViewController(iniciaisTableViewController, animated: true)
    }
    
    @objc func toInfo(){
        let infoTableViewController = InfoTableViewController()
        let iniciaisButton = UIBarButtonItem()
        iniciaisButton.title = "Voltar"
        navigationItem.backBarButtonItem = iniciaisButton
        navigationController?.pushViewController(infoTableViewController, animated: true)
    }
}

// MARK: - Table view data source
extension MainTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaDosNomesDosSeguidos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "mainCellId")
//        cell.textLabel?.text = listaDosNomesDosSeguidos[indexPath.row].lowercased().capitalized
//        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellId") as! MainCell
        cell.deputadoFoto.image = UIImage(named:"178889")
        cell.nomeLabel.text = listaDosNomesDosSeguidos[indexPath.row].lowercased().capitalized
        cell.nomeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
}

// MARK: - Auxiliar
class MainCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var deputadoFoto: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    func setupViews(){
        addSubview(nomeLabel)
        addSubview(deputadoFoto)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1(45)]-8-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel,"v1":deputadoFoto]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0(45)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deputadoFoto]))
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
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
