
import UIKit
import Kingfisher

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
   
    var newsResultModel : NewsResultModel?
    
    @IBOutlet weak var newsTableView: UITableView!
    private let refreshControlView = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControlView
        } else {
            newsTableView.addSubview(refreshControlView)
        }
        refreshControlView.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    @objc private func refreshNewsData(_ sender: Any) {
        // Fetch Weather Data
        fetchData()
    }
    func fetchData() {
        
        self.startShowLoadingAnimation()
        NetworkService.shared.readData(fromURLStr: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=43f7ac6e8442468389c37766408e2028", type: NewsResultModel.self, completion: { news, error in
            DispatchQueue.main.async {
                self.stopLoadingAnimation()
                self.refreshControlView.endRefreshing()
                if let errorVal = error {
                    print(errorVal.localizedDescription)
                    return
                }
                guard let dataArray = news else {
                    print("unable to fetch data")
                    return
                }
                self.newsResultModel = dataArray
                
                
                self.newsTableView.reloadData()
            }
        })
    }


}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResultModel?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let newsData = articleModel.articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        guard let article = newsResultModel?.articles[indexPath.row] else {
            return cell
        }
        cell.authorLabel.text = article.author
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.articleDescription
        guard let urlStr = article.urlToImage, let  url  = URL(string: urlStr) else {
            return cell
        }
        cell.newsImage.kf.setImage(with: url)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = newsResultModel?.articles[indexPath.row] else {
            return
        }
        let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard2.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.articleInfo = article
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func startShowLoadingAnimation() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
            self.loadingView.isHidden = false
        }
    }
    
    func stopLoadingAnimation() {
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
            }
    }
    
    
}



