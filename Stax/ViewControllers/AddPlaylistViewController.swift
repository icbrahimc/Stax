//
//  AddPlaylistViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/3/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class AddPlaylistViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    var playlist: Playlist?
    let imagePicker = UIImagePickerController()
    let contentView = UIScrollView.newAutoLayout()
    let imageField = UIButton.newAutoLayout()
    let titleField = UITextField.newAutoLayout()
    let descriptionField = UITextField.newAutoLayout()
    let appleMusicLink = UIButton.newAutoLayout()
    let spotifyLink = UIButton.newAutoLayout()
    let soundcloudLink = UIButton.newAutoLayout()
    let youtubeLink = UIButton.newAutoLayout()
    
    var bottomScrollViewConstraint: NSLayoutConstraint?
    var topScrollViewConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /* Setup imagepicker delegate */
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        /* Setup textfield delegates  */
        titleField.delegate = self
        descriptionField.delegate = self
        
        layout()
        title = "Add Playlist"
        
        imageField.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        appleMusicLink.addTarget(self, action: #selector(addAppleMusicLink), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(submitPlaylist))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelCreate))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /* Custom methods */
    @objc func addImage() {
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3,  options: [], animations: {
            self.imageField.alpha = 0.5
        }, completion: { success in
        })
        
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3,  options: [], animations: {
            self.imageField.alpha = 1.0
        }, completion: { success in
        })
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func cancelCreate() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func submitPlaylist() {
        playlist = Playlist()
        if let title = titleField.text {
            playlist?.title = title
        }
        
        if let description = descriptionField.text {
            playlist?.description = description
        }
        
//        if let appleMusicLink = appleMusicLink.text {
//            playlist?.appleLink = appleMusicLink
//        }
        
//        if let spotifyMusicLink = spotifyLink.text {
//            playlist?.spotifyLink = spotifyMusicLink
//        }
        
        BaseAPI.sharedInstance.addPlaylist(playlist!, completionBlock: { (documentID) in
            BaseAPI.sharedInstance.savePhotoIntoDB(documentID, image: (self.imageField.imageView?.image)!, completionBlock: { () in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    /* UITextField methods */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
            textField.resignFirstResponder()
            descriptionField.becomeFirstResponder()
        } else if textField == descriptionField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    /* Apple music button methods */
    @objc func addAppleMusicLink() {
        let alertController = UIAlertController(title: "Enter Apple Music Link", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Add Apple Music Link"
        }
        
        let addLinkAction = UIAlertAction(title: "Add Link", style: .default) { (alert) in
            let textField = alertController.textFields![0] as UITextField
            
            // TODO: icbrahimc: move this to an outer function.
            if let linkText = textField.text {
                let linkParams = parseAppleLink(linkText)
                
                let storeFront = linkParams[0]
                let id = linkParams[1]
                
                let apiCall = "https://api.music.apple.com/v1/catalog/\(storeFront)/playlists/\(id)"
                
                let url = URL(string: apiCall)
                let headers: HTTPHeaders = [
                    "Authorization" : "Bearer \(Constants.APPLE)"
                ]
                
                Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).validate().responseJSON { (data) in
                    guard let response = data.data else {
                        print("Error no data present")
                        return
                    }
                    
                    self.playlist?.appleLink = linkText
                    let appleJSON = JSON(response)
                    
                    let data = appleJSON["data"][0]
                    let attributes = data["attributes"]
                    
                    if let imageURL = attributes["artwork"]["url"].string {
                        let height = attributes["artwork"]["height"].stringValue
                        let width = attributes["artwork"]["width"].stringValue
                        
                        var finalImageURL = imageURL.replacingOccurrences(of: "{w}", with: width)
                        finalImageURL = finalImageURL.replacingOccurrences(of: "{h}", with: height)
                        
                        self.imageField.loadImageUsingCacheWithUrlString(finalImageURL)
                    }
                    
                    if let name = attributes["name"].string {
                        self.playlist?.title = name
                        self.titleField.text = name
                    }
                    
                    if let curatorName = attributes["curatorName"].string {
                        self.playlist?.creatorUsername = curatorName
                    }
                    
                    if let description = attributes["description"]["standard"].string {
                        self.descriptionField.text = description
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.appleMusicLink.alpha = 1.0
                    })
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addAction(addLinkAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /* UIImagePickerController methods */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPkr: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPkr = originalImage as! UIImage
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImageFromPkr = editedImage as! UIImage
        }
        
        if let selectedImage = selectedImageFromPkr {
            imageField.setImage(selectedImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddPlaylistViewController {
    func layout () {
        addSubviews()
        
        contentView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        contentView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        contentView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        contentView.autoAlignAxis(toSuperviewAxis: .vertical)
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        setupImageView()
        imageField.autoAlignAxis(toSuperviewAxis: .vertical)
        imageField.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        imageField.autoSetDimension(.height, toSize: view.frame.height * 0.3)
        imageField.autoSetDimension(.width, toSize: view.frame.height * 0.3)
        
        setupTitleField()
        titleField.autoPinEdge(.top, to: .bottom, of: imageField, withOffset: 10)
        titleField.autoSetDimension(.width, toSize: view.frame.width)
        titleField.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        titleField.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupDescription()
        descriptionField.autoPinEdge(.top, to: .bottom, of: titleField)
        descriptionField.autoSetDimension(.width, toSize: view.frame.width)
        descriptionField.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        descriptionField.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupAppleBtn()
        appleMusicLink.autoPinEdge(.top, to: .bottom, of: descriptionField)
        appleMusicLink.autoSetDimension(.width, toSize: view.frame.width)
        appleMusicLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        appleMusicLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupSpotifyBtn()
        spotifyLink.autoPinEdge(.top, to: .bottom, of: appleMusicLink)
        spotifyLink.autoSetDimension(.width, toSize: view.frame.width)
        spotifyLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        spotifyLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
//        setupYoutubeTextField()
//        youtubeLink.autoPinEdge(.top, to: .bottom, of: spotifyLink)
//        youtubeLink.autoSetDimension(.width, toSize: view.frame.width)
//        youtubeLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
//        youtubeLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
//        setupSoundcloudTextField()
//        soundcloudLink.autoPinEdge(.top, to: .bottom, of: youtubeLink)
//        soundcloudLink.autoSetDimension(.width, toSize: view.frame.width)
//        soundcloudLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
//        soundcloudLink.autoAlignAxis(toSuperviewAxis: .vertical)
//        soundcloudLink.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func addSubviews() {
        print("Add subviews")
        view.addSubview(contentView)

        contentView.addSubview(imageField)
        contentView.addSubview(titleField)
        contentView.addSubview(descriptionField)
        contentView.addSubview(appleMusicLink)
        contentView.addSubview(spotifyLink)
//        contentView.addSubview(soundcloudLink)
//        contentView.addSubview(youtubeLink)
    }
    
    func setupImageView() {
        imageField.setImage(#imageLiteral(resourceName: "yourimagehere"), for: .normal)
        imageField.layer.cornerRadius = 25.0
        imageField.layer.borderWidth = 1.0
        imageField.layer.masksToBounds = true
    }
    
    func setupTitleField() {
        titleField.placeholder = "Title"
        titleField.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleField.textAlignment = .center
        titleField.borderStyle = .none
    }
    
    func setupDescription() {
        descriptionField.placeholder = "Description"
        descriptionField.font = UIFont.boldSystemFont(ofSize: 30.0)
        descriptionField.textAlignment = .center
        descriptionField.borderStyle = .none
    }
    
    func setupAppleBtn() {
        appleMusicLink.setTitle("Apple Music", for: .normal)
        appleMusicLink.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        appleMusicLink.titleLabel?.textAlignment = .center
        appleMusicLink.setTitleColor(UIColor.black, for: .normal)
        appleMusicLink.alpha = 0.25
    }
    
    func setupSpotifyBtn() {
        spotifyLink.setTitle("Spotify Link", for: .normal)
        spotifyLink.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        spotifyLink.titleLabel?.textAlignment = .center
        spotifyLink.setTitleColor(UIColor.black, for: .normal)
        spotifyLink.alpha = 0.25
    }
    
//    func setupSoundcloudTextField() {
//        soundcloudLink.placeholder = "SoundCloud Link"
//        soundcloudLink.font = UIFont.boldSystemFont(ofSize: 30.0)
//        soundcloudLink.textAlignment = .center
//        soundcloudLink.borderStyle = .none
//    }
//
//    func setupYoutubeTextField() {
//        youtubeLink.placeholder = "YouTube Link"
//        youtubeLink.font = UIFont.boldSystemFont(ofSize: 30.0)
//        youtubeLink.textAlignment = .center
//        youtubeLink.borderStyle = .none
//    }
}
