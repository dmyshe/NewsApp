import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private static let newsImageHeight: CGFloat = 200
    private static let padding: CGFloat = 16
    
    //MARK: Views
    private lazy var newsImage: NewsImageView = {
        let imageView = NewsImageView()
        return imageView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
   
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(withModel viewModel: NewsViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        authorLabel.text = viewModel.news.source.name
        
        NetworkManager.shared.getImage(urlString: viewModel.urlToImage) { data in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.newsImage.image = UIImage(data: data)
            }
        }
    }
    
    private func setupView() {
        [newsImage,titleLabel,subtitleLabel,authorLabel].forEach { view in
            addSubviewForAutoLayout(view)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: NewsTableViewCell.newsImageHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NewsTableViewCell.padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -NewsTableViewCell.padding),
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: NewsTableViewCell.padding / 2),
            
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NewsTableViewCell.padding),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -NewsTableViewCell.padding),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: NewsTableViewCell.padding / 2),
            
            
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NewsTableViewCell.padding),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -NewsTableViewCell.padding),
            subtitleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: NewsTableViewCell.padding / 2),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -NewsTableViewCell.padding),
        ])
    }
}


