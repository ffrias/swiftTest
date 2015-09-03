//
//  DetailViewController.swift
//  swiftTest
//
//  Created by Federico Frias on 8/26/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    
    var name: String!
    var track: String!
    var price: String!
    var imageString: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInitialData(data:Song)->Bool{
        var error = false
        self.name = data.getName()
        self.track = data.getTrack()
        self.price = data.getPrice()
        self.imageString = data.getImage()
        
        //Unit Test
        if (self.name.isEmpty || self.track.isEmpty || self.price.isEmpty || self.imageString.isEmpty){
            error = true
        }
        
        return error
    }
    
    func loadLabels(){
        if (!name.isEmpty){
            self.artistLabel?.text = name
        }
        
        if (!track.isEmpty){
            trackLabel?.text = track
        }
        
        if (!price.isEmpty){
            priceLabel?.text = price
        }
        
        //Async load of images to don't block the main thread
        
        Alamofire.request(.GET, self.imageString).response{(request, response, data, error) in
            self.image.image = UIImage(data: data!)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "centralTable"){
            var Songs = [Song]()
            //fetch data from database
            var fetchedData = DataMapper()
            Songs = fetchedData.getAllSongs()
            
            var storyboard:UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
            var centralVC = storyboard.instantiateViewControllerWithIdentifier("viewController") as! ViewController
            
            centralVC.loadSongsFromDB(Songs)
            
            self.presentViewController(centralVC, animated: true, completion: nil)
        }
        
    }
}