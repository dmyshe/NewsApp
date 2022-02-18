import Foundation

protocol NetworkManagerProtocol {
    typealias NewsHandler = (Result<[News],NewsApiError>) -> Void
    typealias DataHandler = (Data?) -> Void
    
    func getNews(completion: @escaping NewsHandler)
    func getImage(urlString: String, completion: @escaping DataHandler)
}
