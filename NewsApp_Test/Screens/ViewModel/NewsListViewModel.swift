import Foundation

protocol NewsListViewModelDelegate: AnyObject {
    func reloadData()
}

class NewsListViewModel {
    
    weak var delegate: NewsListViewModelDelegate?
    
    var newsVM = [NewsViewModel]() {
        didSet {
            DispatchQueue.main.async { [delegate] in
                delegate?.reloadData()
            }
        }
    }
    
    private var news: [News] = [] {
        didSet {
            newsVM = news.map(NewsViewModel.init)
        }
    }

    func getNews() {
        NetworkManager.shared.getNews { [unowned self] result in
            switch result {
            case .success(let news):
                self.news = news
            case .failure(_):
                print("error")
            }
        }
    }

}
