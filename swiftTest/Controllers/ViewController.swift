//
//  ViewController.swift
//  swiftTest
//
//  Created by Federico Frias on 8/25/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    var Songs = [Song]()
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var initialSearchTerm:String = "rihana"
        
        if(Songs.isEmpty){                      //If DB is empty I load it from WS, if I came from DetailVC
            loadData(initialSearchTerm,completion: {(result)->Void in          //I load data from DB
                    tableView?.reloadData()
                })
        }
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(term:String, completion:(result:String)->Void){
        let url = "https://itunes.apple.com/search?term="+term+"&entity=musicVideo"

        let JSONLoader = APIClient(url: url)
        JSONLoader.getData { (result) -> Void in
            
            let count:Int = Int(result["resultCount"].intValue)
        
            for (var i:Int = 0; i < count; i++){
                var newSong = Song(image: result["results"][i]["artworkUrl100"].stringValue, name: result["results"][i]["artistName"].stringValue, track: result["results"][i]["trackName"].stringValue, price: result["results"][i]["trackPrice"].stringValue)
                self.Songs.append(newSong)
                var newMapper = DataMapper()
                newMapper.saveSong(newSong)
            }
                 completion(result:"Finish loading data into array of Songs")
        }
    }
}
//MARK - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
}

//MARK - UITableViewDataSource

extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("songViewCell") as! SongViewCell
        cell.artistLabel.text = Songs[indexPath.row].getName()
        cell.trackLabel.text = Songs[indexPath.row].getTrack()
        cell.priceLabel.text = Songs[indexPath.row].getPrice()

        //Async load of images to don't block the main thread
        
        Alamofire.request(.GET, Songs[indexPath.row].getImage()).response{(request, response, data, error) in
            cell.imageView?.image = UIImage(data: data!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyboard:UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        var detailVC = storyboard.instantiateViewControllerWithIdentifier("detailViewController") as! DetailViewController
        
        var selectedSong:Song = Song(image: Songs[indexPath.row].getImage(), name: Songs[indexPath.row].getName(), track: Songs[indexPath.row].getTrack(), price: Songs[indexPath.row].getPrice())
        detailVC.setInitialData(selectedSong)
        
        self.presentViewController(detailVC, animated: true, completion: nil)
    }
    
    func loadSongsFromDB(songs:Array<Song>){
        
        for song in songs {
            var newSong = Song(image: song.getImage(), name: song.getName(), track: song.getTrack(), price: song.getPrice())
            Songs.append(newSong)
        }
    }
}

//MARK - UISearchBarDelegate

extension ViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var searchText:String = searchBar.text
        self.Songs = []
        loadData(searchText, completion: {(result)->Void in          //I load data from DB
            tableView?.reloadData()
        })
                self.searchBar.resignFirstResponder()
    }
}