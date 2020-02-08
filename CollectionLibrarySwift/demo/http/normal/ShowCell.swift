//
//  ShowCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/4.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class ShowCell:YYTableViewCell{
    lazy var img:UIImageView={
        let img=UIImageView.init()
        img.image=UIImage(named: "b")
        img.layer.cornerRadius = 25
        img.layer.masksToBounds = true
        return img
    }()
    
    
    lazy var title:UILabel={
        let titleLab=UILabel.init()
        titleLab.numberOfLines=1
        titleLab.lineBreakMode = NSLineBreakMode.byTruncatingTail
        titleLab.textColor=UIColor.black
        titleLab.font=UIFont.systemFont(ofSize: 16)
        return titleLab
    }()
    
    lazy var descripe:UILabel={
        let descripe=UILabel.init()
        descripe.numberOfLines=1
        descripe.lineBreakMode = NSLineBreakMode.byTruncatingTail
        descripe.textColor=UIColor.gray
        descripe.font=UIFont.systemFont(ofSize: 14)
        return descripe
    }()
    
    lazy var time:UILabel={
        let time=UILabel.init()
        time.numberOfLines=1
        time.lineBreakMode = NSLineBreakMode.byTruncatingTail
        time.textColor=UIColor.gray
        time.font=UIFont.systemFont(ofSize: 12)
        return time
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(img)
        self.contentView.addSubview(title)
        self.contentView.addSubview(descripe)
        self.contentView.addSubview(time)
        
        img
            .centerY(equalTo: self.contentView.yy_centerY)
            .left(equalTo: self.contentView.yy_left,constant: 10)
            .width(50)
            .height(50)
            .build()
        
        title
            .left(equalTo: self.img.yy_right,constant: 10)
            .right(equalTo: self.contentView.yy_right,constant: 10)
            .centerY(equalTo: self.contentView.yy_centerY,constant: -20)
            .build()
        
        descripe
            .left(equalTo: self.img.yy_right,constant: 10)
            .right(equalTo: self.contentView.yy_right,constant: 10)
            .centerY(equalTo: self.contentView.yy_centerY)
            .build()
        
        time
            .left(equalTo: self.img.yy_right,constant: 10)
            .right(equalTo: self.contentView.yy_right,constant: 10)
            .centerY(equalTo: self.contentView.yy_centerY,constant: 20)
            .build()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        let item=self.item as! ContentInfo
        img.loadImage(urlString:item.thumbnail,placeholder: UIImage.init(named: "b"))
        
        title.text=item.name
        descripe.text=item.text
        time.text=item.passtime
    }
    
    
    
    override func draw(_ rect: CGRect) {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //#FF4500
        context.setStrokeColor(UIColor.colorWithHexString("#D2D3D5").cgColor)
        context.stroke(CGRect(x:0, y: rect.size.height, width: rect.size.width, height:1))
    }
    
}
