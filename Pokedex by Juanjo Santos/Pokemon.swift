//
//  Pokemon.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import Foundation
import Alamofire


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
    private var _evoName: String!
    private var _evoLvl: String!
    private var _evoId: String!
    private var _pokemonURL: String!
    
    //Getters
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type1: String {
        if _type1 == nil {
            _type1 = ""
        }
        return _type1
    }
    var type2: String {
        if _type2 == nil {
            _type2 = ""
        }
        return _type2
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var evoName: String {
        if _evoName == nil {
            _evoName = ""
        }
        return _evoName
    }
    var evoLvl: String {
        if _evoLvl == nil {
            _evoLvl = ""
        }
        return _evoLvl
    }
    var evoId: String {
        if _evoId == nil {
            _evoId = ""
        }
        return _evoId
    }
        
    
    //Constructor or Initializer
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        
        //Inside the constructor, we define the URL of that specific pokemon
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    //Use our own closure
    func downloadPokemonInfo(completed: DownloadComplete)
    {
        let url = NSURL(string: _pokemonURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            let result = response.result
            //print(result.value?.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                //First make sure it exists, and then use it
                
                //PARSE JSON for Weight
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                //PARSE JSON for Height
                if let height = dict["height"] as? String {
                    self._height = height
                }
                //PARSE JSON for Types
                //                                                              AND condition
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    if let type1 = types[0]["name"] {
                        self._type1 = type1
                    }
                    //If the Dictionary contains more than 1 type
                    if types.count > 1 {
                        if let type2 = types[1]["name"] {
                        self._type2 = type2
                        }
                    } else {
                        //If there is no Second type, just leave it empty
                        self._type2 = ""
                    }
                    
                }
                //PARSE JSON for Evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        //Discard the Mega Evolutions
                        if to.rangeOfString("mega") == nil {
                            //grab the LVL, Name and Id of the Evolution
                            
                            //grab ID from the resource_uri
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                //Filter the uri, grab only the ID from the uri
                                //Step 1: Erase what goes BEFORE the ID
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                //Step 2: Erase what goes AFTER the ID
                                let id = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                //grab the ID
                                self._evoId = id
                                //grab the Name
                                self._evoName = to
                                //grab the LVL
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._evoLvl = "\(lvl)"
                                }
                                
                            }
                        }
                    }
                    
                }
                
                //PARSE JSON for Description
                if let descriptions = dict["descriptions"] as? [Dictionary<String,String>] where descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"] {
                        //Since the JSON includes a URL instead of the actual description,
                        //we need to make another Request with the url provided
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    
                                }
                            }
                            completed() //SAY THAT WE ARE FINISHED DOWNLOADING DATA FROM THE API
                        }
                    }
                } else {
                    self._description = ""
                }
                
                
            }
        }
    }
    
}
