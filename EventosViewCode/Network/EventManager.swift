//
//  EventManager.swift
//  EventosViewCode
//
//  Created by Matias Correa Franco de Faria on 07/03/22.
//

import Foundation

enum EventError: Error {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class EventManager {
    let basePath = "https://5f5a8f24d44d640016169133.mockapi.io/api/events"
    
    let session: URLSession = URLSession(configuration: .default)
    
    public func loadEvents(completion: @escaping (_ result: Result<[Event], EventError>) -> Void) {
        guard let url = URL(string: basePath) else {
            completion(.failure(EventError.url))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(.failure(EventError.noResponse))
                    }
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let events = try JSONDecoder().decode([Event].self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(events))
                        }
                    } catch {
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(.failure(EventError.invalidJSON))
                        }
                    }
                } else {
                    print("Algum status inválido pelo servidor!!")
                    DispatchQueue.main.async {
                        completion(.failure(EventError.responseStatusCode(code: response.statusCode)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(EventError.taskError(error: error!)))
                }
            }
        }
        dataTask.resume()
    }
    
}
