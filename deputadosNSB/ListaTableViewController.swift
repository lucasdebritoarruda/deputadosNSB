//
//  ListaTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 02/09/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import LBTAComponents

class ListaTableViewController: UITableViewController {
    // MARK: - properties
    var listaDeNomes: [String] = []
    var listaDeIds: [String] = []
    var listaDeUrls: [String] = []
    var tituloDaTabela: String = " "
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        navigationItem.title = tituloDaTabela
        tableView.register(ListaCell.self, forCellReuseIdentifier: "listaCellId")
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
        return listaDeNomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listaCellId") as! ListaCell
        cell.nomeLabel.text = listaDeNomes[indexPath.row].lowercased().capitalized
        cell.cellSwitch.tag = Int(listaDeIds[indexPath.row])!
        cell.cellSwitch.name = listaDeNomes[indexPath.row]
        cell.deputadoFoto.loadImage(urlString: listaDeUrls[indexPath.row])
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    var deputadoFoto: CachedImageView = {
        var image = CachedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor(red: 33/255, green: 131/255, blue: 218/255, alpha: 1).cgColor
        return image
    }()
    
    func setupViews(){
        addSubview(deputadoFoto)
        addSubview(nomeLabel)
        addSubview(cellSwitch)
        cellSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v2(60)]-8-[v0]-8-[v1]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel,"v1":cellSwitch,"v2":deputadoFoto]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deputadoFoto]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellSwitch]))
    }
    
    @objc func switchStateDidChange(_ sender:customSwitch){
        if (sender.isOn == true){
            print("Switch "+String(sender.tag)+" state is now ON nome do deputado: "+sender.name)
            if let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
                var seguidos = NSKeyedUnarchiver.unarchiveObject(with: x) as! Dictionary<String, Int>
                seguidos[sender.name] = sender.tag
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                if var y = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaNomesDosSeguidos) as? [String]{
                    y.append(sender.name)
                    y = y.sorted { $0 < $1 }
                    UserDefaults.standard.set(y, forKey: UserDefaults.Keys.listaNomesDosSeguidos)
                }
                if var z = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaIdsDosSeguidos) as? [Int]{
                    z.append(sender.tag)
                    UserDefaults.standard.set(z, forKey: UserDefaults.Keys.listaIdsDosSeguidos)
                }
                print("Dicionário resgatado e atualizado " + String(describing: seguidos))
            }else{
                var seguidos: [String:Int] = [:]
                seguidos[sender.name] = sender.tag
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                var listaDeNomesDosSeguidos:[String] = [ ]
                var listaDeIdsDosSeguidos:[Int] = [ ]
                listaDeNomesDosSeguidos.append(sender.name)
                UserDefaults.standard.set(listaDeNomesDosSeguidos, forKey: UserDefaults.Keys.listaNomesDosSeguidos)
                listaDeIdsDosSeguidos.append(sender.tag)
                UserDefaults.standard.set(listaDeIdsDosSeguidos, forKey: UserDefaults.Keys.listaIdsDosSeguidos)
                print("Dicionário criado e salvo " + String(describing: seguidos))
            }
            let url = URL(string:"http://www.camara.leg.br/internet/deputado/bandep/" + String(sender.tag) + ".jpg")!
            let data = try? Data(contentsOf: url)
            let foto = UIImage(data:data!)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            if documentsPath.count > 0{
                let documentsDirectory = documentsPath[0]
                let savePath = documentsDirectory + String(sender.tag) + ".jpg"
                do{
                    try UIImageJPEGRepresentation(foto!, 1)?.write(to: URL(fileURLWithPath: savePath))
                }catch{
                    // handle error
                }
            }
        }
        else{
            print("Switch "+String(sender.tag)+" state is now OFF nome do deputado: "+sender.name)
            if let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
                var seguidos = NSKeyedUnarchiver.unarchiveObject(with: x) as! Dictionary<String, Int>
                seguidos.removeValue(forKey: sender.name)
                let encondedDict: Data = NSKeyedArchiver.archivedData(withRootObject:seguidos)
                UserDefaults.standard.set(encondedDict, forKey: UserDefaults.Keys.seguidos)
                
                if var y = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaNomesDosSeguidos) as? [String]{
                    y = y.filter { $0 != sender.name } .sorted { $0 < $1 }
                    UserDefaults.standard.set(y, forKey: UserDefaults.Keys.listaNomesDosSeguidos)
                }
                
                if var z = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaIdsDosSeguidos) as? [Int]{
                    z = z.filter { $0 != sender.tag}
                    UserDefaults.standard.set(z, forKey: UserDefaults.Keys.listaIdsDosSeguidos)
                }
                
                print("Dicionário resgatado e atualizado item removido:" + sender.name)
            }
        }
    }
    
}

