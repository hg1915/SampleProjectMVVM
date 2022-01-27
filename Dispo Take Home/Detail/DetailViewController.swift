

import UIKit

class DetailViewController: UIViewController {
    
    private let viewModel = DetailViewModel()
    
    var gifId:String?
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLbl : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let sourceLbl : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let ratingLbl : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    private let indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        self.title = viewModel.gifDetails?.title
        setupViewConstraints()
    }
    
    
    override func viewDidLoad() {

        self.viewModel.apiResultUpdated = {
            let url = URL(string: self.viewModel.gifDetails?.images.downsized.url ?? "")
            self.imageView.kf.setImage(with: url, completionHandler:  { result in
                self.indicator.stopAnimating()
            })
            self.setupNavbar()
            self.titleLbl.text = "Title: \(self.viewModel.gifDetails?.title ?? "")"
            self.sourceLbl.text = "Source: \(self.viewModel.gifDetails?.source ?? "")"
            self.ratingLbl.text = "Rating: \(self.viewModel.gifDetails?.rating ?? "")"
        }
        if let id = self.gifId{
            self.indicator.startAnimating()
            self.viewModel.fetchGifDetails(id: id)
        }
    }
    
    private func setupViewConstraints(){
        
        view.addSubviews(imageView,titleLbl,sourceLbl,ratingLbl,indicator)
        imageView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            let offset = self.navigationController?.navigationBar.frame.height ?? 80
            $0.top.equalToSuperview().offset(offset+150)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(200)
        }
        titleLbl.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        sourceLbl.snp.makeConstraints{
            $0.top.equalTo(titleLbl.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        ratingLbl.snp.makeConstraints{
            $0.top.equalTo(sourceLbl.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        indicator.snp.makeConstraints{
            $0.center.equalTo(imageView.snp.center)
        }
    }
    
    private func setupNavbar(){
           if self.navigationItem.titleView == nil {
               self.navigationItem.titleView = {
                   let titleView = UILabel()
                   titleView.numberOfLines = 0
                   titleView.textAlignment = .center
                   titleView.attributedText = NSAttributedString(
                       string: self.viewModel.gifDetails?.title ?? "",
                       attributes: self.navigationController?.navigationBar.titleTextAttributes)

                   return titleView

               }()
           }
    }
    
}
