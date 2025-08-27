//
//  MoviesListViewController.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 14/05/2025.
//

import UIKit
import Combine

class MoviesListViewController: MainViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Propreties
    private let viewModel: MoviesListViewModel
    private let refreshControl = UIRefreshControl()
  //  private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private let imageLoader: ImageLoader = KingfisherImageLoader()
    // MARK: - Init
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        setupRefreshControl()
//        DispatchQueue.main.async { [weak self] in
//            self?.viewModel.fetchMovies()
//        }
    }
    // MARK: - UI Setup
    private func setupUI() {
        title = "MoviesBox"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()


//        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
//        tableView.register(UINib(nibName: "MovieTableViewCell" , bundle: .main), forCellReuseIdentifier: "MovieTableViewCell")
      //  tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
//        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(loadingIndicator)
    }
    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    // MARK: - Bindings
//    private func bindViewModel() {
//        viewModel.$movies
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in
//                self?.tableView.reloadData()
//            }
//            .store(in: &cancellables)
//        
//        viewModel.$isLoading
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] loading in
//                loading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
//            }
//            .store(in: &cancellables)
//        
//        viewModel.$error
//            .compactMap { $0 }
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] error in
//                self?.view.showToast(message: error.localizedDescription)
//            }
//            .store(in: &cancellables)
//    }
    private func bindViewModel() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
             //   self?.render(state: state)
            }
            .store(in: &cancellables)
    }
    
//    private func render(state: ViewState) {
//        switch state {
//            case .loading:
//                loadingIndicator.startAnimating()
//                collectionView.isHidden = true
//            case .loaded:
//                loadingIndicator.stopAnimating()
//                collectionView.isHidden = false
//                showToast(message: "Loaded")
//                collectionView.reloadData()
//            case .empty:
//                loadingIndicator.stopAnimating()
//                collectionView.isHidden = true
//                showToast(message: "No movies found.")
//            case .error(let message):
//                loadingIndicator.stopAnimating()
//                collectionView.isHidden = true
//                showToast(message: message)
//        }
//    }
    private func fetchMovies()  {
//         viewModel.fetchMovies()
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .touchDragExit)
        collectionView.refreshControl = refreshControl
    }
    @objc private func didPullToRefresh()  {
       // Task {
             fetchMovies()
            refreshControl.endRefreshing()
        }
   // }

}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell" , for: indexPath) as! MovieCollectionViewCell
        
       // let movie = viewModel.movie(at: indexPath.row)
     //   cell.configure(with: movie)
        return cell
    }
    
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let totalSpacing = spacing * 3 // 2 between cells + 1 for left/right
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: width * 1.7) // Poster aspect ratio
    }
}
//extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.numberOfMovies
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        380
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
////            fatalError("Could not dequeue MovieTableViewCell")
////        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell" , for: indexPath) as! MovieTableViewCell
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
////            return UITableViewCell()
////        }
//        
//        let movie = viewModel.movie(at: indexPath.row)
//      //  print("zzz\(movie)")
//        cell.configure(with: movie, imageLoader: imageLoader)
//        return cell
//    }
//    
//}
