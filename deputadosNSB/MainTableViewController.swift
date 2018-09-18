//
//  MainTableViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 30/08/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import LBTAComponents

class MainTableViewController: UITableViewController {
    
    var nomes = ["Lucas","Tais","Luma","Claudia"]
    var listaDosNomesDosSeguidos:[String] = [ ]
    var idComNome: [String:Int] = [:]
    
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
        if let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
            idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, Int>
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: UserDefaults.Keys.listaNomesDosSeguidos) as? [String] {
            listaDosNomesDosSeguidos = x
        }
        if let z = UserDefaults.standard.object(forKey: UserDefaults.Keys.seguidos) as? Data{
            idComNome = NSKeyedUnarchiver.unarchiveObject(with: z) as! Dictionary<String, Int>
        }
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDosNomesDosSeguidos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellId") as! MainCell
        
        let photoUrl = "http://www.camara.leg.br/internet/deputado/bandep/" + String(describing: idComNome[listaDosNomesDosSeguidos[indexPath.row]]!) + ".jpg"
        
        cell.deputadoFoto.loadImage(urlString: photoUrl)
        
        cell.nomeLabel.text = listaDosNomesDosSeguidos[indexPath.row].lowercased().capitalized
        cell.nomeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
        addSubview(nomeLabel)
        addSubview(deputadoFoto)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1(60)]-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel,"v1":deputadoFoto]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nomeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0(60)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deputadoFoto]))
    }
}

