//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 8/11/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let contianer: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    @Published var savedEntities : [PortfolioEntity] = []
    init() {
        contianer = NSPersistentContainer(name: containerName)
        contianer.loadPersistentStores { (_, error) in
            if let error = error {
                print("error in loading CoreData : \(error.localizedDescription)")
            }
            
            self.getPortfolio() 
            
        }
    }
    
    
    func updatePortfolio (coin: CoinModel, amount: Double) {
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else {
                remove(entity: entity)
            }
            
        }else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try contianer.viewContext.fetch(request)
            
        } catch let error{
            print("proble to fetch Portfolio:\(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: contianer.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        
        entity.amount = amount
        applyChange()
        
    }
    
    private func remove(entity: PortfolioEntity) {
        
        contianer.viewContext.delete(entity)
        applyChange()
        
    }
    
    
    private func save() {
        do{
            try contianer.viewContext.save()
        }catch let error {
            print("proble to save Portfolio:\(error.localizedDescription)")

        }
    }
    
    private func applyChange() {
        save()
        getPortfolio()
    }
    
}
