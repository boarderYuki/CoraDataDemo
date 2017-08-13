//
//  TableViewController.swift
//  CoreDataIdea
//
//  Created by yuki.pro on 2017. 8. 13..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate{

    @IBOutlet var ideaTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    
    var ideaList : [Idea] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        ideaList = CoreDataManager.readIdeas()
        ideaTableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if searchBar.text == "" {
            ideaList = CoreDataManager.readIdeas()
            ideaTableView.reloadData()
            
        } else {
            // 서치바에 검색어가 있는 경우에는 테이블 리로드 않함
            ideaList = CoreDataManager.readIdeas()
            
        }
    }
    
    
  
    //MARK: - 서치바 컨트롤
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.titleView = searchController.searchBar
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {

        searchBar.showsCancelButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.titleView = searchController.searchBar
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar ) {
        
        searchBar.text = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        ideaList = CoreDataManager.readIdeas()
        ideaTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            ideaTableView.reloadData()
            return
        }
        // 서치바의 텍스트가 변하면 아이디어리스트를 갱신
        ideaList = CoreDataManager.readIdeas(targetText: searchText)
        ideaTableView.reloadData()
    }
    
    
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowIdea" {
            if let row = ideaTableView.indexPathForSelectedRow?.row {
                let ideaDetail = ideaList[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.ideaList = ideaDetail
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideaList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTableViewCell
        
        let ideaItem = ideaList[indexPath.row]
        
        cell.ideaLabel.text = ideaItem.ideaTxt
        //cell.ideaLabel.text = ideaItem.idea
        //cell.keywordLabel.text = ideaItem.keyword
        cell.createLabel.text = timeAgo.sinceDate(ideaItem.createDate! as Date)
        
        //timeAgo.SinceDate(ideaItem.create! as Date)
        
        return cell
    }

    
    // 아이디어 리스트 행 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataManager.deleteIdea(indexPath: indexPath)
            ideaList = CoreDataManager.readIdeas()
        }
        ideaTableView.reloadData()
    }

    
}
