//
//  DatabaseLayer.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import RealmSwift


protocol DatabaseLayer {
    func add(object:Object)
    func add(objects:[Object])
    func get(objectType:Object.Type) -> Results<Object>?
    func remove(object:Object)
    func removeAll(objectType:Object.Type)
}

class DatabaseLayerImpl: DatabaseLayer {
    
    let realm = try! Realm()

    func add(object: Object) {
        do{
            try realm.write {
                realm.add(object)
            }
        }catch{
            print("Erreur...")
        }
    }
    
    func add(objects: [Object]) {
        do{
            try realm.write {
                realm.add(objects)
            }
        }catch{
            print("Realm ... Erreur")
        }
    }
    
    func get(objectType: Object.Type) -> Results<Object>? {
        let objects = realm.objects(objectType)
        if objects.isEmpty {
            return nil
        }
        return objects
    }
    
    func remove(object: Object) {
        realm.beginWrite()
        realm.delete(object)
        do{
           try realm.commitWrite()
        }catch{
            print("Delete Error")
        }
    }
    
    func removeAll(objectType: Object.Type) { 
        let objects = realm.objects(objectType)
        
        realm.beginWrite()
        realm.delete(objects)
        do{
            try realm.commitWrite()
        }catch{
            print("Delete error")  
        }
    }
    
}
