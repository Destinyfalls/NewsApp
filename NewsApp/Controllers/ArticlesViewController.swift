//
//  ViewController.swift
//  NewsApp
//
//  Created by Igor Belobrov on 26.11.2020.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: "ArticleTableViewCell")
            newsTableView.addSubview(refreshControl)
        }
    }
 
    private var allNews = [News]()
    private var page = 1
    private var topic = ""
    private var isLoadingArticles : Bool = false
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews(completion: nil)
    }
    
    func getNews(shouldCleanArticles: Bool = true, completion: (() -> Void)?) {
        NetworkingManager.shared.getAllNews(page: page, topic: searchBar.text!) { allNews in
            self.isLoadingArticles = false
            if shouldCleanArticles {
                self.allNews.removeAll()
                self.allNews = allNews
            } else {
                self.allNews.append(contentsOf: allNews)
            }
            self.page += 1
            self.newsTableView.reloadData()
            completion?()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.page = 1
        getNews() { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        let article = allNews[indexPath.row]
        cell.configureNews(article: article)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = allNews[indexPath.row].mainUrl,
              let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        viewController.articleUrl = url
        self.present(viewController, animated: true, completion: nil)
    }
}

extension ArticlesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingArticles){
            self.isLoadingArticles = true
            getNews(shouldCleanArticles: false) {
                self.newsTableView.reloadData()
            }
        }
    }
}

extension ArticlesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getNews(completion: nil)
    }
}
