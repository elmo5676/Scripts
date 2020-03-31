//
// ********************** FM *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 3/31/20, for DAFIF_NEW_CLI
// * Matthew Elmore <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** FM *********************************

import Foundation

enum DocumentDirectories {
    case myDocs
    case dafif
    case dafifT
    case dafifProcessing
    case docsAppend(String)
}

struct FM {
    
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
    
    static public func write(content: String, to: URL, withName: String) {
        let fileName = "\(withName).swift"
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
        case .dafif:
            return myDocs.appendingPathComponent("DAFIF8")
        case .dafifT:
            return myDocs.appendingPathComponent("DAFIF8/DAFIFT")
        case .dafifProcessing:
            return myDocs.appendingPathComponent("01_DafifProcessing")
        case .docsAppend(let str):
            return myDocs.appendingPathComponent(str)
        }}
}
