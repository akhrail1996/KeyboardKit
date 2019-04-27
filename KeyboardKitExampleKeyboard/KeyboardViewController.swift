//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 In the demo app, the keyboard will handle system actions as
 normal (e.g. change keyboard, space, new line etc.), inject
 plain string characters into the proxy and handle emojis by
 copying them on tap and saving them to photos on long press.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription`  to the host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup.
 
 */

import UIKit
import KeyboardKit

class KeyboardViewController: GridKeyboardViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridPresenter = GridKeyboardPresenter(id: "foo", viewController: self)
        setupKeyboard(for: UIScreen.main.bounds.size)
        setupSystemButtons()
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Properties
    
    var alerter = ToastAlert()
    
    var gridPresenter: GridKeyboardPresenter!
    
    var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            view.tintColor = keyboardAppearance == .dark ? .white : .black
        }
    }
    
    
    // MARK: - Setup
    
    open override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.contentInset.top = 5
        collectionView.contentInset.bottom = 10
        collectionView.register(DemoCell.defaultNib, forCellWithReuseIdentifier: "Cell")
    }
    
    
    // MARK: - Layout
    
    override func layoutSystemButtons(_ buttons: [UIView], buttonSize: CGSize, startX: CGFloat, y: CGFloat) {
        super.layoutSystemButtons(buttons, buttonSize: buttonSize, startX: startX, y: y)
        buttons.forEach {
            let center = $0.center
            $0.frame.size = CGSize(width: 25, height: 25)
            $0.center = center
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard
            let action = keyboardAction(at: indexPath),
            let buttonCell = cell as? DemoCell
            else { return cell }
        buttonCell.setup(with: action, appearance: keyboardAppearance, tintColor: collectionView.tintColor)
        addLongPressGesture(for: action, to: buttonCell)
        return cell
    }
}


// MARK: - Setup

private extension KeyboardViewController {
    
    func setupKeyboard(for size: CGSize) {
        let isLandscape = size.width > 400
        let height: CGFloat = isLandscape ? 150 : 200
        let rowsPerPage = isLandscape ? 3 : 4
        let buttonsPerRow = isLandscape ? 8 : 6
        setup(withKeyboard: DemoKeyboard(), height: height, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
    }
    
    func setupSystemButtons() {
        setupLeftSystemButtons()
        setupRightSystemButtons()
    }
    
    func setupLeftSystemButtons() {
        leftSystemButtons = [
            createSystemButton(image: Asset.globe.image, action: .nextKeyboard),
            createSystemButton(image: Asset.space.image, action: .space)
            ].compactMap { $0 }
    }
    
    func setupRightSystemButtons() {
        rightSystemButtons = [
            createSystemButton(image: Asset.backspace.image, action: .backspace),
            createSystemButton(image: Asset.newline.image, action: .newLine)
            ].compactMap { $0 }
    }
}


// MARK: - Private Functions

extension KeyboardViewController {
    
    func alert(_ message: String) {
        alerter.alert(message: message, in: view, withDuration: 4)
    }
    
    func image(for action: KeyboardAction) -> UIImage? {
        switch action {
        case .image(_, _, let imageName): return UIImage(named: imageName)
        default: return nil
        }
    }
}
