import UIKit
import MMDrawerController

class ContainerViewController: MMDrawerController, UINavigationControllerDelegate {
    fileprivate let middleNavController: UINavigationController
    fileprivate let leftController: UIViewController
    fileprivate var leftBarButtonItem: UIBarButtonItem!

    init() {
        leftController = OptionsTableViewController()
        middleNavController = UINavigationController(rootViewController: OptionsTableViewController())
        super.init(nibName: nil, bundle: nil)
        leftDrawerViewController = leftController
        centerViewController = middleNavController
        middleNavController.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        middleNavController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(leftBarButtonPressed))
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        showsShadow = false
        maximumRightDrawerWidth = 250
        maximumLeftDrawerWidth = 250
        openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        centerHiddenInteractionMode = MMDrawerOpenCenterInteractionMode.none
    }

    @objc func leftBarButtonPressed() {
        self.open(MMDrawerSide.left, animated: true, completion: { (success) in
        })
    }
}
