//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/14/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case  badURLRespone(url:URL)
        case  unknow
        case  exceedLimit
        
        var  errorDescription: String? {
            switch self {
            case .badURLRespone(url: let url): return "Bad Respone from URL: \(url)"
                
            case .unknow: return "Unknown error occured"
            
            case .exceedLimit : return "You've exceeded the Rate Limit."
                
            }
        }
    }
    
    static func download(url:URL) -> AnyPublisher<Data, Error>{
      return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ try handleURLRespone(output: $0 , url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLRespone(output: URLSession.DataTaskPublisher.Output , url:URL) throws -> Data {
        
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                            
            throw NetworkingError.badURLRespone(url: url)
        }
        
        if response.statusCode == 429 {
            throw NetworkingError.exceedLimit
        }
        
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error> ){
        
        switch completion {
        case .finished:
            break
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    
}
