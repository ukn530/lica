//
//  ViewController.swift
//  lica
//
//  Created by ukn on 5/22/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let screen: CGRect = UIScreen.mainScreen().bounds
    
    var feedTableView: UITableView!
    
    var headerView: UIView!
    var monthImageView: UIView!
    var weekImageViews = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HeaderView
        headerView = UIView(frame: CGRectMake(0, 0, screen.width, 68))
        headerView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(headerView)
        
        //Header Title
        var monthImage: UIImage = UIImage(named: "title_month")!
        monthImageView = UIImageView(image: monthImage)
        monthImageView.frame = CGRectMake(screen.width/2 - monthImage.size.width/2, 17, monthImage.size.width, monthImage.size.height)
        headerView.addSubview(monthImageView)
        
        //calc each position of the day
        var sundayNum: Int = 3
        var amountDayWidth:CGFloat = 0
        
        for i in 0...6 {
            amountDayWidth += UIImage(named: "cal\(sundayNum+i)")!.size.width
        }
        var gapBtwDay: CGFloat = (screen.size.width - amountDayWidth)/8
        var lastXOfDay: CGFloat = 0
        
        //Draw Header Day
        for i in 0...6 {
            var dayImage: UIImage = UIImage(named: "cal\(sundayNum+i)")!
            var dayImageView: UIImageView = UIImageView(frame: CGRectMake(gapBtwDay+lastXOfDay, 48, dayImage.size.width, dayImage.size.height))
            lastXOfDay = dayImageView.frame.origin.x + dayImage.size.width
            dayImageView.image = dayImage
            weekImageViews[i] = dayImageView
            self.view.addSubview(dayImageView)
        }

        
        //feedTableView.delegate = self
        //feedTableView.dataSource = self
        
        //self.view.addSubview(feedTableView)
    }
    
    // セルに表示するテキスト
    let texts = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return texts.count
        return 3
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //cell.textLabel?.text = texts[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

