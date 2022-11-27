//
// ********************** FM *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 3/31/20, for DAFIF_NEW_CLI
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** FM *********************************

import Foundation
import PDFKit
//import Quartz

public enum DocumentDirectories {
    case dropBox(String)
    case downloadsAir
    case downloadsPro
    case documentsAir
    case documentsPro
    case desktopAir
    case desktopPro
    case dropBoxMain13
    case logBook
    case myDocs
    case downloads
    case portableCode
    case dafif
    case dafifT
    case dafifProcessing
    case homeDirectory
    case docsAppend(String)
}

@available(iOS 13.0, *)
public struct FM {
    
    static public func getDataFrom(_ url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            return data
        } catch {
            print(error)
            return nil
        }
    }

    static public func getDataFrom(folder: URL, withLastComponent: String) -> Data? {
        let folderContents = FM.getUrls(of: folder)
        for file in folderContents {
            if file.lastPathComponent == withLastComponent {
                let data = getDataFrom(file)
                return data
            }
        }
        return nil
    }
      
    static public func getUrls(of: URL) -> [URL] {
        var result: [URL] = []
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: of, includingPropertiesForKeys: nil, options: [])
            for folderPath in contents {
                let fileName = folderPath.lastPathComponent
                if fileName.first != "." {
                    result.append(folderPath)
                }}} catch { print(error) }
        return result
    }
    
    static public func getPaths(of: URL) -> [String] {
        var result: [String] = []
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: of, includingPropertiesForKeys: nil, options: [])
            for folderPath in contents {
                let fileName = folderPath.lastPathComponent
                if fileName.first != "." {
                    result.append(folderPath.path)
                }}} catch { print(error) }
        return result
    }
    
    static public func getFile(_ filename: URL) -> String {
        var result = ""
        do {
            let fileUrl: URL = filename
            let data = try Data(contentsOf: fileUrl)
            result = String(decoding: data, as: UTF8.self)
        } catch {
            print(error)
        }
        return result
    }
    
    static public func write(content: Data, to: URL, namePlusExt: String) {
        let fileName = "\(namePlusExt)"
        let path = to.appendingPathComponent(fileName)
        do {
            try content.write(to: path, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    static public func write(content: String, to: URL, namePlusExt: String) {
        let fileName = "\(namePlusExt)"
        let path = to.appendingPathComponent(fileName)
        let contentData = Data(content.utf8)
        do {
            try contentData.write(to: path, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    static public func writeStr(_ content: String, to: URL, namePlusExt: String) {
        let fileName = "\(namePlusExt)"
        let path = to.appendingPathComponent(fileName)
        let contentData = Data(content.utf8)
        do {
            try contentData.write(to: path, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    
    
    #if os(macOS) 
    static public func workingDir(_ directory: DocumentDirectories) -> URL {
        let myDocs = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!
        switch directory {
        case .dropBoxMain13:        return URL(fileURLWithPath: "/Users/elmo/Dropbox", isDirectory: true)
        case .dropBox(let str):     return URL(fileURLWithPath: "/Users/matthewelmore/Dropbox", isDirectory: true).appendingPathComponent(str)
        case .logBook:              return FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Dropbox/01_Personal/08_Aviation/LogBookData")
        case .myDocs:               return myDocs
        case .downloads:            return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        case .portableCode:         return URL(fileURLWithPath: "/Users/elmo/Dropbox/02_4BitCrew/00_CODE/04_PortableCode", isDirectory: true)
        case .dafif:                return myDocs.appendingPathComponent("DAFIF8")
        case .dafifT:               return myDocs.appendingPathComponent("DAFIF8/DAFIFT")
        case .dafifProcessing:      return myDocs.appendingPathComponent("01_DafifProcessing")
        case .homeDirectory:        return FileManager.default.homeDirectoryForCurrentUser
        case .docsAppend(let str):  return myDocs.appendingPathComponent(str)
        case .downloadsAir:
            return URL(fileURLWithPath: "/Users/matthewelmore/Dropbox/Mac (3)/Downloads")
//            /Users/matthewelmore/Dropbox/Mac\ \(3\)/Downloads
        case .downloadsPro:
            return URL(string: "/Users/matthewelmore/Dropbox/Mac%20(3)/Downloads.")!
        case .documentsAir:
            return URL(string: "/Users/matthewelmore/Dropbox/Mac%20(3)/Downloads..")!
        case .documentsPro:
            return URL(string: "/Users/matthewelmore/Dropbox/Mac%20(3)/Downloads..ds")!
        case .desktopAir:
            return URL(string: "/Users/matthewelmore/Dropbox/Mac%20(3)/Downloads..xs")!
        case .desktopPro:
            return URL(string: "/Users/matthewelmore/Dropbox/Mac%20(3)/Downloads..x")!
        }}
    
    static public func fileUrl(_ dir: DocumentDirectories, fileName: String) -> URL {
        workingDir(dir).appendingPathComponent(fileName)
    }
    
    #endif
    
    
    // MARK: - 🔅 PDF Stuff
    static public func getPdfContentsAsString(from: URL) -> String? {
        let pdf = PDFDocument(url: from)
        guard let contents = pdf?.string else { print("could not get string from pdf: \(String(describing: pdf))"); exit(1) }
        return contents
    }
    
    static public func getAttributedPDFContents(from: URL?) -> NSMutableAttributedString? {
        guard let url = from else { return nil }
        var result: NSMutableAttributedString?
        if let pdf = PDFDocument(url: url) {
            let pageCount = pdf.pageCount
            let documentContent = NSMutableAttributedString()

            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            result = documentContent
        }
        return result
    }
    
    static public func getPdfPages(pdf: URL, start: Int?, numOfPages: Int?) -> String {
        guard let start = start else { return "" }
        guard let numOfPages = numOfPages else { return "" }
        var result = ""
        guard let pdf = PDFDocument(url: pdf) else { return "NONE" }
        for i in 0..<numOfPages {
            result += pdf.page(at: start + i)?.string ?? ""
        }
        return result
    }
    
    
    static public func getPageCount(from: URL) -> Int {
        guard let pdf = PDFDocument(url: from) else { return 0 }
        return pdf.pageCount
    }
    
    static public func getFirstPageWith(string: String, from: URL) -> Int? {
        guard let pdf = PDFDocument(url: from) else { return nil }
        let count = pdf.pageCount
        for i in 0..<count {
            let searchPage = pdf.page(at: i)?.string ?? ""
            if searchPage.containsMatch(of: string) {
                return i
            }
        }
        return nil
    }
    
}
