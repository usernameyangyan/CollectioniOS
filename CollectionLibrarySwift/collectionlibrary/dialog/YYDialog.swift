//
//  YYDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/9.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class YYDialog{
    
    public static func createAlertDialog()->YYAlertDialog{
        return YYAlertDialog()
    }
    
    public static func createLoadingDialog()->YYLoadingDialog{
        return YYLoadingDialog()
    }
    
    public static func createToast()->YYToast{
        return YYToast()
    }
    
}
