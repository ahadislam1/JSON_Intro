//
//  GOTEpisode.swift
//  JSON_Intro
//
//  Created by Ahad Islam on 11/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case decodingError(Error)
}

struct GOTEpisode: Codable {
    
    // MARK: - Internal Properties
    
    let name: String
    let runtime: Int
    let summary: String
    let image: ImageWrapper
    
    // MARK: - Static Methods
    
    static func getEpisodes(from data: Data) throws -> [GOTEpisode] {
        // need to read more on errors.
        do {
            //what is do?
            let episodes = try JSONDecoder().decode([GOTEpisode].self, from:
                data)
            //what is try?
            return episodes
        } catch {
            //what is catch?
            throw JSONError.decodingError(error)
            //what is throw?
        }
    }
    
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
