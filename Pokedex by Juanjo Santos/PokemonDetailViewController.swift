//
//  PokemonDetailViewController.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var imgLbl: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var type1Lbl: UILabel!
    @IBOutlet weak var type2Lbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var ev1Img: UIImageView!
    @IBOutlet weak var ev1Name: UILabel!
    @IBOutlet weak var ev1Lvl: UILabel!
    @IBOutlet weak var ev2Img: UIImageView!
    @IBOutlet weak var ev2Name: UILabel!
    @IBOutlet weak var ev2Lvl: UILabel!
    
    
    
    var recievedPokemon: Pokemon!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = recievedPokemon.name.capitalizedString
        idLbl.text = "#\(recievedPokemon.pokedexId)"
        imgLbl.image = UIImage(named: "\(recievedPokemon.pokedexId)")
        
        recievedPokemon.downloadPokemonInfo { () -> () in
            //This code will be called AFTER the download is completed.
            
        }
        
        
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

   

}
