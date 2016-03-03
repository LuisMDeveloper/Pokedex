//
//  ViewController.swift
//  Pokedex by Juanjo Santos
//
//  Created by Juanjo Santos on 3/2/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    //Outlets
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //Boolean to determine if we are filterin Pokemon or not
    var inSearchMode: Bool = false
    
    //Array of all the pokemon names
    var pokemones = [Pokemon]()
    var filteredPokemones = [Pokemon]()
    
    //Music Player
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio()
    {
        let musicUrl:NSURL = NSBundle.mainBundle().URLForResource("poketheme", withExtension: "mp3")!
        do { musicPlayer = try AVAudioPlayer(contentsOfURL: musicUrl, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        musicPlayer.numberOfLoops = -1
        musicPlayer.prepareToPlay()
        musicPlayer.play()
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
            var currentPokemon: Pokemon!
            
            
            //Determine from which array we fill our collection view
            if inSearchMode
            {
                currentPokemon = filteredPokemones[indexPath.row]
            } else {
                currentPokemon = pokemones[indexPath.row]
            }
            
            
            
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
        
        //The pokemon the user chose can be chosen from the filtered or unfiltered array
        var selectedPokemon: Pokemon!
        
        if inSearchMode
        {
            selectedPokemon = filteredPokemones[indexPath.row]
        } else {
            selectedPokemon = pokemones[indexPath.row]
        }
        
        //                                       SEND THE SELECTED POKEMON TO THE DETAIL VC
        performSegueWithIdentifier("showDetail", sender: selectedPokemon)
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode
        {
            return filteredPokemones.count
        }
        
        return pokemones.count
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //Grid Size (Space between Cells)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    
    //Search Bar Delegate Methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchMode = false
            collection.reloadData()
            //Close keyboard
            view.endEditing(true)
        } else {
            inSearchMode = true
            //Start Pokemon Filtering process
            let query = searchBar.text!.lowercaseString
            //Filter the original Pokemones array with the query and store the result (filtered) array in filteredPokemones array.
            filteredPokemones = pokemones.filter({ $0.name.rangeOfString(query) != nil })
            //Refresh collection view with the filtered pokemon
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        inSearchMode = false
        //Close keyboard
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        inSearchMode = false
        //Close keyboard
        view.endEditing(true)
    }
    
    

    @IBAction func musicButton(sender: UIButton!) {
        
        if musicPlayer.playing
        {
            musicPlayer.stop()
            sender.setImage(UIImage(named: "speakerm.png"), forState: .Normal)
        } else {
            musicPlayer.play()
            sender.setImage(UIImage(named: "speaker.png"), forState: .Normal)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            //Create an instance of the details VC
            if let DetailsVCInstance = segue.destinationViewController as? PokemonDetailViewController {
                //Create an instance of the SENDER
                if let pokeSender = sender as? Pokemon {
                    //Send the Pokemon
                    DetailsVCInstance.recievedPokemon = pokeSender
                }
            }
        }
    }
}

