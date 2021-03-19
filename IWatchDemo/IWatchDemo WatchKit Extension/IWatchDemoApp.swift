//
//  IWatchDemoApp.swift
//  IWatchDemo WatchKit Extension
//
//  Created by 你吗 on 2021/3/19.
//

import SwiftUI

@main
struct IWatchDemoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
