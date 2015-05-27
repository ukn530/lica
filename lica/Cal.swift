//
//  date.swift
//  lica
//
//  Created by 内田 達也 on 2015/05/27.
//  Copyright (c) 2015年 ukn. All rights reserved.
//

import Foundation


class Cal {
    
    func year(date: NSDate) -> Int {
        
        let calendar: NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: date)
        
        return comps.year
    }
    
    func month(date: NSDate) -> Int {
        
        let calendar: NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.MonthCalendarUnit, fromDate: date)
        
        return comps.month
    }
    
    func day(date: NSDate) -> Int {
        
        let calendar: NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        
        return comps.day
    }
    
    func weekday(date: NSDate) -> Int {
        
        let calendar: NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        var comps: NSDateComponents = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        
        return comps.weekday
    }
    
}
