//
//  Calendar.swift
//  lica
//
//  Created by ukn on 5/24/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    let screen: CGRect = UIScreen.mainScreen().bounds
    
    var yearImageView: UIImageView = UIImageView()
    var monthImageView: UIImageView = UIImageView()
    var weekImageViews = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    
    var weekDayDates: [NSDate]!
    
    let cal: Cal = Cal()
    
    

    //init size and background
    override init(frame: CGRect) {
        
        super.init(frame: CGRectMake(0, 0, screen.size.width, 68))
        
        backgroundColor = UIColor.clearColor()
        userInteractionEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    
    // add Month of Week Calendar
    func addMonthOfWeekCalendar(date: NSDate) {
        
        var monthImage: UIImage = UIImage(named: "m\(cal.month(date))")!
        var yearImage: UIImage = UIImage(named: "y\(cal.year(date))")!
        
        monthImageView.image = monthImage
        monthImageView.frame = CGRectMake(screen.width/2 - (monthImage.size.width+yearImage.size.width)/2, 15, monthImage.size.width, monthImage.size.height)
        monthImageView.tag = cal.month(date)
        self.addSubview(monthImageView)
        
        yearImageView.image = yearImage
        yearImageView.frame = CGRectMake(screen.width/2 - (monthImage.size.width+yearImage.size.width)/2 + monthImage.size.width-1, 15, yearImage.size.width, yearImage.size.height)
        yearImageView.tag = cal.year(date)
        self.addSubview(yearImageView)

    }
    
    
    
    // add week calendar
    func addWeekCalendar(date: NSDate) {
        
        // Return weekday of the date
        weekDayDates = weekDaysFromDate(date)
        
        //Draw Header Day
        for i in 0...6 {
            
            var dayImage: UIImage = UIImage(named: "day_num_\(cal.day(weekDayDates[i]))")!
            var dayImageView: UIImageView = UIImageView(frame: CGRectMake(CGFloat(i+1) * screen.width/8 - dayImage.size.width/2, 48, dayImage.size.width, dayImage.size.height))
            
            if i == 0 {
                dayImageView.tintColor = UIColor.hexStr("FF5A6E", alpha: 1)
            } else if (i == 6) {
                dayImageView.tintColor = UIColor.hexStr("71B3FF", alpha: 1)
            } else {
                dayImageView.tintColor = UIColor.whiteColor()
            }
            
            dayImage = dayImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            dayImageView.image = dayImage
            dayImageView.alpha = 0.4
            self.addSubview(dayImageView)
            
            weekImageViews[i] = dayImageView
        }
    }
    
    
    
    // Highlit day and change week
    func highlightDay(date : NSDate) {
        
        // if calendar show the date, change its alpha.
        // if calendar dosen't show the date, remove all views and draw new week, then change alpha
        if contains(weekDayDates, date) {
            
            changeAlpha(date)
        } else {
            
            for i in 0...6 {
                weekImageViews[i].removeFromSuperview()
            }
            addWeekCalendar(date)
            changeAlpha(date)
        }
        
        // change month and year image view
        if (cal.month(date) != monthImageView.tag) {
            monthImageView.removeFromSuperview()
            yearImageView.removeFromSuperview()
            addMonthOfWeekCalendar(date)
        } else if (cal.year(date) != yearImageView.tag) {
            monthImageView.removeFromSuperview()
            yearImageView.removeFromSuperview()
            addMonthOfWeekCalendar(date)
        }
    }
    
    
    // Change alpha to 1.0 of the date
    func changeAlpha(date: NSDate) {
        
        // return all image views to 0.4
        for i in 0...6 {
            weekImageViews[i].alpha = 0.4
        }
        
        // find index from weekdayDates Array
        let i = find(weekDayDates, date)!
        
        // change alpha of the date to 1
        weekImageViews[i].alpha = 1
        
    }
    
    
    // Return Weekday Dates of the date
    func weekDaysFromDate(date: NSDate) -> [NSDate]{
        
        let weekDayNum: Double = Double(cal.weekday(date))
        
        var weekDayNums = [
            NSDate(timeInterval: -(weekDayNum-1)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-2)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-3)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-4)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-5)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-6)*24*60*60, sinceDate: date),
            NSDate(timeInterval: -(weekDayNum-7)*24*60*60, sinceDate: date)
        ]
        
        return weekDayNums
    }
}

extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}