//
//  FileOperationUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/12.
//  Copyright © 2020 YoungManSter. All rights reserved.
//


import UIKit

// 以下所有操作的目录默认为DocumentDirectory
let jkManager = FileManager.default
let baseURL = jkManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!

open class FileOperationUtils: NSObject {
    
    /**
     * 创建文件夹
     */
    public class func createDirectoryAtPath(appendFolderName: String) {
        
        if appendFolderName.isEmpty {
            
            return
        }
        
        let pathURL = baseURL.appendingPathComponent(appendFolderName)
        
        if !jkManager.fileExists(atPath: pathURL.path) {
            
            do {
                try jkManager.createDirectory(at: pathURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
            
        }
        
    }
    
    /**
     * 创建文件
     */
    public class func createFileAtPath(appendFolderPathAndFileName: String) {
        
        if appendFolderPathAndFileName.isEmpty {
            return
        }
        
        let pathURL = baseURL.appendingPathComponent(appendFolderPathAndFileName)
        
        if !jkManager.fileExists(atPath: pathURL.path) {
            
            let data = NSData(base64Encoded:"Operation Success!",
                              options:.ignoreUnknownCharacters)
            
            jkManager.createFile(atPath: pathURL.path,
                                 contents: data as Data?,
                                 attributes: nil)
            
        }
    }
    
    /**
     * 写文件--字符串
     */
    public class func writeToFileAtPath(appendFolderPathAndFileName: String, withString contentStr: String) {
        
        if appendFolderPathAndFileName.isEmpty {
            return
        }
        
        let pathURL = baseURL.appendingPathComponent(appendFolderPathAndFileName)
        
        if(!jkManager.fileExists(atPath: pathURL.path)){
            let append=appendFolderPathAndFileName.split(separator: "/")
            if(append.count>0){
                for str in append{
                    if(str.contains(".")){
                        createFileAtPath(appendFolderPathAndFileName: String(str))
                    }else{
                        createDirectoryAtPath(appendFolderName: String(str))
                    }
                    
                }
                
            }
        }
        
        do{
            
            try contentStr.write(to: pathURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("出现错误")
        }
        
        
    }
    
    /**
     * 读文件
     */
    public class func readFileAtPath(appendFolderPathAndFileName: String) -> String {
        
        
        if appendFolderPathAndFileName.contains(".") {
            
            let pathURL = baseURL.appendingPathComponent(appendFolderPathAndFileName)
            
            
            let content = jkManager.contents(atPath: pathURL.path)
            
            if !(content == nil) {
                
                let dataInFile = NSString(data: content!, encoding: String.Encoding.utf8.rawValue)
                
                return dataInFile! as String
                
            }
        }
        
        
        return ""
    }
    
    /**
     * 获取目录下所有文件
     */
    public class func getAllFilesAtPath(appendDirectoryPathAndName: String) -> [String] {
        
        let pathURL = baseURL.appendingPathComponent(appendDirectoryPathAndName)
        
        if jkManager.fileExists(atPath: pathURL.path) {
            
            let enumeratorAtPath = jkManager.enumerator(atPath: pathURL.path)
            return enumeratorAtPath?.allObjects as! [String]
        }
        
        return []
    }
    
    /**
     * 删除文件
     */
    public class func deleteFileAtPath(appendFilePathAndName: String) {
        
        let pathURL = baseURL.appendingPathComponent(appendFilePathAndName)
        
        if !appendFilePathAndName.isEmpty {
            if jkManager.fileExists(atPath: pathURL.path) {
                
                do {
                    try jkManager.removeItem(at: pathURL)
                } catch {
                    print("您的输入有误，请重新输入")
                }
            } else {
                print("您输入的文件不存在")
            }
        } else {
            print("文件(夹)名不能为空")
        }
        
    }
    
    
    
    /**
     * 判断文件是否存在
     */
    public class func isFileExist(appendFilePathAndName: String) {
        
        if !appendFilePathAndName.isEmpty {
            
            let pathURL = baseURL.appendingPathComponent(appendFilePathAndName)
            
            if jkManager.fileExists(atPath: pathURL.path) {
            }
        } else {
            print("文件不存在或文件为空")
        }
    }
    
    /**
     * 获取某文件属性(计算某文件大小)
     */
    public class func fileSizeAtPath(appendFilePathAndName: String) -> (CLongLong) {
        
        if appendFilePathAndName.isEmpty {
            
            return 0
        }
        
        var fileSize: Int64 = 0
        
        let pathURL = baseURL.appendingPathComponent(appendFilePathAndName)
        
        var isDir: ObjCBool = false
        
        if jkManager.fileExists(atPath: pathURL.path, isDirectory: &isDir) {
            
            do {
                let attributes = try jkManager.attributesOfItem(atPath: pathURL.path)
                
                let size = attributes[FileAttributeKey.size]
                if size == nil {
                    print("\(appendFilePathAndName)大小为 0 ")
                } else {
                    fileSize = (size! as AnyObject).longLongValue
                }
            } catch {
                print("检查文件路径是否异常")
            }
        } else {
            print("此方法不能检测文件夹大小")
        }
        return fileSize
    }
    
    /**
     * 遍历所有子目录， 并计算文件大小
     */
    public class func forderSizeAtPath(appendFolderPathAndName:String) -> CLongLong {
        
        let folderPath=baseURL.appendingPathComponent(appendFolderPathAndName, isDirectory: true).path
        
        if !jkManager.fileExists(atPath: folderPath) {
            return 0
        }
        let array = try! jkManager.contentsOfDirectory(atPath: folderPath)
        
        var fileSize:CLongLong = 0
        for path in array {
            fileSize += FileOperationUtils.fileSizeAtPath(appendFilePathAndName: path)
        }
        return fileSize
    }
}
