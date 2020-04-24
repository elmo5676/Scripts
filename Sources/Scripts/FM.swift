//
// ********************** FM *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 3/31/20, for DAFIF_NEW_CLI
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** FM *********************************

import Foundation
import Quartz

public enum DocumentDirectories {
    case myDocs
    case downloads
    case portableCode
    case dafif
    case dafifT
    case dafifProcessing
    case docsAppend(String)
}

public struct FM {
    
    static public func getPdfContentsAsString(from: URL) -> String? {
        let pdf = PDFDocument(url: from)
        guard let contents = pdf?.string else { print("could not get string from pdf: \(String(describing: pdf))"); exit(1) }
        return contents
    }
    
    static public func getUrlPaths(of: URL) -> [URL] {
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
    
    static public func workingDir(_ directory: DocumentDirectories) -> URL {
        let myDocs = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!
        switch directory {
        case .myDocs:
            return myDocs
        case .downloads:
            return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        case .portableCode:
            return URL(fileURLWithPath: "/Users/elmo/Dropbox/02_4BitCrew/00_CODE/04_PortableCode", isDirectory: true)
        case .dafif:
            return myDocs.appendingPathComponent("DAFIF8")
        case .dafifT:
            return myDocs.appendingPathComponent("DAFIF8/DAFIFT")
        case .dafifProcessing:
            return myDocs.appendingPathComponent("01_DafifProcessing")
        case .docsAppend(let str):
            return myDocs.appendingPathComponent(str)
        }}
    
    static public func fileUrl(_ dir: DocumentDirectories, fileName: String) -> URL {
        workingDir(dir).appendingPathComponent(fileName)
    }
}
