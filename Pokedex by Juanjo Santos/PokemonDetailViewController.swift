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
    @IBOutlet weak var ev2Img: UIImageView!
    @IBOutlet weak var ev2Name: UILabel!
    @IBOutlet weak var lvlLbl: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    
    
    var recievedPokemon: Pokemon!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recievedPokemon.downloadPokemonInfo { () -> () in
            //This code will be called AFTER the download is completed.
            //WHEN WE CALL completed()
            
            self.updateUI()
        }
        
        
    }
    
    func updateUI()
    {
        nameLbl.text = recievedPokemon.name.capitalizedString
        idLbl.text = "#\(recievedPokemon.pokedexId)"
        imgLbl.image = UIImage(named: "\(recievedPokemon.pokedexId)")
        descriptionLbl.text = recievedPokemon.description
        var hs = recievedPokemon.height
        var hsc = hs.characters.count
        hsc -= 1
        hs.insert("." as Character, atIndex: hs.startIndex.advancedBy(hsc))
        heightLbl.text = "\(hs)"+" m"
        var ws = recievedPokemon.weight
        var wsc = ws.characters.count
        wsc -= 1
        ws.insert(".", atIndex: ws.startIndex.advancedBy(wsc))
        weightLbl.text = "\(ws)"+" kg"
        if recievedPokemon.evoName != ""
        {
            ev1Img.image = UIImage(named: "\(recievedPokemon.pokedexId)")
            ev1Name.text = recievedPokemon.name.capitalizedString
            ev2Img.image = UIImage(named: "\(recievedPokemon.evoId)")
            ev2Name.text = recievedPokemon.evoName.capitalizedString
            if recievedPokemon.evoLvl != ""
            {
                lvlLbl.text = "LVL \(recievedPokemon.evoLvl)"
            } else {
                lvlLbl.text = "Trade"
            }
            
        } else {
            ev1Img.image = UIImage(named: "\(recievedPokemon.pokedexId)")
            ev1Name.text = recievedPokemon.name.capitalizedString
            arrow.alpha = 0
        }
        type1Lbl.text = recievedPokemon.type1.capitalizedString
        if recievedPokemon.type2 == ""
        {
            type2Lbl.alpha = 0
        } else {
            type2Lbl.text = recievedPokemon.type2.capitalizedString
        }
        type1Lbl.backgroundColor = formatTypeColor(recievedPokemon.type1)
        type2Lbl.backgroundColor = formatTypeColor(recievedPokemon.type2)
    }
    
    func formatTypeColor(type: String) -> UIColor {
        switch type
        {
        case "normal":
            return UIColor(red: 152.0/255.0, green: 152.0/255.0, blue: 101.0/255.0, alpha: 1)
            break
        case "fighting":
            return UIColor(red: 179.0/255.0, green: 32.0/255.0, blue: 29.0/255.0, alpha: 1)
            break
        case "flying":
            return UIColor(red: 151.0/255.0, green: 122.0/255.0, blue: 235.0/255.0, alpha: 1)
            break
        case "poison":
            return UIColor(red: 139.0/255.0, green: 42.0/255.0, blue: 138.0/255.0, alpha: 1)
            break
        case "ground":
            return UIColor(red: 217.0/255.0, green: 179.0/255.0, blue: 86.0/255.0, alpha: 1)
            break
        case "rock":
            return UIColor(red: 170.0/255.0, green: 144.0/255.0, blue: 44.0/255.0, alpha: 1)
            break
        case "bug":
            return UIColor(red: 151.0/255.0, green: 171.0/255.0, blue: 28.0/255.0, alpha: 1)
            break
        case "ghost":
            return UIColor(red: 93.0/255.0, green: 68.0/255.0, blue: 133.0/255.0, alpha: 1)
            break
        case "steel":
            return UIColor(red: 169.0/255.0, green: 169.0/255.0, blue: 197.0/255.0, alpha: 1)
            break
        case "fire":
            return UIColor(red: 237.0/255.0, green: 107.0/255.0, blue: 36.0/255.0, alpha: 1)
            break
        case "water":
            return UIColor(red: 84.0/255.0, green: 123.0/255.0, blue: 235.0/255.0, alpha: 1)
            break
        case "grass":
            return UIColor(red: 100.0/255.0, green: 190.0/255.0, blue: 65.0/255.0, alpha: 1)
            break
        case "electric":
            return UIColor(red: 247.0/255.0, green: 199.0/255.0, blue: 39.0/255.0, alpha: 1)
            break
        case "psychic":
            return UIColor(red: 247.0/255.0, green: 65.0/255.0, blue: 116.0/255.0, alpha: 1)
            break
        case "ice":
            return UIColor(red: 133.0/255.0, green: 208.0/255.0, blue: 207.0/255.0, alpha: 1)
            break
        case "dragon":
            return UIColor(red: 93.0/255.0, green: 31.0/255.0, blue: 245.0/255.0, alpha: 1)
            break
        case "dark":
            return UIColor(red: 93.0/255.0, green: 70.0/255.0, blue: 56.0/255.0, alpha: 1)
            break
        case "fairy":
            return UIColor(red: 234.0/255.0, green: 133.0/255.0, blue: 155.0/255.0, alpha: 1)
            break
            
        default: return UIColor.blackColor()
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

   

}
