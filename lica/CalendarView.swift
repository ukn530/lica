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
    //var calendarHeight: CGFloat = 320
    
    var monthImageView: UIView!
    var weekImageViews = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]

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
            self.addSubview(dayImageView)
        }
    }
}