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
    
    var calendarView: CalendarView!
    
    var feedTableView: UITableView!
    var containts: Containts!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //Calendar View
        calendarView = CalendarView()
        calendarView.addWeekCalendar()
        
        
        //Feed View
        feedTableView = UITableView(frame: screen, style: UITableViewStyle.Plain)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(feedTableView)
        
        //Containts
        containts = Containts()
    }
    
    
    //Calendar Height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return calendarView.calendarHeight
    }
    
    //Calendar View
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return calendarView
    }
    
    //Number of Cells
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return containts.dayHeadline.count
    }
    
    //Set Containts
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = FeedCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.frame.size.width = screen.size.width
        if indexPath.row == 0 { cell.topMargin = 0}
        cell.setContents(containts.dayHeadline[indexPath.row])
        
        tableView.rowHeight = cell.frame.height
        
        
        
        return cell
    }
    
    // Deselect Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

