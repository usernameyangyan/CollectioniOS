//
//  InternationalUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/17.
//  Copyright © 2019 YoungManSter. All rights reserved.
//应用内多语言设置
//

import UIKit


fileprivate let UserLanguage   = "UserLanguage"
fileprivate let AppleLanguages = "AppleLanguages"

public enum LanguageType: Int {
    case Chinese = 0
    case English = 1
    case Traditional = 2
}

public class InternationalUtils{
    
    /// 单例
    public static var getInstance: InternationalUtils {
        struct Static {
            static let instance: InternationalUtils = InternationalUtils()
        }
        return Static.instance
    }
    
    
    private var bundle: Bundle?
    
    /// 获取国际化语言
    ///
    /// - Parameter key: key
    /// - Returns: 国际化语言
    public func getString(_ key: String) -> String {
        let bundle = InternationalUtils.getInstance.bundle
        let str = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return str ?? ""
    }
    
    public func getString(_ tableName : String,_ key: String) -> String {
        let bundle = InternationalUtils.getInstance.bundle
        let str = bundle?.localizedString(forKey: key, value: nil, table: tableName)
        return str ?? ""
    }
    
    
    /// 初始化语言 Appdelegate 中使用,建议在Window加载前调用，就不会出现因为加载过快导致第一个界面语言没有国际化的现象
    public func initUserLanguage() {
        var str = UserDefaults.standard.value(forKey: UserLanguage) as? String
        if str?.count == 0 || str == nil {
            let languages = UserDefaults.standard.object(forKey: AppleLanguages) as? NSArray
            if languages?.count != 0 {
                let current = languages?.object(at: 0) as? String
                if current != nil {
                    str = current ?? ""
                   
                }
            }
        }
        
        
        
        
        str = str?.replacingOccurrences(of: "-CN", with: "")
        str = str?.replacingOccurrences(of: "-US", with: "")
        if(str!.contains("zh-Hant")){
            str = str?.replacingOccurrences(of: str!, with: "zh-HK")
        }
        

        var path = Bundle.main.path(forResource: str, ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        bundle = Bundle(path: path!)
    }
    
    
    /// 设置当前语言
    ///
    /// - Parameter language: 当前语言
   public func setLanguage(_ type: LanguageType,_ rootViewController:UIViewController) {
        var str = ""
        switch type {
        case .Chinese:
            str = "zh-Hans"
        case .English:
            str = "en"
        case .Traditional:
            str = "zh-HK"
        }
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        bundle = Bundle(path: path!)
        UserDefaults.standard.set(str, forKey: UserLanguage)
        UserDefaults.standard.synchronize()
        
        
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
    }
    
    /// 当前语言
    ///
    /// - Returns: 当前语言类型
    public func getCurrentLanguage() -> String {
        return UserDefaults.standard.value(forKey: UserLanguage) as! String
    }
    
}
