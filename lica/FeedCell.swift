//
//  FeedCell.swift
//  lica
//
//  Created by ukn on 5/24/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    let mainImageView: UIImageView
    let dateImageView: UIImageView
    let dateLabel: UILabel
    let title1: UILabel
    let title2: UILabel
    let separator: UIView
    var dataSouce: Dictionary<String, String>
    var topMargin: CGFloat
    var height: CGFloat
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        mainImageView = UIImageView()
        dateImageView = UIImageView()
        dateLabel = UILabel()
        title1 = UILabel()
        title2 = UILabel()
        separator = UIView()
        dataSouce = Dictionary()
        topMargin = 30
        height = 100
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // no color when selected
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func calcContentsHeight(data: Dictionary<String, String>) {
        
        height = topMargin
        
        // Set Image
        if (!data["image"]!.isEmpty) {
            
            var mainImage: UIImage = UIImage(named: data["image"]!)!
            
            mainImageView.image = mainImage
            mainImageView.frame = CGRectMake(0, height, self.frame.width, mainImage.size.height * self.frame.width/mainImage.size.width)
            
            height = calcOwnPosY(mainImageView) + 24
        } else if (topMargin == 0) {
            
            //When the first cell(today's cell) has an image,
            //viewController makes top margin 0
            //but if the cell dosent have an image, top margin should be 30
            height = 30
        }
        
        //Set date
        dateLabel.frame = CGRectMake(0, height, self.frame.size.width, 14)
        dateLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 9)
        dateLabel.textColor = UIColor.hexStr("666666", alpha: 1)
        dateLabel.textAlignment = NSTextAlignment.Center
        let attributedText = NSMutableAttributedString(string: dateTextFromData(data))
        attributedText.addAttribute(NSKernAttributeName, value:1.4, range: NSMakeRange(0, attributedText.length))
        dateLabel.attributedText = attributedText
        
        height = calcOwnPosY(dateLabel)
        
        //Set Title1
        if (!data["title1"]!.isEmpty) {
            
            setTitle(title1, text: data["title1"]!, height: height + 10)
            height = calcOwnPosY(title1)
        }
        
        //Set Title2
        if (!data["title2"]!.isEmpty) {
            
            setTitle(title2, text: data["title2"]!, height: height + 10)
            height = calcOwnPosY(title2)
        }
        
        //Set Separator
        separator.frame = CGRectMake(self.frame.size.width/2 - self.frame.size.width/20, height + 32, self.frame.size.width/10, 1)
        separator.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        height = calcOwnPosY(separator)
        
    }
    
    func setContents(data: Dictionary<String, String>) {
        
        calcContentsHeight(data)
        
        if (!data["image"]!.isEmpty) {
            self.addSubview(mainImageView)
        }
        
        self.addSubview(dateLabel)
        
        if (!data["title1"]!.isEmpty) {
            self.addSubview(title1)
        }
        
        if (!data["title2"]!.isEmpty) {
            self.addSubview(title2)
        }
        
        self.addSubview(separator)
        
    }
    
    
    func setTitle(title: UILabel, text: String, height: CGFloat) {
        
        title.frame = CGRectMake(16, height, self.frame.size.width - 32, 18)
        title.text = text
        title.font = UIFont(name: "HiraMinProN-W3", size: 16)
        title.textAlignment = NSTextAlignment.Center
        //self.addSubview(title)
    }
    
    func calcOwnPosY(view: UIView) -> CGFloat {
        
        return view.frame.origin.y + view.frame.size.height
    }
    
    
    // Date from Data
    func dateTextFromData(data: Dictionary<String, String>) -> String {
        
        let dateString = data["date"]!
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let date: NSDate! = formatter.dateFromString(dateString)
        
        let weekdays: Array = ["Sunday", "Monday", "Tuseday", "Wednesday", "Thusday", "Friday", "Saturday"]
        let months: Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        
        let cal: Cal = Cal()
        let dateText:String = "\(weekdays[cal.weekday(date)-1]) \(cal.day(date)) \(months[cal.month(date)-1]), \(cal.year(date))"
        
        
        return dateText
    }
}
