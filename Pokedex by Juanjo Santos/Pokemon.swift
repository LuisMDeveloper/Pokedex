//
//  Pokemon.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import Foundation



class Pokemon
{
    //Atrtibutes
    private var _name: String!
    private var _pokedexId: Int!
    
    //Getters
    var name: String
    {
       return _name
    }
    
    var pokedexId: Int
    {
        return _pokedexId
    }
    
    //Constructor or Initializer
    init(name: String, pokedexId: Int)
    {
        _name = name
        _pokedexId = pokedexId
    }
    
}
