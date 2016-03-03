//
//  ViewController.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    //Outlets
    @IBOutlet weak var collection: UICollectionView!
    
    //Array of all the pokemon names
    var pokemones = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }
    
    //Parses pokemon names from the CSV file
    func parsePokemonCSV()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            //try to parse the csv
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows
            {
                //extract the ID from each row
                let pokeId = Int(row["id"]!)! //we force unwrapp because we are sure the values exist in the .csv file
                let pokeName = row["identifier"]!
                
                //Create a temporary pokemon
                let currentPokemon = Pokemon(name: pokeName, pokedexId: pokeId)
                
                //Append to Pokemones array
                pokemones.append(currentPokemon)
                
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    //Collection View Delegate Methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell
        {
            //Create a Pokemon object for each cell at the current indexPath
            var currentPokemon = pokemones[indexPath.row]
            //Configure each cell with a pokemon corresponding to the index path
            cell.configureCell(currentPokemon)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }

    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //Grid Size (Space between Cells)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }

}

