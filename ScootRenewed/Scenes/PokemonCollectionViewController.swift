//
//  ScootTableViewController.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit

class PokemonCollectionViewController: UICollectionViewController {
            let refreshControl = UIRefreshControl()
    var pokemon: [Pokemon] = []
    enum State {
        case loading(Bool)
        case loaded([Pokemon])
        case empty
        case error(Error)
    }
    
    fileprivate var state: State = .loading(false){
       
        didSet {
             
            collectionView.reloadData()
            switch state {
            case .error(_), .loaded(_):
                    refreshControl.endRefreshing()
            default: break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadPokemon(fromRefreshControl: false)
        
        

        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        
        
    }
    
    @IBAction func refreshPulled(_ sender: UIRefreshControl){
        switch state {
        case .loading(_):
            return
        default:
            loadPokemon(fromRefreshControl: true)
        }

        

    }
    
    private func loadPokemon(fromRefreshControl: Bool){
        state = .loading(fromRefreshControl)
        self.setDataSource()
    }
    
    private func configureTableView() {
            collectionView.register(UINib(nibName: PokemonViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PokemonViewCell.cellReuseIdentifier)
            collectionView.register(UINib(nibName: RefreshViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RefreshViewCell.cellReuseIdentifier)
    
    }
    
    
    
    
    
    private func setDataSource() {
        PokemonRoute().getPokemonImages(completionBlock: {
            data, error in
            
            if error == nil {
                
                let initialData = data as! [String]
                if initialData.count == 0 {
                    self.state = .empty
                }
              
                
                self.loadinBackground(initialData)
                
                
            }
            
        })
    }
    
    
    
    private func loadinBackground(_ initial: [String]) {
        for each in initial {
            
            
            PokemonRoute().sendRequestForImage(url: each, completionBlock: {
                data, error in
                //self.dataSource.append(data as! UIImage)
                //self.collectioView?.reloadData()
                
                guard let pokemon = data else {
                    // self.state = .error(
                    return
                }
                let pokemonData = Pokemon(image: pokemon as! UIImage)
                self.pokemon.append(pokemonData)
                 self.state = .loaded(self.pokemon)
            })
        }
    }
    
    
    
}

extension PokemonCollectionViewController {
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .loaded(let pokemon):
            return pokemon.count
        case .empty, .error(_):
            return 1
        case .loading (let refreshFromControl):
            return refreshFromControl ? 0 : 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
            
        case .loaded(let pokemon):
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonViewCell.cellReuseIdentifier, for: indexPath) as! PokemonViewCell
            cell.imageCell?.image = pokemon.first?.image
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonViewCell.cellReuseIdentifier, for: indexPath) as! PokemonViewCell
            cell.configureWith(kind: .information("Empty"))
            return cell
        case .error(let Error):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonViewCell.cellReuseIdentifier, for: indexPath) as! PokemonViewCell
            cell.configureWith(kind: .information("Error"))
            return cell
        case .loading(let fromRefreshControl):
            if fromRefreshControl {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefreshViewCell.cellReuseIdentifier, for: indexPath) as! RefreshViewCell
            cell.startAnimating()
            return cell
            
            
            
        }
    }
    
    
    
    
}
