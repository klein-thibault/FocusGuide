//
//  ViewController.swift
//  FocusGuide
//
//  Created by Thibault Klein on 10/12/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!

    private var focusGuide = UIFocusGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We create a focus guide to fill the space between the more infos button and the buy button since it's not obvious for the
        // focus engine which element should be focused.
        self.view.addLayoutGuide(self.focusGuide)

        // Left and top anchors
        self.focusGuide.leftAnchor.constraint(equalTo: self.buyButton.leftAnchor).isActive = true
        self.focusGuide.topAnchor.constraint(equalTo: self.moreInfoButton.topAnchor).isActive = true

        // Width and height
        self.focusGuide.widthAnchor.constraint(equalTo: self.buyButton.widthAnchor).isActive = true
        self.focusGuide.heightAnchor.constraint(equalTo: self.moreInfoButton.heightAnchor).isActive = true
    }

    // MARK: UIFocusElement Methods

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        guard let nextFocusedView = context.nextFocusedView else { return }

        // When the focus engine focus the focus guide, we can set programmatically which element should be focused next.
        switch nextFocusedView {
        case self.moreInfoButton:
            self.focusGuide.preferredFocusedView = self.buyButton

        case self.buyButton:
            self.focusGuide.preferredFocusedView = self.moreInfoButton

        default:
            self.focusGuide.preferredFocusedView = nil
        }
    }

}

