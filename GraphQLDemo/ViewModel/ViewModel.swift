//
//  ApiCalls.swift
//  GraphQLDemo
//
//  Created by Stebin Alex on 19/03/21.
//

import Foundation
import Apollo

class ViewModel {
    var recievedCountries: (([GetCountriesListQuery.Data.Country])->())?
    var gotDetails: ((SpecificCountryQuery.Data.Country)->())?
    init() {
        Network.shared.apollo.fetch(query: GetCountriesListQuery()) { (result) in
            switch result {
            case .success(let result):
                if let countries = result.data?.countries {
                    self.recievedCountries?(countries)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getCountryDetails(code: GraphQLID) {
        Network.shared.apollo.fetch(query: SpecificCountryQuery(country: code)) { (result) in
            switch result {
            case .success(let result):
                if let country = result.data?.country {
                    self.gotDetails?(country)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
