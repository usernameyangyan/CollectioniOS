//
//  DefaultDataShowViewParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public class DefaultDataShowViewParams{
    
    public enum ShowViewType{
        case noData
        case noNetWork
        case loading
    }
    
    public init() {
        
    }
    
    fileprivate var showViewType:ShowViewType = .noData
    fileprivate var defaultNoDataShowImg="nodata"
    fileprivate var defaultNoNetworkShowImg="nonetwork"
    fileprivate var defaultImgWidth:CGFloat=150
    fileprivate var defaultImgHeight:CGFloat=150
    fileprivate var defaultShowNoDataText:String="暂无数据"
    fileprivate var defaultShowNoNetWorkText:String="网络出错"
    fileprivate var defaultShowLoadingText:String="正在加载"
    fileprivate var defaultShowTextSize:CGFloat=15
    fileprivate var defaultShowTextColor:UIColor=UIColor.gray
    fileprivate var defaultShowButtonText:String="重新加载"
    fileprivate var defaultShowButtonTextSize:CGFloat=12
    fileprivate var defaultShowButtonTextColor:UIColor=UIColor.red
    fileprivate var defaultShowButtonBorderWidth:CGFloat=1
    fileprivate var defaultShowButtonBorderColor:UIColor=UIColor.red
    fileprivate var defaultSHowButtonPadding:CGFloat=10
    fileprivate var defaultShowButtonCornerRadius:CGFloat=15
    fileprivate var isHiddenShowButton:Bool=false
    fileprivate var defaultShowButtonBackgroundColor:UIColor=UIColor.clear
    fileprivate var defaulutShowLoadingImgsTimeInterval:TimeInterval=1
    fileprivate var defaultLoadingImags:[String]=["default_data_show_loading2","default_data_show_loading3","default_data_show_loading4","default_data_show_loading5","default_data_show_loading6","default_data_show_loading7","default_data_show_loading8","default_data_show_loading9","default_data_show_loading10","default_data_show_loading11","default_data_show_loading12"]
    
    public func setDefaultDataShowViewType(showViewType:ShowViewType)->DefaultDataShowViewParams{
        self.showViewType=showViewType
        return self
    }
    
    func getDefaultDataShowViewType()->ShowViewType{
        return showViewType
    }
    
    public func setDefaultNoDataShowImg(defaultNoDataShowImg:String) -> DefaultDataShowViewParams {
        self.defaultNoDataShowImg=defaultNoDataShowImg
        return self
    }
    
    func getDefaultNoDataShowImg() -> String {
        return defaultNoDataShowImg
    }
    
    public func setDefaultNoNetworkShowImg(defaultNoNetworkShowImg:String) -> DefaultDataShowViewParams {
        self.defaultNoNetworkShowImg=defaultNoNetworkShowImg
        return self
    }
    
    func getDefaultNoNetworkShowImg() -> String {
        return defaultNoNetworkShowImg
    }
    
    public func setDefaultShowImgWidth(defaultImgWidth:CGFloat) -> DefaultDataShowViewParams {
        self.defaultImgWidth=defaultImgWidth
        return self
    }
    
    func getDefaultShowImgWidth() -> CGFloat {
        return defaultImgWidth
    }
    
    public func setDefaultShowImgHeight(defaultImgHeight:CGFloat) -> DefaultDataShowViewParams {
        self.defaultImgHeight=defaultImgHeight
        return self
    }
    
    func getDefaultShowImgHeight() -> CGFloat {
        return defaultImgHeight
    }
    
    public func setDefaultShowNoDataText(defaultShowNoDataText:String) -> DefaultDataShowViewParams {
        self.defaultShowNoDataText=defaultShowNoDataText
        return self
    }
    
    func getDefaultShowNoDataText() -> String {
        return defaultShowNoDataText
    }
    
    public func setDefaultShowNoNetWorkText(defaultShowNoNetWorkText:String) -> DefaultDataShowViewParams {
        self.defaultShowNoNetWorkText=defaultShowNoNetWorkText
        return self
    }
    
    func getDefaultShowNoNetWorkText() -> String {
        return defaultShowNoNetWorkText
    }
    
    public func setDefaultShowTextSize(defaultShowTextSize:CGFloat) -> DefaultDataShowViewParams {
        self.defaultShowTextSize=defaultShowTextSize
        return self
    }
    
    func getDefaultShowTextSize() -> CGFloat {
        return defaultShowTextSize
    }
    
    public func setDefaultShowTextColor(defaultShowTextColor:UIColor) -> DefaultDataShowViewParams {
        self.defaultShowTextColor=defaultShowTextColor
        return self
    }
    
    func getDefaultShowTextColor() -> UIColor {
        return defaultShowTextColor
    }
    
    public func setDefaultShowButtonText(defaultShowButtonText:String) -> DefaultDataShowViewParams {
        self.defaultShowButtonText=defaultShowButtonText
        return self
    }
    
    func getDefaultShowButtonText() -> String {
        return defaultShowButtonText
    }
    
    public func setDefaultShowButtonTextSize(defaultShowButtonTextSize:CGFloat) -> DefaultDataShowViewParams {
        self.defaultShowButtonTextSize=defaultShowButtonTextSize
        return self
    }
    
    func getDefaultShowButtonTextSize() -> CGFloat {
        return defaultShowButtonTextSize
    }
    
    public func setDefaultShowButtonTextColor(defaultShowButtonTextColor:UIColor) -> DefaultDataShowViewParams {
        self.defaultShowButtonTextColor=defaultShowButtonTextColor
        return self
    }
    
    func getDefaultShowButtonTextColor() -> UIColor {
        return defaultShowButtonTextColor
    }
    
    public func setDefaultShowButtonBorderWidth(defaultShowButtonBorderWidth:CGFloat) -> DefaultDataShowViewParams {
        self.defaultShowButtonBorderWidth=defaultShowButtonBorderWidth
        return self
    }
    
    func getDefaultShowButtonBorderWidth() -> CGFloat {
        return defaultShowButtonBorderWidth
    }
    
    public func setDefaultShowButtonBorderColor(defaultShowButtonBorderColor:UIColor) -> DefaultDataShowViewParams {
        self.defaultShowButtonBorderColor=defaultShowButtonBorderColor
        return self
    }
    
    func getDefaultShowButtonBorderColor() -> UIColor {
        return defaultShowButtonBorderColor
    }
    
    public func setDefaultSHowButtonPadding(defaultSHowButtonPadding:CGFloat) -> DefaultDataShowViewParams {
        self.defaultSHowButtonPadding=defaultSHowButtonPadding
        return self
    }
    
    func getDefaultSHowButtonPadding() -> CGFloat {
        return defaultSHowButtonPadding
    }
    
    public func setDefaultShowButtonCornerRadius(defaultShowButtonCornerRadius:CGFloat) -> DefaultDataShowViewParams {
        self.defaultShowButtonCornerRadius=defaultShowButtonCornerRadius
        return self
    }
    
    func getDefaultShowButtonCornerRadius() -> CGFloat {
        return defaultShowButtonCornerRadius
    }
    
    public func setHiddenShowButton(isHiddenShowButton:Bool) -> DefaultDataShowViewParams {
        self.isHiddenShowButton=isHiddenShowButton
        return self
    }
    
    func getHiddenShowButton() -> Bool {
        return isHiddenShowButton
    }
    
    public func setDefaultShowButtonBackgroundColor(defaultShowButtonBackgroundColor:UIColor) -> DefaultDataShowViewParams {
        self.defaultShowButtonBackgroundColor=defaultShowButtonBackgroundColor
        return self
    }
    
    func getDefaultShowButtonBackgroundColor()->UIColor{
        return defaultShowButtonBackgroundColor
    }
    
    
    public func setDefaultLoadingImags(defaultLoadingImags:[String]) -> DefaultDataShowViewParams {
        self.defaultLoadingImags=defaultLoadingImags
        return self
    }
    
    func getDefaultLoadingImags() -> [String] {
        return defaultLoadingImags
    }

    public func setDefaultShowLoadingText(defaultShowLoadingText:String) -> DefaultDataShowViewParams {
        self.defaultShowLoadingText=defaultShowLoadingText
        return self
    }
    
    func getDefaultShowLoadingText() -> String {
        return defaultShowLoadingText
    }
    
    public func setDefaulutShowLoadingImgsTimeInterval(defaulutShowLoadingImgsTimeInterval:TimeInterval) -> DefaultDataShowViewParams {
        self.defaulutShowLoadingImgsTimeInterval=defaulutShowLoadingImgsTimeInterval
        return self
    }
    
    func getDefaulutShowLoadingImgsTimeInterval() -> TimeInterval {
        return defaulutShowLoadingImgsTimeInterval
    }
    
    public func build(){}
    
    
}
