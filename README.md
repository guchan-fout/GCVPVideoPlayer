# GCVPVideoPlayer
GCVPVideoPlayer, is a youtube like video player, you can shrink the video to a small view and keep reading news from the list.

# How to Use
Copy `GCVPVideoPlayerView.swift` to your project. And
pass your view frame and the url you want to play, then add GCVPVideoPlayerView's instance to your view, done.

``` swift

let videoView = GCVPVideoPlayerView(frame: self.navigationController!.view.frame, videoUrl: url)
videoView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
self.navigationController?.view.addSubview(videoView)

```
