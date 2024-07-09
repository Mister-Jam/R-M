//
//  ListItemCellModel.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 09/07/2024.
//

import Foundation

struct ListItemCellModel {
    let id: Int
    let characterTitle: String
    let characterImage: String
    let nextPageUrl: String?
    let characterDetails: CharacterDetailsModel
    var nextPageAvailable: Bool {
        return nextPageUrl.isNotNil
    }
    var nextPageIndex: Int? {
        guard let url = URL(string: nextPageUrl ?? .emptyString) else { return nil }
        let query = url.query()
        return Int(query?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() ?? .emptyString)
    }
}

enum RowOptions: String {
    case created = "Created"
    case status = "Status"
    case species = "Species"
    case gender = "Gender"
    case origin = "Origin"
    case location = "Location"
    case episodesAppeared = "Episodes Appeared"
}

struct RowModel: Hashable {
    let leadingText: String
    let trailingText: String
    
    init(option: RowOptions, trailingText: String) {
        self.leadingText = option.rawValue
        self.trailingText = trailingText
    }
}

struct CharacterDetailsModel {
    let characterName: String
    let characterImageString: String
    let episodes: [String]
    let created: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    var rowModels: [RowModel] {
        return [
            RowModel(
                option: .created,
                trailingText: created),
            
            RowModel(
                option: .status,
                trailingText: status),
            
            RowModel(
                option: .species,
                trailingText: species),
            
            RowModel(
                option: .gender,
                trailingText: gender),
            
            RowModel(
                option: .origin,
                trailingText: origin),
            
            RowModel(
                option: .location,
                trailingText: location),
            
            RowModel(
                option: .episodesAppeared,
                trailingText: .emptyString)
        ]
    }
    
    var characterUrl: URL? {
        return URL(string: characterImageString)
    }
    
    static let previewVersion: CharacterDetailsModel = CharacterDetailsModel(
        characterName: "Rick Sanchez", 
        characterImageString: .emptyString,
        episodes: ["1", "2", "3"],
        created: "The past",
        status: "Alive",
        species: "Human",
        gender: "Male",
        origin: "Earth",
        location: "Earty")
}
