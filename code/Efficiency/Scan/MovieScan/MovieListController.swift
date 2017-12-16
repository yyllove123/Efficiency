//
//  MovieListController.swift
//  Efficiency
//
//  Created by Yalin on 16/4/13.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class MovieListController: UITableViewController {

    var viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "视频浏览"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshDatas()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath as IndexPath)
        
        // Configure the cell...
        let object = viewModel.datas[indexPath.row]
        cell.textLabel!.text = object.name
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = viewModel.datas[indexPath.row]
        self.navigationController?.pushViewController(MovieFolderController(folder:object), animated: true)
    }
}
