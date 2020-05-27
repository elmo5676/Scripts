// ********************** DownloadHandler *********************************
// * Copyright © 4bitCrew, LLC - All Rights Reserved
// * Created on 5/15/20, for Scripts
// * elmo <matt@4bitCrew.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** DownloadHandler *********************************

import Foundation

public struct DownloadHandler {
    
    static public func getDataFrom(url: String, completion: @escaping (Data) -> Void ) {
        let sfSymbols = URL(string: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: sfSymbols!) { (data, response, error) in
            if let error = error {
                print(error)
            }
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}


