import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    fileprivate var homeNavController: UINavigationController!
    fileprivate var ordersNavController: UINavigationController!
    fileprivate var settingsNavController: UINavigationController!

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.barStyle = UIBarStyle.default
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = true
        tabBar.alpha = 0.9
        setupHomeViewController()
        setupOrdersViewController()
        setupSettingsViewController()
        viewControllers = [homeNavController, ordersNavController, settingsNavController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController = storyboard.instantiateInitialViewController()
        homeController?.title = "HOME"
        homeController?.tabBarItem.image = UIImage(named: "NavIcon_Home")?.withRenderingMode(UIImageRenderingMode.automatic)
        homeController?.tabBarItem.selectedImage = UIImage(named: "NavIcon_Home")?.withRenderingMode(UIImageRenderingMode.automatic)
        homeNavController = UINavigationController(rootViewController: homeController!)
        homeNavController.tabBarItem = homeController?.tabBarItem
    }

    private func setupOrdersViewController() {
        let ordersController = OrdersTableViewController(nibName: String(describing: OrdersTableViewController.self), bundle: nil)
        ordersController.title = "ORDERS"
        ordersController.tabBarItem.image = UIImage(named: "NavIcon_Contents")?.withRenderingMode(UIImageRenderingMode.automatic)
        ordersController.tabBarItem.selectedImage = UIImage(named: "NavIcon_Contents")?.withRenderingMode(UIImageRenderingMode.automatic)
        ordersNavController = UINavigationController(rootViewController: ordersController)
        ordersNavController.tabBarItem = ordersController.tabBarItem
    }

    private func setupSettingsViewController() {
        let settingsController = SettingsTableViewController(nibName: String(describing: SettingsTableViewController.self), bundle: nil)
        settingsController.title = "SETTINGS"
        settingsController.tabBarItem.image = UIImage(named: "NavIcon_Settings")?.withRenderingMode(UIImageRenderingMode.automatic)
        settingsController.tabBarItem.selectedImage = UIImage(named: "NavIcon_Settings")?.withRenderingMode(UIImageRenderingMode.automatic)
        settingsNavController = UINavigationController(rootViewController: settingsController)
        settingsNavController.tabBarItem = settingsController.tabBarItem
    }
}
