 

import UIKit
import WebKit
import SnapKit
class ViewController: UIViewController {
 
    var url : URL?
    
    convenience init(_ url : URL) {
        self.init()
        self.url = url
    }
    
    lazy var webView: MyWebView = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.default()
        config.userContentController = WKUserContentController()
        config.userContentController.add(self, name: "jsCallNativeMethod")
        let webView = MyWebView(frame: UIScreen.main.nativeBounds, configuration: config)
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "splash")
        return imageView
    }()
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        guard let url = self.url else {
            return
        }
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let customUA =  "bbc.ios.v." + version + "." + modelName
        let userAgent = customUA
        self.webView.evaluateJavaScript("navigator.userAgent") {[weak self](result, error) in
            let oldAgent = result as? String ?? ""
            let newAgent = userAgent + "(\(oldAgent))"
            UserDefaults.standard.register(defaults: ["UserAgent":newAgent])
            UserDefaults.standard.synchronize()
            self?.webView.customUserAgent = newAgent
            self?.webView.load(URLRequest(url: url))
            debugPrint(newAgent)

        }
    }
    
    deinit {
        self.webView.configuration.userContentController.removeScriptMessageHandler(forName: "jsCallNativeMethod")
    }

 
    
    func share(_ title : String , urlStr : String) {
        
        let image = UIImage(named: "icon")
        var items = [Any]()
        let url = URL(string: urlStr)
        items.append(image)
        items.append(title)
        items.append(url)
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.completionWithItemsHandler = {( type , completed , items , error) in
            
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    fileprivate  func getAppIcon() -> String? {
        let info = Bundle.main.infoDictionary
        if let dict = info?["CFBundleIcons"] as? [String : Any]{
            if let dict = dict["CFBundlePrimaryIcon"] as? [String : Any] {
                if let icons = dict["CFBundleIconFiles"] as? [String] {
                    return icons.last
                }
            }
        }
        return nil
    }
}

extension ViewController : WKScriptMessageHandler , WKNavigationDelegate{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
         debugPrint(message)
        guard let body = message.body as? String else { return }
        guard  let data = body.data(using: String.Encoding.utf8) else { return }
        do {
            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                debugPrint(dict)
                guard let title = dict["title"] as? String else  { return }
                guard let url = dict["url"] as? String else { return }
                share(title, urlStr: url)
            }
            
        } catch {
            debugPrint("转化失败")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.imageView.removeFromSuperview()
        }
    }
    
}
