//
//  Service+Helper.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 19/05/23.
//

import Combine
import Foundation

class GitHubPresenterService {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData<T: Decodable>(url: URL, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: decodingType, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { value in
                completion(.success(value))
            })
            .store(in: &cancellables)
    }
}
