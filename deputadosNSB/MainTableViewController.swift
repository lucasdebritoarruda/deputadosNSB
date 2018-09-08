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
    var idComNome: [String:String] = [:]
    var lista: [String] = []
    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Políticos no Radar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"plus"), style: .plain, target: self, action: #selector(toList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .plain, target: self, action: #selector(toInfo))
        tableView.register(MainCell.self, forCellReuseIdentifier: "mainCellId")
        let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.dicionarioIdNome) as! Data
        idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, String>
        lista = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as! [String]
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lista = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as! [String]
        let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.dicionarioIdNome) as! Data
        idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, String>
        tableView.reloadData()
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
        return lista.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mainCellId")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.text = idComNome.keysForValue(value: lista[indexPath.row])[0].lowercased().capitalized
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
    
    func setupViews(){
        
    }
}

extension Dictionary where Value: Equatable {
    func keysForValue(value: Value) -> [Key] {
        return flatMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}

