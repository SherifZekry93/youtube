//
//  ApiService.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/8/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
class ApiService
{
    static let shared = ApiService()
    func fetchSongs(url:String,completion:@escaping ([Song]) -> ())
    {
        if let url = URL(string: url)
        {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil
                {
                    return
                }
                do
                {
                    var allSongs: [Song] = []
                    if let songData = data
                    {
                        let songs = try JSONDecoder().decode([Song].self, from: songData)
                        allSongs = songs
                        DispatchQueue.main.async
                        {
                                completion(allSongs)
                        }
                    }
                    
                }
                catch let error
                {
                    print(error)
                }
                }.resume()
        }
    }
}
