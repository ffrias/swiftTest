//
//  DataMapper.swift
//  swiftTest
//
//  Created by Federico Frias on 8/27/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import Foundation

class DataMapper{

    func saveSong(song:Song){
        
        let localContext = NSManagedObjectContext.MR_context()
        
        var newPersistence = _SongPersistence(managedObjectContext: localContext)
        
        newPersistence.image = song.getImage()
        newPersistence.artist = song.getName()
        newPersistence.track = song.getTrack()
        newPersistence.price = song.getPrice()
        
        var error:NSErrorPointer = nil
        
        localContext.save(error)
    }
    
    func getAllSongs()->Array<Song>{


        var newPersistence:[_SongPersistence] = _SongPersistence.MR_findAll() as! [_SongPersistence]
        
        var songArray = [Song]()
        for song in newPersistence {
            var newSong = Song(image: song.image!, name: song.artist!, track: song.track!, price: song.price!)
            songArray.append(newSong)
        }
        

        return songArray
    }
}
