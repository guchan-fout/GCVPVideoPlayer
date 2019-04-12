//
//  GCVPTableViewController.swift
//  GCVideoPlayer
//
//  Created by gc on 2019/02/08.
//  Copyright © 2019 gc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SafariServices

class GCVPTableViewController: UITableViewController {

    private let cellId = "heroCells"
    private let heros = HerosInfoAPI.getHeros()
    private let cellHeight:CGFloat! = 120
    //private var webView: WKWebView!


    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "Marveldctitle")
        navigationItem.titleView = imageView

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroTableViewCell.self, forCellReuseIdentifier: cellId)

        //will crash if before addSubview
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heros.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HeroTableViewCell
        cell.heroInfo = heros[indexPath.row]
        cell.backgroundColor = UIColor.init(red: 217/255, green: 247/255, blue: 252/255, alpha: 0.3)
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = tableView.cellForRow(at: indexPath) as! HeroTableViewCell

        let youtubeButton = UIContextualAction(style: .normal, title:  "youtube",
                                               handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
                                                print("clickYoutube")
                                                let videoName = (cell.heroInfo?.name)! + "Video"
                                                print("videoName is :" + videoName)
                                                self.createAVPlayer(name: videoName)
                                                success(true)
        })

        youtubeButton.backgroundColor = UIColor.red

        let wikiButton = UIContextualAction(style: .normal, title:  "wiki",
                                            handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
                                                print("clickWiki")
                                                let wiki = cell.heroInfo!.web
                                                self.openBrowser(url: wiki)
                                                success(true)
        })

        return UISwipeActionsConfiguration(actions: [youtubeButton, wikiButton])
    }



    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    func createAVPlayer(name:String){
        print("URL:" + name)
        guard let videoPath = Bundle.main.path(forResource: name, ofType: "mp4") else {return}
        print("Video name: \(name)")
        let url = URL(fileURLWithPath: videoPath)
        for subView in (self.navigationController?.view.subviews)! {
            //remove existed video
            if subView.isKind(of: GCVPVideoPlayerView.self) {
                subView.removeFromSuperview()
            }
        }
        let videoView = GCVPVideoPlayerView(frame: self.navigationController!.view.frame, videoUrl: url)
        videoView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.navigationController?.view.addSubview(videoView)

        /*
        let videoController = GCVPVideoPlayerView(url:name)
        videoController.modalPresentationStyle = .overCurrentContext
        videoController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        present(videoController, animated: true, completion: nil)
        */

        //use AVPlayerController
        /*
         guard let videoPath = Bundle.main.path(forResource: url, ofType: "mp4") else {return}
         print("videoPath:" + videoPath)
         let url = URL(fileURLWithPath: videoPath)
         let avplayer = AVPlayer(url: url)
         let avplayerController = AVPlayerViewController()
         avplayerController.player = avplayer
         present(avplayerController, animated: true) {
         avplayer.play()
         }
         */
    }

    func openBrowser(url:String){
        print("URL:" + url)
        let myURL = URL(string: url)
        let vc = SFSafariViewController(url:myURL!)
        present(vc, animated: true, completion: nil)

        //use WKWebView
        /*
         let webConfiguration = WKWebViewConfiguration()
         webView = WKWebView(frame: self.view.frame, configuration: webConfiguration)
         webView.allowsBackForwardNavigationGestures = true
         let myURL = URL(string: url)
         let myRequest = URLRequest(url: myURL!)
         webView.load(myRequest)
         self.view .addSubview(webView)
         let button   = UIButton(type: UIButton.ButtonType.system) as UIButton
         let image = UIImage(named: "close") as UIImage?
         button.frame = CGRect(x:self.view.frame.width - 60, y:10, width:35, height:35)
         button.setImage(image, for: .normal)
         button.addTarget(self, action: #selector(self.btnClick(btn:)), for: UIControl.Event.touchUpInside)
         self.view.addSubview(button)
         */
    }
}








