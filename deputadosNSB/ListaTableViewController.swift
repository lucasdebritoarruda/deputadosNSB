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
    var listaDeNomes: [String] = []
    var listaDeIds: [String] = []
    var tituloDaTabela: String = " "
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        navigationItem.title = tituloDaTabela
        tableView.register(ListaCell.self, forCellReuseIdentifier: "listaCellId")
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
        return listaDeNomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "listaCellId") as! ListaCell
//        cell.nomeLabel.text = listaDeNomes[indexPath.row].lowercased().capitalized
//        cell.cellSwitch.isOn = false
//        cell.cellSwitch.tag = Int(listaDeIds[indexPath.row])!
//        cell.cellSwitch.name = listaDeNomes[indexPath.row]
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "listaCellId") as! ListaCell
        cell.nomeLabel.text = listaDeNomes[indexPath.row].lowercased().capitalized
        cell.cellSwitch.tag = Int(listaDeIds[indexPath.row])!
        cell.cellSwitch.name = listaDeNomes[indexPath.row]
        if let y = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
            let x = NSKeyedUnarchiver.unarchiveObject(with: y) as! Dictionary<String, Int>
            if x.keys.contains(listaDeNomes[indexPath.row]){
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

class customSwitch:UISwitch{
    var name: String = ""
}

class ListaCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellSwitch: customSwitch = {
        let cellswitch = customSwitch()
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
    
    @objc func switchStateDidChange(_ sender:customSwitch){
        if (sender.isOn == true){
            print("Switch "+String(sender.tag)+" state is now ON nome do deputado: "+sender.name)
            if let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
                var seguidos = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, Int>
                seguidos[sender.name] = sender.tag
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                print("Dicionário resgatado e atualizado " + String(describing: seguidos))
            }else{
                var seguidos: [String:Int] = [:]
                seguidos[sender.name] = sender.tag
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                print("Dicionário criado e salvo " + String(describing: seguidos))
            }
        }
        else{
            print("Switch "+String(sender.tag)+" state is now OFF nome do deputado: "+sender.name)
            if let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
                var seguidos = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, Int>
                seguidos.removeValue(forKey: sender.name)
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                print("Dicionário resgatado e atualizado item removido:" + sender.name)
            }
        }
    }
    
}

