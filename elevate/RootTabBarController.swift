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
        homeController?.tabBarItem.title = "HOME"
        homeController?.tabBarItem.image = UIImage(named: "NavIcon_Home")?.withRenderingMode(UIImageRenderingMode.automatic)
        homeController?.tabBarItem.selectedImage = UIImage(named: "NavIcon_Home")?.withRenderingMode(UIImageRenderingMode.automatic)
        homeNavController = UINavigationController(rootViewController: homeController!)
        homeNavController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        homeNavController.navigationBar.shadowImage = UIImage()
        homeNavController.navigationBar.isTranslucent = true
        homeNavController.navigationBar.backgroundColor = UIColor.clear
        homeNavController.tabBarItem = homeController?.tabBarItem
    }

    private func setupOrdersViewController() {
        let ordersController = OrdersTableViewController(nibName: String(describing: OrdersTableViewController.self), bundle: nil)
        ordersController.tabBarItem.title = "ORDERS"
        ordersController.tabBarItem.image = UIImage(named: "NavIcon_Contents")?.withRenderingMode(UIImageRenderingMode.automatic)
        ordersController.tabBarItem.selectedImage = UIImage(named: "NavIcon_Contents")?.withRenderingMode(UIImageRenderingMode.automatic)
        ordersNavController = UINavigationController(rootViewController: ordersController)
        ordersNavController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        ordersNavController.navigationBar.shadowImage = UIImage()
        ordersNavController.navigationBar.isTranslucent = true
        ordersNavController.navigationBar.backgroundColor = UIColor.clear
        ordersNavController.tabBarItem = ordersController.tabBarItem
    }

    private func setupSettingsViewController() {
        let settingsController = SettingsTableViewController(nibName: String(describing: SettingsTableViewController.self), bundle: nil)
        settingsController.tabBarItem.title = "SETTINGS"
        settingsController.tabBarItem.image = UIImage(named: "NavIcon_Settings")?.withRenderingMode(UIImageRenderingMode.automatic)
        settingsController.tabBarItem.selectedImage = UIImage(named: "NavIcon_Settings")?.withRenderingMode(UIImageRenderingMode.automatic)
        settingsNavController = UINavigationController(rootViewController: settingsController)
        settingsNavController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        settingsNavController.navigationBar.shadowImage = UIImage()
        settingsNavController.navigationBar.isTranslucent = true
        settingsNavController.navigationBar.backgroundColor = UIColor.clear
        settingsNavController.tabBarItem = settingsController.tabBarItem
    }
}
