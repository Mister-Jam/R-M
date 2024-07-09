//
//  CharacterDetailsView.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 09/07/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let characterDetails: CharacterDetailsModel
    
    init(characterDetails: CharacterDetailsModel) {
        self.characterDetails = characterDetails
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                APIImage(imageUrl: characterDetails.characterUrl)
                ForEach(characterDetails.rowModels, id: \.self) { element in
                    HStack(alignment: .firstTextBaseline, spacing: 20, content: {
                        Text(element.leadingText)
                            .borderedText()
                        
                        Spacer()
                        
                        Text(element.trailingText)
                            .bold()
                    })
                }
                
                ForEach(characterDetails.episodes, id: \.self) {
                    Text($0)
                        .frame(alignment: .center)
                }
            }
            .padding()
            .navigationTitle(characterDetails.characterName)
        }
    }
}

#Preview {
    CharacterDetailsView(characterDetails: CharacterDetailsModel.previewVersion)
}
