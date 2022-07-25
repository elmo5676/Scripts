// ********************** EnumMaker *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 5/14/20, for SFSymbolEnumGenerator_CLI
// * elmo <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** EnumMaker *********************************

import Foundation

#if MacOS
public struct EnumMaker {
    
    
    public init(enumName: String, cases: [String]){
        makeFontEnum(enumName: enumName, cases: cases)
    }
    
    func makeFontEnum(enumName: String, cases: [String]) {
        
        var caseContent = ""
        
        for case_ in cases {
                    caseContent += "\t\t\(case_)\"\n"
                }
        
        let enumFileContents = """
                                // ********************** \(enumName) *********************************
                                // * Copyright © 4bitCrew, LLC - All Rights Reserved
                                // * Created on <#month#>/<#day#>/<#year#>, for <#ProjectTitle#>
                                // * Matthew Elmore <matt@4bitCrew.com>
                                // * Unauthorized copying of this file is strictly prohibited
                                // ********************** \(enumName) *********************************

                                \tpublic enum \(enumName): String {
                                \(caseContent)
                                \t}
                                """
        
        FM.write(content: enumFileContents, to: FM.workingDir(.myDocs), namePlusExt: "\(enumName).swift")
    }
}
#endif
