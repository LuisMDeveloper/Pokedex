//
//  PokeCell.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //Outlets to elements of the cell: Image and Name
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    
    //Create an instance of Pokemon
    var pokemon: Pokemon!
    
    //Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Set Round Corners
        layer.cornerRadius = 5.0
        
    }
    
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        //Set name
        nameLbl.text = self.pokemon.name.capitalizedString
        //Set image
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        //Set id
        idLbl.text = "#"+"\(self.pokemon.pokedexId)"
    }
    
    func configureShinyCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        //Set name
        nameLbl.text = self.pokemon.name.capitalizedString
        //Set image
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)"+"s")
        //Set id
        idLbl.text = "#"+"\(self.pokemon.pokedexId)"
    }
    
    
}
