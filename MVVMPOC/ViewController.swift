//
//  ViewController.swift
//  MVVMPOC
//
//  Created by CSS CORP on 17/01/19.
//  Copyright © 2019 CSS CORP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let datasource = ["one","two","three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.dataSource = self;
        tableview.delegate = self;
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        
        //add navigation bar button "help"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .plain, target: self, action:#selector(helpTapped))
    }
    
    @objc func helpTapped() {
        print("help action worked")
        performSegue(withIdentifier: "DetailViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare for segue")
        if segue.identifier == "DetailViewController" {
            if let detailVC = segue.destination as? DetailViewController {
                let indexpath = tableview.indexPathForSelectedRow ?? IndexPath(row: 0, section: 0)
                let index = indexpath.row
//                detailVC.data = [datasource[index]]
                
                detailVC.messierViewModel = messierViewModel[index]
            }
            
        }
    }

}


extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messierViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableviewcell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if tableviewcell == nil {
            tableviewcell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
//        tableviewcell?.textLabel?.text = datasource[indexPath.row]
//        tableviewcell?.detailTextLabel?.text = datasource[indexPath.row] + "subtitle"
        
        // #1 - The ViewModel is the app's de facto data source.
        tableviewcell?.imageView?.image = UIImage(named: messierViewModel[indexPath.row].thumbnail)
        tableviewcell?.textLabel?.text = messierViewModel[indexPath.row].dateUpdated
        tableviewcell?.detailTextLabel?.text = messierViewModel[indexPath.row].commonName
        
        return tableviewcell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated:true)
    }
    
}

