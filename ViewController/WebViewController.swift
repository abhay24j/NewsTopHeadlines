
import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var articleInfo: ArticleModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlStr = articleInfo?.url,
        let url = URL(string: urlStr) else {
            print("unable to load the url")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
    


}
