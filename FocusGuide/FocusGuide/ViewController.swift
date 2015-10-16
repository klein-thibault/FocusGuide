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
        self.focusGuide.leftAnchor.constraintEqualToAnchor(self.buyButton.leftAnchor).active = true
        self.focusGuide.topAnchor.constraintEqualToAnchor(self.moreInfoButton.topAnchor).active = true

        // Width and height
        self.focusGuide.widthAnchor.constraintEqualToAnchor(self.buyButton.widthAnchor).active = true
        self.focusGuide.heightAnchor.constraintEqualToAnchor(self.moreInfoButton.heightAnchor).active = true
    }

    // MARK: UIFocusElement Methods

    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)

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

