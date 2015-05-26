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
    
    var monthImageView: UIView!
    var weekImageViews = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    
    var sundayNum: Int = 3

    //init size and background
    override init(frame: CGRect) {
        
        super.init(frame: CGRectMake(0, 0, screen.size.width, 68))
        
        backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //add week calendar
    func addWeekCalendar() {
        
        //Title (month)
        var monthImage: UIImage = UIImage(named: "title_month")!
        monthImageView = UIImageView(image: monthImage)
        monthImageView.frame = CGRectMake(screen.width/2 - monthImage.size.width/2, 17, monthImage.size.width, monthImage.size.height)
        self.addSubview(monthImageView)
        
        //calc each position of the day
        var amountDayWidth:CGFloat = 0
        
        for i in 0...6 {
            amountDayWidth += UIImage(named: "day_num_\(sundayNum+i)")!.size.width
        }
        var gapBtwDay: CGFloat = (screen.size.width - amountDayWidth)/8
        var lastXOfDay: CGFloat = 0
        
        //Draw Header Day
        for i in 0...6 {
            var dayImage: UIImage = UIImage(named: "day_num_\(sundayNum+i)")!
            var dayImageView: UIImageView = UIImageView(frame: CGRectMake(gapBtwDay+lastXOfDay, 48, dayImage.size.width, dayImage.size.height))
            lastXOfDay = dayImageView.frame.origin.x + dayImage.size.width
            
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
    
    
    func highlightDay(date : NSDate) {
        let calendar: NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        var day = comps.day
        println("day: \(day)")
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