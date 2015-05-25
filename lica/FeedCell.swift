//
//  FeedCell.swift
//  lica
//
//  Created by ukn on 5/24/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    var mainImageView: UIImageView
    var dateImageView: UIImageView
    var title1: UILabel
    var title2: UILabel
    var dataSouce: Dictionary<String, String>
    var topMargin: CGFloat
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        mainImageView = UIImageView()
        dateImageView = UIImageView()
        title1 = UILabel()
        title2 = UILabel()
        dataSouce = Dictionary()
        topMargin = 30
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setContents(data: Dictionary<String, String>) {
        
        var height: CGFloat = topMargin
        
        // Set Image
        if (!data["image"]!.isEmpty) {
            
            var mainImage: UIImage = UIImage(named: data["image"]!)!
            
            mainImageView.image = mainImage
            mainImageView.frame = CGRectMake(0, height, self.frame.width, mainImage.size.height * self.frame.width/mainImage.size.width)
            self.addSubview(mainImageView)
            
            height = calcOwnPosY(mainImageView) + 24
        }
        
        //Set date
        var dateImage: UIImage = UIImage(named: "date")!
        dateImageView.image = dateImage
        dateImageView.frame = CGRectMake(self.frame.size.width/2 - dateImage.size.width/2, height, dateImage.size.width
            , dateImage.size.height)
        self.addSubview(dateImageView)
        
        height = calcOwnPosY(dateImageView)
        
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
        let separator: UIView = UIView(frame: CGRectMake(self.frame.size.width/2 - self.frame.size.width/20, height + 32, self.frame.size.width/10, 1))
        separator.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.addSubview(separator)
        
        height = calcOwnPosY(separator)
        
        
        //Height of own cell
        self.frame.size.height = height
    }
    
    
    func setTitle(title: UILabel, text: String, height: CGFloat) {
        
        title.frame = CGRectMake(16, height, self.frame.size.width - 32, 18)
        title.text = text
        title.font = UIFont(name: "HiraMinProN-W3", size: 16)
        title.textAlignment = NSTextAlignment.Center
        self.addSubview(title)
    }
    
    func calcOwnPosY(view: UIView) -> CGFloat {
        
        return view.frame.origin.y + view.frame.size.height
    }
}
