//
//  ViewController.swift
//  lica
//
//  Created by ukn on 5/22/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    let screen: CGRect = UIScreen.mainScreen().bounds
    
    var calendarView: CalendarView!
    
    var feedTableView: UITableView!
    var containts: Containts!
    
    var defaultPosition: CGFloat = 0.0
    var planDefaultPosition:CGFloat = 0.0
    
    var backgroundPlanFix: UIView!
    
    let headerHeight: CGFloat = 68
    let calendarHeight: CGFloat = 252
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Feed View
        feedTableView = UITableView(frame: screen, style: UITableViewStyle.Plain)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(feedTableView)
        
        
        self.backgroundPlanFix = UIView(frame: CGRectMake(0, screen.height - headerHeight, screen.width, headerHeight))
        backgroundPlanFix.backgroundColor = UIColor.blackColor()
        backgroundPlanFix.hidden = true
        self.view.addSubview(backgroundPlanFix)
        
        
        // Calendar View
        calendarView = CalendarView()
        calendarView.addWeekCalendar()
        self.view.addSubview(calendarView)
        
        
        // Containts
        containts = Containts()
    }

    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 1)
        feedTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        defaultPosition = feedTableView.contentOffset.y
        planDefaultPosition = defaultPosition - screen.height + headerHeight
        
        feedTableView.contentInset = UIEdgeInsetsMake(0, 0, headerHeight, 0);
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    // Calendar Height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return headerHeight
        }
    }
    
    // Calendar View
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        } else {
            let header = UIView(frame: CGRectMake(0, 0, screen.width, headerHeight))
            header.backgroundColor = UIColor.blackColor()
            return header
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return calendarHeight
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footer = UIView(frame: CGRectMake(0, 0, screen.width, calendarHeight))
            footer.backgroundColor = UIColor.blackColor()
            return footer
        } else {
            return UIView()
        }
    }
    
    
    // Number of Cells
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return containts.planHeadline.count
        } else {
            return containts.dayHeadline.count
        }
    }
    
    // Set Containts
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = FeedCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.frame.size.width = screen.size.width
        if indexPath.row == 0 { cell.topMargin = 0}
        if indexPath.section == 0 {
            cell.setContents(containts.planHeadline[indexPath.row])
        } else {
            cell.setContents(containts.dayHeadline[indexPath.row])
        }
        
        tableView.rowHeight = cell.frame.height
        
        return cell
    }
    
    // Deselect Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }
    
    
    // ScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let positionY = scrollView.contentOffset.y
        
        // add background when calendar is bottom
        if positionY < planDefaultPosition {
            backgroundPlanFix.hidden = false
        } else {
            backgroundPlanFix.hidden = true
        }
        
        // Calendar Position
        if positionY >= defaultPosition - calendarHeight {
            
            calendarView.frame.origin.y = 0
        } else if positionY < defaultPosition - calendarHeight && positionY > planDefaultPosition {
            
            calendarView.frame.origin.y = (defaultPosition - calendarHeight) - positionY
        } else {
            
            calendarView.frame.origin.y = screen.height - headerHeight - calendarHeight
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

