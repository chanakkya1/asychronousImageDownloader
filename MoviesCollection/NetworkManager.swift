//
//  NetworkManager.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/25/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import Foundation
import UIKit


class Album:Decodable{
    let collectionName:String
    let artworkUrl60:URL
    let id:String
    let wrapperType: String
    let collectionType : String
    
    required init(from decoder:Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
        wrapperType = try container.decode(String.self,forKey:.wrapperType)
        collectionType = try container.decode(String.self, forKey: .collectionType)
        guard wrapperType == "collection", collectionType == "Album" else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath:container.codingPath+[CodingKeys.wrapperType, CodingKeys.collectionType], debugDescription: "wrappedType and collection type should be equal to Album and collection respectively"))
        }
        artworkUrl60 = try container.decode(URL.self, forKey:.artworkUrl60)
        id = try String(container.decode(Int.self, forKey:.id))
        collectionName = try container.decode(String.self, forKey:.collectionName)
    }
    
    private enum CodingKeys:String,CodingKey{
        case collectionName
        case artworkUrl60
        case id = "collectionId"
        case wrapperType
        case collectionType
    }
}

extension Album:Equatable{
    static func ==(lhs: Album, rhs: Album) -> Bool {
        return   lhs.artworkUrl60 == rhs.artworkUrl60 && lhs.id == rhs.id && lhs.collectionName == rhs.collectionName
    }
    
    
}

enum AlbumResult {
    case success([Album])
    case failure(Error)
}

enum AlbumResultError:Error {
    case jsonDataInvalidError
}

struct AlbumsAPI {
    static let  baseURLString = "https://itunes.apple.com/lookup"
}

class AlbumsStore {
    var artistIds:[Int] = [155814,3296287,551695,487143,136975,61499,32940]
    var artistAlbums :[Int:[Album]] = [:]
    
    var imageStore = ImageStore()
    static let session = {
        URLSession(configuration: URLSessionConfiguration.ephemeral)
    }()
    
    func fetchAlbum(forArtist id:Int,completionHandler:@escaping (AlbumResult)->Void){
        if let albums = artistAlbums[id]{
            OperationQueue.main.addOperation {
                completionHandler(.success(albums))
            }
        }
        
        let baseURLString = AlbumsAPI.baseURLString
        let queryString = "id=\(id)&entity=album"
        let urlString = baseURLString+"?"+queryString
        let url = URL(string: urlString)!
        let task = AlbumsStore.session.dataTask(with: url) { (data, response, error) in
            let result = AlbumParser.parseAlbums(jsonData: data, error: error)
            OperationQueue.main.addOperation {
                switch result{
                case .success(let albums) :
                    self.artistAlbums[id] = albums
                case .failure(_):
                    self.artistAlbums[id] = nil
                }
                completionHandler(result)
            }
        }
        task.resume()
    }
    
    func fetchImage(forAlbum album:Album, completionHandler:@escaping(UIImage?)->()){
//        if let image = imageStore.image(forkey: album.id){
//            DispatchQueue.main.sync {
//                completionHandler(image)
//            }
//            return
//        }
//        guard let url = album.artworkUrl60 else {
//            DispatchQueue.main.sync {
//                completionHandler(nil)
//            }
//            return
//        }
        AlbumsStore.session.dataTask(with:album.artworkUrl60) { (data, response, error) in
            guard let imagedata = data,
                let image = UIImage(data: imagedata) else {
                    DispatchQueue.main.async {
                        completionHandler(nil)
                    }
                    return
            }
            self.imageStore.setImage(image, forkey: String(album.id))
            DispatchQueue.main.async {
                completionHandler(image)
            }
            
            }.resume()
    }
}
class AlbumParser {
    static func parseAlbums(jsonData:Data?, error:Error?)->AlbumResult{
        guard let data = jsonData else {
            return .failure(error!)
        }

        do {
            let albumsDict = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dict = albumsDict as? [String:Any],
                let _ = dict["resultCount"] as? Int,
                let results = dict["results"] as? [[String:Any]]
                else {
                    return .failure(AlbumResultError.jsonDataInvalidError)
            }
//           let resultsData = try? JSONSerialization.data(withJSONObject: results, options: [])
//            do{
//               albums = try decoder.decode([Album?].self, from: resultsData)
//            }catch{
//                print(error)
//            }
            
            var albums:[Album] = []
            let decoder = JSONDecoder()
            for result in results{
                if let albumjson  = try? JSONSerialization.data(withJSONObject: result, options: []){
                    do{
                       let album = try decoder.decode(Album.self, from: albumjson)
                        albums.append(album)
                    }catch{
                        continue
                    }
                }
            }
            return .success(albums)
            
        }catch let error{
            return .failure(error)
        }
    }
    
//    static func getAlbum(from dict:[String:Any])->Album?{
//        guard let wrapperType = dict["wrapperType"] as? String,
//            let collectionType = dict["collectionType"] as? String,
//            let albumName = dict["collectionName"] as? String,
//            let imageUrl = dict["artworkUrl60"] as? String,
//            let id = dict["collectionId"] as? Int,
//            wrapperType == "collection" && collectionType == "Album" else {
//                return nil
//        }
//        //return Album(collectionName: albumName, imageUrl: imageUrl,id:String(id))
//    }
    
    
}

