import UIKit

class NewsImageView: UIView {
    
    private let padding: CGFloat = 16
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    //MARK: Views
    private lazy var imageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviewForAutoLayout(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            ])
        }
}


