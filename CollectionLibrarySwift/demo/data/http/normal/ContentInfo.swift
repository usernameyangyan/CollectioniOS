//
//  File.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class ContentInfo:YYTableViewItem,Convertible{
    
    var sid:String=""
    var text:String=""
    var type:String=""
    var thumbnail:String=""
    var video:String=""
    var images:String=""
    var up:String=""
    var down:String=""
    var forward:String=""
    var comment:String=""
    var uid:String=""
    var name:String=""
    var header:String=""
    var top_comments_content:String=""
    var top_comments_voiceuri:String=""
    var top_comments_uid:String=""
    var top_comments_name:String=""
    var top_comments_header:String=""
    var passtime:String=""
    
    
    required override init(){
        super.init()
        cellHeight=80
    }
}
