//
//  AdMobBannerView.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 1/5/24.
//

import SwiftUI
import GoogleMobileAds

struct AdMobBannerView: UIViewControllerRepresentable {

    private var adUnitId: String

    public init(adUnitId: String) {
        self.adUnitId = adUnitId
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = self.adUnitId
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)

        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
