import UIKit
import Flutter
import AVKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var splashViewController: UIViewController?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Create a new window and set the root view controller.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // Show the splash screen.
        showSplashScreen()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func showSplashScreen() {
        splashViewController = UIViewController()
        splashViewController?.view.backgroundColor = UIColor.white

        guard let videoPath = Bundle.main.path(forResource: "logo_splash", ofType: "mp4") else {
            transitionToFlutterViewController()
            return
        }
        let videoURL = URL(fileURLWithPath: videoPath)

        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.videoGravity = .resizeAspectFill

        splashViewController?.view.layer.addSublayer(playerLayer)
        
        self.window?.rootViewController = splashViewController
        self.window?.makeKeyAndVisible()

        player.play()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }

    @objc private func videoDidFinishPlaying() {
        transitionToFlutterViewController()
    }

    private func transitionToFlutterViewController() {
        // Create the Flutter view controller.
        let flutterViewController = FlutterViewController()
        let navigationController = UINavigationController(rootViewController: flutterViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        splashViewController?.dismiss(animated: false, completion: nil)
        splashViewController = nil
    }
}

