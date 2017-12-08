//
//  ActivityTableViewController.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 60 // Tamanho aproximado da célula
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "activityCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Precisa implementar
        
        // Limpa o valor do título
        self.tabBarController?.navigationItem.title = ""
        
        // Cria um botão a esquerda
        let leftButton = UIBarButtonItem(title: "Seguindo", style: .done, target: self, action: Selector(("left")))
        self.tabBarController?.navigationItem.leftBarButtonItem = leftButton
        
        // Cria um botão a direita
        let rightButton = UIBarButtonItem(title: "Você", style: .done, target: self, action: Selector(("right")))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
