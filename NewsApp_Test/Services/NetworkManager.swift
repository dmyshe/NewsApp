import Foundation

enum NewsApiError: Error {
    case urlError
    case networkFailure(Error)
    case invalidData
}

class NetworkManager: NetworkManagerProtocol {
   
    static let shared = NetworkManager()
    private init() {}
    
    private let imageCache = NSCache<NSString,NSData>()
    private let newsApi = NewsApi()
    private var session = URLSession.shared
    
    func getNews(completion: @escaping NewsHandler) {
        let urlString = newsApi.fullUrlPath

        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
                if let envelope = newsEnvelope {
                    completion(.success(envelope.articles))
                }
            case .failure(_):
                print("error")
            }
        }
        task.resume()
    }
    
    func getImage(urlString: String, completion: @escaping DataHandler) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            let task = session.dataTask(with: url) { data, response, error in
                guard error == nil,let data = data else { return }
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }
            task.resume()
        }
    }
}
