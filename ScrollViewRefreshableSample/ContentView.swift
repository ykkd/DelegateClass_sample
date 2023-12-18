//
//  ContentView.swift
//  ScrollViewRefreshableSample
//
//  Created by ykkd on 2023/12/05.
//

import SwiftUI
import UIKit

actor ViewData: ObservableObject {

    @MainActor @Published private(set) var titles: [Title] = []

    init() {}

    func updateTitles(_ value: [Title]) async {
        await MainActor.run {
            titles = value
        }
    }
}

struct Title: Identifiable {
    var id = UUID()
    var text: String
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setHostingController(
            swiftUIView: ContentView(
                viewData: ViewData()
            )
        )
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "MainVC"
    }
}


struct ContentView: View {
    
    @ObservedObject var viewData: ViewData
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: .zero) {
                ForEach(viewData.titles, id: \.id) { title in
                    Text(title.text)
                        .frame(height: 200)
                }
            }
        }
        .onAppear {
            Task {
                await generateRandomTitles()
            }
        }
        .refreshable {
            Task {
                try? await Task.sleep(nanoseconds: UInt64(2.0) * 1_000_000_000)
                await generateRandomTitles()
            }
        }
    }
    
    func generateRandomTitles() async {
        let sampleTitles = ["Title 1", "Title 2", "Title 3", "Title 4", "Title 5"]
        let randomCount = Int.random(in: 1...5)
        let titles = (0..<randomCount).map { _ in Title(text: sampleTitles.randomElement()!) }
        await viewData.updateTitles(titles)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewData: .init())
    }
}

extension UIViewController {

    public func setHostingController(
        swiftUIView: some View,
        backgroundColor: UIColor? = .white
    ) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        if let backgroundColor {
            hostingController.view.backgroundColor = backgroundColor
        }
        hostingController.didMove(toParent: self)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.pinEdgesToSuperview()
    }
}

extension UIView {
    
    public func pinEdgesToSuperview() {
        let constraintAttributes: [NSLayoutConstraint.Attribute] = [.left, .right, .top, .bottom]
        let constraints = constraintAttributes.map {
            NSLayoutConstraint(
                item: self,
                attribute: $0,
                relatedBy: .equal,
                toItem: superview,
                attribute: $0,
                multiplier: 1.0,
                constant: .zero
            )
        }
        superview?.addConstraints(constraints)
    }
}
