//
//  pokemonAPIClient.swift
//  PairProject
//
//  Created by Oniel Rosario on 1/9/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import Foundation

final class APIClient {
    
    static func getPokemons(completionHandler: @escaping (AppError?, [PokemonCard]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks")
        { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completionHandler(nil, pokemon.cards)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
