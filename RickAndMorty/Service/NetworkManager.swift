//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import Alamofire

enum ApiType: String {
    case characters = "character/?page="
    case locations  = "location/?page="
    case episodes   = "episode/?page="
}

class NetworkManager {
    
    static let shared   = NetworkManager()
    
    private let baseURL = "https://rickandmortyapi.com/api/"
        
    typealias networkCompletion = (CharacterList?,ErrorMessages?) -> Void
       
    func getCharacters(type: ApiType, page:Int, completion: @escaping networkCompletion) {
        
        let endUrl = baseURL + type.rawValue + "\(page)"
        
        guard let url = URL(string: endUrl) else {
            completion(nil, .networkError)
            return
        }
        
        let request = AF.request(url)
        
        request.validate().responseDecodable(of: CharacterList.self) { response in
            
            switch response.result {
                
            case .success:
                guard let characters = response.value else {
                    completion(nil,.networkError) // this is my custom error description but we can change localized descripton
                    return
                }
                
                completion(characters,nil) // we got data
                
            case .failure(_):
                completion(nil,.networkError)
            }
        }
    }
    
    
    func searchCharacters(name: String, completion: @escaping networkCompletion) {
        
        let endUrl = baseURL + "character/?name=\(name)"
        
        guard let url = URL(string: endUrl) else {
            completion(nil, .searchingError)
            return
        }
        
        let request = AF.request(url)
        
        request.validate().responseDecodable(of: CharacterList.self) { response in
            
            switch response.result {
                
            case .success:
                guard let characters = response.value else {
                    completion(nil,.searchingError) // this is my custom error description but we can change localized descripton
                    return
                }
                
                completion(characters,nil) // we got data
                
            case .failure(_):
                completion(nil,.searchingError)
            }
        }
    }
    
    
    func filterCharacters(status: String, gender:String, species:String, completion: @escaping networkCompletion) {
        
        let endUrl = baseURL + "character/?status=\(status)&gender=\(gender)&species=\(species)"
        
        guard let url = URL(string: endUrl) else {
            completion(nil, .filteredError)
            return
        }
        
        let request = AF.request(url)
        
        request.validate().responseDecodable(of: CharacterList.self) { response in
            
            switch response.result {
                
            case .success:
                guard let characters = response.value else {
                    completion(nil,.filteredError) // this is my custom error description but we can change localized descripton
                    return
                }
                
                completion(characters,nil) // we got data
                
            case .failure(_):
                completion(nil,.filteredError)
            }
        }
    }
    
    func getImage(fromUrl url: String, completion: @escaping (UIImage?, ErrorMessages?) -> Void) {
        
        let request = AF.request(url)
                
        request.responseData { (response) in
            
            switch response.result {
            case .success:
                
                guard let imageData = response.value,
                      let image = UIImage(data: imageData, scale: 1.0)
                else { return }
                
                completion(image,nil) // we got image
                
            case .failure:
                completion(nil,.imageError)
            }
        }
    }
}



