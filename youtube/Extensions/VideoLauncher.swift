//
//  VideoLauncher.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/9/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView:UIView
{
    let containerView:UIView = {
        let view = UIView()
      //  view.backgroundColor = .red //UIColor(white: 0, alpha: 0.5)
        return view
    }()
    let activityIndicator:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    lazy var pauseButton:UIButton = {
       var btn = UIButton()
       btn.setImage(UIImage(named: "pause"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(pauseVideo), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    let durationLabel:UILabel = {
       let dLabel = UILabel()
        dLabel.textColor = .white
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.textAlignment = .center
        dLabel.text = "0:00"
        dLabel.textColor = .white
        return dLabel
    }()
    let videoSlider:UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.maximumTrackTintColor = .white
        slider.addTarget(self, action: #selector(handleVideoTime), for: .valueChanged)
        return slider
    }()
    @objc func handleVideoTime()
    {
        if let duration = player?.currentItem?.duration
        {
            let totalSeconds = duration.seconds
            let value = Float(videoSlider.value) * Float(totalSeconds)
            let cmTime = CMTime(value: CMTimeValue(value), timescale: 1)
            //player?.seek(to: cmTime)
            player?.seek(to: cmTime, completionHandler: { (completed) in
                
            })
        }
    }
    let minutesLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    @objc func pauseVideo() {
        if isPlaying
        {
            player?.pause()
            pauseButton.setImage(UIImage(named: "play"), for: .normal)

        }
        else
        {
            player?.play()
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
        
    }
    
    var isPlaying:Bool = false
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        containerView.frame = frame
        setupVidePlayer()
        setupGradientLayer()
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerView.addSubview(pauseButton)
        pauseButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(durationLabel)
        durationLabel.anchorToTop(bottom: bottomAnchor, right: rightAnchor)
        durationLabel.setHeightConstraint(height: 25)
        durationLabel.setWidthAnchor(width: 60)
        containerView.addSubview(minutesLabel)
        minutesLabel.anchorToTop(left: leftAnchor, bottom: bottomAnchor)
        minutesLabel.setHeightConstraint(height: 25)
        minutesLabel.setWidthAnchor(width: 60)

        containerView.addSubview(videoSlider)
  videoSlider.anchorWithConstantsToTop(left: minutesLabel.rightAnchor, bottom: bottomAnchor, right: durationLabel.leftAnchor, leftConstant: 5, bottomConstant: 0, rightConstant: 5)
        videoSlider.setHeightConstraint(height: 25)
    }
    var player:AVPlayer?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupVidePlayer()
    {
        if let url = URL(string: "https://www.steppublishers.com/sites/default/files/step.mov")
        {
            player = AVPlayer(url:  url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            //track finishing time
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            //track time progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (time) in
                let seconds = String(format: "%02d", Int(time.seconds) % 60)
                let minutes = String(format: "%02d",  Int(time.seconds) / 60 )
                self.minutesLabel.text = "\(minutes):\(seconds)"
                
                if let duration = self.player?.currentItem?.duration
                {
                    let value = Double(seconds)! / duration.seconds
                    self.videoSlider.value = Float(value)
                }
                
            })
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"
        {
            activityIndicator.stopAnimating()
            containerView.backgroundColor = .clear
            isPlaying = true
            pauseButton.isHidden = false
            if let duration = player?.currentItem?.duration
            {
                let durationSeconds = String(format: "%02d", Int(duration.seconds) % 60)
                let durationMinutes = String(format: "%02d", Int(duration.seconds) / 60)
                durationLabel.text = " \(durationMinutes):\(durationSeconds)   "
            }
        }
    }
    func setupGradientLayer()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.5]
        containerView.layer.addSublayer(gradientLayer)
    }
}

class VideoLauncher {
    func showVideoPlayer()  {
        if let window = UIApplication.shared.keyWindow
        {
            let view = UIView()
            view.frame = CGRect(x: window.frame.width - 10, y: window.frame.height - 10, width: 10, height: 10)
            let width = window.frame.width
            let height = window.frame.width * 9 / 16
            let videPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            view.backgroundColor = .white
            UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                
            }) { (right) in
                UIApplication.shared.isStatusBarHidden = true
                
            }
            window.addSubview(view)
            view.addSubview(videPlayerView)
        }
    }
}
