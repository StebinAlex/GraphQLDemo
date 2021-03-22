//
//  Apollo.swift
//  GraphQLDemo
//
//  Created by Stebin Alex on 19/03/21.
//

import Foundation

import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}
