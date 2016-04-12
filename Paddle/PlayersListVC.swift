//
//  PlayersListVC.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/7/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

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
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell") as? PlayerCell{
//            let currentPlayers = getPaddlePlayers()
//            cell.textLabel?.text = currentPlayers[indexPath.row].name
//            cell.textLabel?.text = items[indexPath.row]
//            cell.configureCell(items[indexPath.row])
//            return cell
//        } else {
//            return PlayerCell()
//        }
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as? PlayerCell {
            let players = getPaddlePlayers()
            cell.configureCell(players![indexPath.row].name)
            return cell

        } else {
            return PlayerCell()
        }

//        cell!.configureCell(items[indexPath.row])
//        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPaddlePlayers() -> [Player]? {
        let url = NSURL(string: "http://localhost:3000/players")!
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let urlContent = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.AllowFragments)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        for player in json as! [Dictionary<String, AnyObject>] {
                            
                            let profile = player["profile"]!
                            let playerName = profile["firstName"]
                            let myPlayer = Player(name: String(playerName))
                            self.players.append(myPlayer)
                            
                            print("Player \(myPlayer.name)")
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
