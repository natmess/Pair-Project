//
//  magicAPIClient.swift
//  PairProject
//
//  Created by Oniel Rosario on 1/9/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import Foundation

final class magicAPIClient {
    static func getMagics(completionHandler: @escaping (AppError?, [Magic]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.magicthegathering.io/v1/cards?contains=imageUrl")
        { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(AppError.badURL(appError.errorMessage()), nil)
            } else if let data = data {
                do {
                    let cards = try JSONDecoder().decode(Magic.self, from: data)
                    completionHandler(nil, [cards])
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}