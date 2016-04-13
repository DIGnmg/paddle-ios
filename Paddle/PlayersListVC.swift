//
//  PlayersListVC.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/7/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit
import Alamofire

class PlayersListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var players = [Player]()
    let items = ["Item 1", "Item2", "Item3", "Item4"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        
        if let currentPlayers = getPaddlePlayers() {
            players = currentPlayers
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell") as? PlayerCell {
            cell.layer.borderColor = UIColor.blueColor().CGColor
            cell.configureCell(players[indexPath.row].firstName)
            return cell
        } else {
            return PlayerCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPaddlePlayers() -> [Player]? {
        let url = NSURL(string: "http://localhost:5000/players")!
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let urlContent = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let data = json as? Dictionary<String, AnyObject> {
                        print(data)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        for player in json as! [Dictionary<String, AnyObject>] {
                            
                            if let profile = player["profile"] as? Dictionary<String, AnyObject> {
                                if let firstName = profile["firstName"] as? String, let lastName = profile["lastName"] as? String {
                                    let myPlayer = Player(firstName: firstName, lastName: lastName)
                                    print(profile)
                                    print(myPlayer.firstName)
                                    self.players.append(myPlayer)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    })
                    
                } catch {
                    print("There was an error")
                }

            }
        }
        
        task.resume()
        
        return players
    }
}
