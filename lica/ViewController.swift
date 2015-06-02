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
    
    var scrollBeginingPointY: CGFloat = 0
    var scrollUp: Bool?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Feed View
        feedTableView = UITableView(frame: screen, style: UITableViewStyle.Plain)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(feedTableView)
        scrollUp = nil
        
        // Background of Footer
        self.backgroundPlanFix = UIView(frame: CGRectMake(0, screen.height - headerHeight, screen.width, headerHeight))
        backgroundPlanFix.backgroundColor = UIColor.blackColor()
        backgroundPlanFix.hidden = true
        backgroundPlanFix.userInteractionEnabled = false
        self.view.addSubview(backgroundPlanFix)
        
        // Containts
        containts = Containts()
        
        // Last day of Log 0
        let lastDate: NSDate = dateFromData(0)
        
        // Calendar View
        calendarView = CalendarView()
        calendarView.addMonthOfWeekCalendar(lastDate)
        calendarView.addWeekCalendar(lastDate)
        self.view.addSubview(calendarView)
    }

    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 1)
        feedTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        defaultPosition = feedTableView.contentOffset.y
        planDefaultPosition = defaultPosition - screen.height + headerHeight
        
        feedTableView.contentInset = UIEdgeInsetsMake(0, 0, headerHeight, 0);
        
    }

    
    // Number of Section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    // Header Height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return headerHeight
        }
    }
    
    // Header View
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        } else {
            let header = UIView(frame: CGRectMake(0, 0, screen.width, headerHeight))
            header.backgroundColor = UIColor.blackColor()
            return header
        }
    }
    
    // Footer View
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return calendarHeight
        } else {
            return 0
        }
    }
    
    // Footer View
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
    
    
    
    // Cell Height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cell = FeedCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.frame.size.width = screen.size.width
        if indexPath.row == 0 { cell.topMargin = 0}
        if indexPath.section == 0 {
            cell.calcContentsHeight(containts.planHeadline[indexPath.row])
        } else {
            cell.calcContentsHeight(containts.dayHeadline[indexPath.row])
        }
        
        return cell.height
    }
    
    // Cell View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = FeedCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.frame.size.width = screen.size.width
        if indexPath.row == 0 { cell.topMargin = 0}
        if indexPath.section == 0 {
            cell.setContents(containts.planHeadline[indexPath.row])
        } else {
            cell.setContents(containts.dayHeadline[indexPath.row])
        }
        
        return cell
    }
    
    
    // Select Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }
    
    // Display Cell
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1 && scrollUp == true) {
            highlightCurrentDate(indexPath.row+1)
        }
        
    }
    
    // End Display Cell
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && scrollUp == false {
            highlightCurrentDate(indexPath.row+1)
        }
    }
    
    // Display Footer
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        highlightCurrentDate(0)
    }
    
    // Highlight Date of calendar
    func highlightCurrentDate(row: Int) {
        
        calendarView.highlightDay(dateFromData(row))
    }
    
    // Date from Data
    func dateFromData(num: Int) -> NSDate {
        
        let dateString = containts.dayHeadline[num]["date"]!
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let date: NSDate! = formatter.dateFromString(dateString)
        
        return date
    }
    
    // For Checking Scrolling Direction
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollBeginingPointY = scrollView.contentOffset.y
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
        
        // Direction of Scrolling
        if scrollBeginingPointY > positionY {
            scrollUp = true
        } else if scrollBeginingPointY < positionY {
            scrollUp = false
        }
        scrollBeginingPointY = positionY

        if positionY < defaultPosition - 120 && !calendarView.isDisplayMonthCalendar {
            calendarView.expandMonthCalendar(dateFromData(0))
            calendarView.isDisplayMonthCalendar = true
        } else if positionY > defaultPosition - 120 && calendarView.isDisplayMonthCalendar! {
            calendarView.shrinkMonthCalendar(dateFromData(0))
            calendarView.isDisplayMonthCalendar = false
            
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

