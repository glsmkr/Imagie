//
//  PhotoTableViewController.swift
//  Imagie
//
//  Created by Julian A. Fordyce on 5/13/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder =  searchTerm
        
        photoController.search(for: searchTerm) { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoController.numberOfPhotos
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else { fatalError("Unable to dequeue cell")}
        
        let photo = photoController.photo(at: indexPath)
        cell.photoNameLabel?.text = photo.description
        
        guard let url = URL(string: photo.urls.small), let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.photoImageView?.image = UIImage(data: imageData)

        return cell
    }
    


 


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Properties
    
    let photoController =  PhotoController()
    let searchBar = UISearchBar()

}
