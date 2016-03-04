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
    private var _description: String!
    private var _type1: String!
    private var _type2: String!
    private var _height: String!
    private var _weight: String!
    private var _evo1Name: String!
    private var _evo2Name: String!
    private var _evo1Lvl: String!
    private var _evo2Lvl: String!
    
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
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
