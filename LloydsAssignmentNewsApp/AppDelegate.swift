//
//  AppDelegate.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigator: NewsAppNavigator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var mockFlow = false
        if CommandLine.arguments.contains("UITesting") {
            mockFlow = true
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        navigator = NewsAppNavigator(navigationController: navController)
        window?.rootViewController = navigator?.navigationController
        navigator?.start(with: mockFlow)
        window?.makeKeyAndVisible()
        navigationBarSetup()
        return true
    }

}

extension AppDelegate {
    func navigationBarSetup() {
        let newNavBarAppearance = customNavBarAppearance()
                
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = newNavBarAppearance
        appearance.compactAppearance = newNavBarAppearance
        appearance.standardAppearance = newNavBarAppearance
        if #available(iOS 15.0, *) {
            appearance.compactScrollEdgeAppearance = newNavBarAppearance
        }

    }

    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        // Apply a white background.
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = .white
        
        // Apply black colored normal and large titles.
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]


        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.black]
        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        return customNavBarAppearance
    }
}
