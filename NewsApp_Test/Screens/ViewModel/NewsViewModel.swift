import Foundation

struct NewsViewModel {
    let news: News
    
    var author: String {
        return news.author ?? "Unkown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? ""
    }
}
