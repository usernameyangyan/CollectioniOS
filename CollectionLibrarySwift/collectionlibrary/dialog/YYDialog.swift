//
//  YYDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/9.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

public class YYDialog{
    
    static func createAlertDialog()->YYAlertDialog{
        return YYAlertDialog()
    }
    
    static func createLoadingDialog()->YYLoadingDialog{
        return YYLoadingDialog()
    }
    
    static func createToast()->YYToast{
        return YYToast()
    }
    
}
