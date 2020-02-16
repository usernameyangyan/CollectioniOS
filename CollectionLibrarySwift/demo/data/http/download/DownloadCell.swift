//
//  DownloadCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/20.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DownloadItem:YYTableViewItem{
    var downloadUrl: String!
    
    override init() {
        super.init()
        cellHeight=70
    }
}

class DownloadCell:YYTableViewCell{
    
    lazy var progressView:UIProgressView={
        let progressView=UIProgressView(progressViewStyle: .bar)
        progressView.progress=0
        progressView.progressTintColor=UIColor.blue //已有进度颜色
        progressView.trackTintColor=UIColor.lightGray
        progressView.layer.cornerRadius=10
        return progressView
    }()
    
    lazy var progressTip:UILabel={
        let progressTip=UILabel()
        progressTip.numberOfLines=0
        progressTip.lineBreakMode = NSLineBreakMode.byWordWrapping
        progressTip.textAlignment = .center
        progressTip.textColor=UIColor.red
        progressTip.font=UIFont.systemFont(ofSize: 15)
        progressTip.text="0%"
        return progressTip
    }()
    
    lazy var deleteBtn:UILabel={
        let deleteBtn=UILabel()
        deleteBtn.numberOfLines=0
        deleteBtn.text="删除"
        deleteBtn.backgroundColor=UIColor.lightGray
        deleteBtn.lineBreakMode = NSLineBreakMode.byWordWrapping
        deleteBtn.font=UIFont.systemFont(ofSize: 16)
        deleteBtn.layer.cornerRadius=6.0
        deleteBtn.clipsToBounds=true
        deleteBtn.textAlignment = .center
        deleteBtn.textColor=UIColor.blue
        deleteBtn.tag=1
        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButton(tap:)))
        //绑定tap
        deleteBtn.addGestureRecognizer(tap)
        deleteBtn.isUserInteractionEnabled=true
        
        return deleteBtn
    }()
    
    lazy var clickBtn:UILabel={
        let clickBtn=UILabel()
        clickBtn.numberOfLines=0
        clickBtn.backgroundColor=UIColor.blue
        clickBtn.lineBreakMode = NSLineBreakMode.byWordWrapping
        clickBtn.font=UIFont.systemFont(ofSize: 16)
        clickBtn.layer.cornerRadius=6.0
        clickBtn.clipsToBounds=true
        clickBtn.textAlignment = .center
        clickBtn.textColor=UIColor.white
        clickBtn.tag=0
        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButton(tap:)))
        //绑定tap
        clickBtn.addGestureRecognizer(tap)
        clickBtn.isUserInteractionEnabled=true
        
        return clickBtn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(progressView)
        self.contentView.addSubview(progressTip)
        self.contentView.addSubview(clickBtn)
        self.addSubview(deleteBtn)
        
        progressView
            .centerY(equalTo: self.contentView.yy_centerY)
            .left(equalTo: self.contentView.yy_left,constant: 20)
            .height(20)
            .width(150)
            .build()
        
        progressTip
            .centerY(equalTo: self.contentView.yy_centerY)
            .left(equalTo: progressView.yy_right,constant: 10)
            .height(20)
            .width(55)
            .build()
        
        deleteBtn
            .centerY(equalTo: self.contentView.yy_centerY)
            .right(equalTo: self.contentView.yy_right,constant: 10)
            .height(30)
            .width(50)
            .build()
        
        clickBtn
            .centerY(equalTo: self.contentView.yy_centerY)
            .right(equalTo: self.deleteBtn.yy_left,constant: 10)
            .height(30)
            .width(50)
            .build()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func cellWillAppear() {
        super.cellWillAppear()
        let item = self.item as! DownloadItem
        
        DataManager.DataForHttp.HttpOfDownload.Download.resume(url: item.downloadUrl, downloadResume: {
            self.updateCell()
        })
        
        
        
    }
    
    
    //MARK:自定义底部分割线
    override func draw(_ rect: CGRect) {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //#FF4500
        context.setStrokeColor(UIColor.colorWithHexString("#D2D3D5").cgColor)
        context.stroke(CGRect(x:0, y: rect.size.height, width: rect.size.width, height:1))
    }
    
    
    @objc func clikButton(tap:UITapGestureRecognizer) {
        let pos=tap.view?.tag
        switch pos {
        case 0:
            let item = self.item as! DownloadItem
            let url = item.downloadUrl
            let downloadStatus = DataManager.DataForHttp.HttpOfDownload.Download.downloadStatus(url!)
            switch downloadStatus {
            case .complete:
            break     /// 完成
            case .downloading:  /// 暂停
                DataManager.DataForHttp.HttpOfDownload.Download.downloadCancel(url!)
                self.updateCell()
            case .suspend:      /// 下载
                
                let downloadParams:HttpDownloadRequestParams=HttpDownloadRequestParams()
                downloadParams
                    .setFileName(fileName: "\(item.indexPath.row)---.pdf")
                    .setReqUrl(requestUrl: url!)
                    .build()
                
                DataManager.DataForHttp.HttpOfDownload.Download.download(httpDownloadRequestParams: downloadParams, requestSuccessResult: {
                    respone in
                    self.updateCell()
                },requestFailureResult: {
                    error in
                    
                },downloadProgress: {
                    progress in
                    self.updateCell()
                })
            }
            break
        case 1:
            let item = self.item as! DownloadItem
            let url = item.downloadUrl
            DataManager.DataForHttp.HttpOfDownload.Download.downloadDelete(url!) { [weak self] (result) in
                if result {
                    self?.updateCell()
                } else {
                    print("删除失败")
                }
            }
            break
        default:
            break
        }
    }
    
    
    /// button状态
    func buttonStatus(_ status: DownloadStatus) -> String {
        switch status {
        case .suspend:
            return "开始"
        case .complete:
            return "完成"
        case .downloading:
            return "暂停"
        }
    }
    
    func updateCell() {
        
        let item = self.item as! DownloadItem
        
        let progress = DataManager.DataForHttp.HttpOfDownload.Download.downloadPercent(item.downloadUrl)
        progressView.progress = Float(progress)
        let status:DownloadStatus = DataManager.DataForHttp.HttpOfDownload.Download.downloadStatus(item.downloadUrl)
        self.clickBtn.text=self.buttonStatus(status)
        
        self.progressTip.text = String(format:"%.1f",progress*100)+"%"
        self.deleteBtn.isEnabled = progress == 0 ? false : true
        self.deleteBtn.isUserInteractionEnabled = progress == 0 ? false : true
        
    }
}
