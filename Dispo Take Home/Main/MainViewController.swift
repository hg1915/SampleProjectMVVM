
import UIKit

class MainViewController: UIViewController {
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        
        viewModel.apiResultUpdated = {
            //capture list
            
            [weak self] in
            self?.indicator.stopAnimating()
           
            self?.collectionView.reloadData()
          
        }
        indicator.startAnimating()
        viewModel.fetchTrending()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView,indicator)
    
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        indicator.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private var layout: UICollectionViewLayout  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 50)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        return flowLayout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private let indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1{
            DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) {
                if !self.indicator.isAnimating{
                    self.indicator.startAnimating()
                }
                self.viewModel.searchGif(query: searchText)
            }
        }else{
            if !indicator.isAnimating{
                indicator.startAnimating()
            }
            self.viewModel.fetchTrending()
        }
    }
}
extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.searchResults.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.reuseID, for: indexPath) as! MainCollectionCell
        cell.setupUI()
        cell.setData(searchResult: self.viewModel.searchResults[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.gifId = self.viewModel.searchResults[indexPath.row].id
        
        
        navigationController?.fadeTo(vc)
    }
}
