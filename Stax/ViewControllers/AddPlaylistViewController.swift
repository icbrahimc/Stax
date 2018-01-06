//
//  AddPlaylistViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/3/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class AddPlaylistViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    let contentView = UIScrollView.newAutoLayout()
    let imageField = UIImageView.newAutoLayout()
    let titleField = UITextField.newAutoLayout()
    let descriptionField = UITextField.newAutoLayout()
    let appleMusicLink = UITextField.newAutoLayout()
    let spotifyLink = UITextField.newAutoLayout()
    let soundcloudLink = UITextField.newAutoLayout()
    let youtubeLink = UITextField.newAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /* Setup imagepicker delegate */
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        /* Setup textfield delegates  */
        titleField.delegate = self
        descriptionField.delegate = self
        appleMusicLink.delegate = self
        spotifyLink.delegate = self
        soundcloudLink.delegate = self
        youtubeLink.delegate = self
        
        layout()
        title = "Add Playlist"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addImage))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func addImage() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* UITextField methods */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
            textField.resignFirstResponder()
            descriptionField.becomeFirstResponder()
        } else if textField == descriptionField {
            textField.resignFirstResponder()
            appleMusicLink.becomeFirstResponder()
        } else if textField == appleMusicLink {
            textField.resignFirstResponder()
            spotifyLink.becomeFirstResponder()
        } else if textField == soundcloudLink {
            textField.resignFirstResponder()
            soundcloudLink.becomeFirstResponder()
        } else if textField == youtubeLink {
            // Todo: submit the playlist to the repo.
        }
        
        return true
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
            imageField.image = selectedImage
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
        
        contentView.autoPinEdgesToSuperviewEdges()
        
        setupImageView()
        imageField.autoAlignAxis(toSuperviewAxis: .vertical)
        imageField.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        imageField.autoSetDimension(.height, toSize: view.frame.height * 0.2)
        imageField.autoSetDimension(.width, toSize: view.frame.height * 0.2)
        
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
        
        setupAppleTextField()
        appleMusicLink.autoPinEdge(.top, to: .bottom, of: descriptionField)
        appleMusicLink.autoSetDimension(.width, toSize: view.frame.width)
        appleMusicLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        appleMusicLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupSpotifyTextField()
        spotifyLink.autoPinEdge(.top, to: .bottom, of: appleMusicLink)
        spotifyLink.autoSetDimension(.width, toSize: view.frame.width)
        spotifyLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        spotifyLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupYoutubeTextField()
        youtubeLink.autoPinEdge(.top, to: .bottom, of: spotifyLink)
        youtubeLink.autoSetDimension(.width, toSize: view.frame.width)
        youtubeLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        youtubeLink.autoAlignAxis(toSuperviewAxis: .vertical)
        
        setupSoundcloudTextField()
        soundcloudLink.autoPinEdge(.top, to: .bottom, of: youtubeLink)
        soundcloudLink.autoSetDimension(.width, toSize: view.frame.width)
        soundcloudLink.autoSetDimension(.height, toSize: view.frame.height * 0.1)
        soundcloudLink.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    func addSubviews() {
        print("Add subviews")
        view.addSubview(contentView)
        contentView.addSubview(imageField)
        contentView.addSubview(titleField)
        contentView.addSubview(descriptionField)
        contentView.addSubview(appleMusicLink)
        contentView.addSubview(spotifyLink)
        contentView.addSubview(soundcloudLink)
        contentView.addSubview(youtubeLink)
    }
    
    func setupImageView() {
        imageField.backgroundColor = .black
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
    
    func setupAppleTextField() {
        appleMusicLink.placeholder = "Apple Music Link"
        appleMusicLink.font = UIFont.boldSystemFont(ofSize: 30.0)
        appleMusicLink.textAlignment = .center
        appleMusicLink.borderStyle = .none
    }
    
    func setupSpotifyTextField() {
        spotifyLink.placeholder = "Spotify Link"
        spotifyLink.font = UIFont.boldSystemFont(ofSize: 30.0)
        spotifyLink.textAlignment = .center
        spotifyLink.borderStyle = .none
    }
    
    func setupSoundcloudTextField() {
        soundcloudLink.placeholder = "SoundCloud Link"
        soundcloudLink.font = UIFont.boldSystemFont(ofSize: 30.0)
        soundcloudLink.textAlignment = .center
        soundcloudLink.borderStyle = .none
    }
    
    func setupYoutubeTextField() {
        youtubeLink.placeholder = "YouTube Link"
        youtubeLink.font = UIFont.boldSystemFont(ofSize: 30.0)
        youtubeLink.textAlignment = .center
        youtubeLink.borderStyle = .none
    }
}
