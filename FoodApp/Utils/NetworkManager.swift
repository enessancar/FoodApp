//
//  NetworkManager.swift
//  FoodApp
//
//  Created by Enes Sancar on 26.09.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let queue = DispatchQueue(label: "com.fatih.NetworkingManager", qos: .background)
    
    public func download(url: URL, completion: @escaping(Result<Data, CustomError>) -> ()) {
        queue.async {
            var request = URLRequest(url: url)
            request.addValue("xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", forHTTPHeaderField: "Api-Key")
            request.addValue("AtS1aPFxlIdVLth6ee2SEETlRxk=", forHTTPHeaderField: "Alias-Key")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(data))
            }.resume()
        }
    }
}
