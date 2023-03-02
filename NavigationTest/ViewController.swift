import SwiftUI
import UIKit

class ViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let button = UIButton(type: .system)
        button.addTarget(self,
                         action: #selector(buttonTapped),
                         for: .touchUpInside)
        button.setTitle("Push without intermediate controller", for: .normal)
        
        let button2 = UIButton(type: .system)
        button2.addTarget(self,
                         action: #selector(buttonTapped2),
                         for: .touchUpInside)
        button2.setTitle("Push with intermediate controller", for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [button, button2])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.view = view
    }
    
    @objc func buttonTapped() {
        let hostingController = UIHostingController(rootView: SwiftUIView())
        navigationController?.pushViewController(hostingController,
                                                 animated: true)
    }
    
    @objc func buttonTapped2() {
        let hostingController = UIHostingController(rootView: SwiftUIView())
        let intermediateController = IntermediateViewController(childViewController: hostingController)
        navigationController?.pushViewController(intermediateController,
                                                 animated: true)
    }
}

class IntermediateViewController: UIViewController {
    let childViewController: UIViewController
    init(childViewController: UIViewController) {
        self.childViewController = childViewController
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        addChild(childViewController)
        edgesForExtendedLayout = .all
        
        childViewController.view.frame = view.frame
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct SwiftUIView: View {
  var body: some View {
    ScrollView {
        ForEach(1..<100) { item in
            Text("Test - \(item)")
        }
        .frame(maxWidth: .infinity,
               alignment: .center)
    }
    .background(Color.gray)
    .navigationTitle("Title")
  }
}
