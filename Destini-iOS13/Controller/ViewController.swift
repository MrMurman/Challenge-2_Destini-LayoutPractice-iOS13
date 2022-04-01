//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    
    var choiceOneButton: UIButton! {
        didSet {
            choiceOneButton.layer.cornerRadius = 25
            choiceOneButton.layer.masksToBounds = true
            choiceOneButton.titleLabel?.numberOfLines = 0
            choiceOneButton.setBackgroundImage(UIImage(named: "choice1Background"), for: .normal)
            choiceOneButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    var choiceTwoButton: UIButton! {
        didSet {
            choiceTwoButton.layer.cornerRadius = 25
            choiceTwoButton.layer.masksToBounds = true
            choiceTwoButton.titleLabel?.numberOfLines = 0
            choiceTwoButton.setBackgroundImage(UIImage(named: "choice2Background"), for: .normal)
            choiceTwoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    var storyLabel: UILabel! {
        didSet {
            storyLabel.textColor = .white
            storyLabel.numberOfLines = 0
            storyLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    var storyBrain: StoryBrain!
    
    var currentStory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        storyBrain = StoryBrain()
        setupUI()
        updateUI(story: storyBrain.currentStory)
        
        

    }
    
    @objc func choiceMade(sender: UIButton) {
        storyBrain.nextStory(userChoice: sender.titleLabel?.text)
        updateUI(story: storyBrain.currentStory)
        print(storyBrain.currentStory)
    }

    //MARK: - UI Setup
    
    func setupUI() {
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.frame = view.frame
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        
        storyLabel = UILabel()
        
        choiceOneButton = UIButton()
        choiceOneButton.addTarget(self, action: #selector(choiceMade(sender:)), for: .touchUpInside)
        
        choiceTwoButton = UIButton()
        choiceTwoButton.addTarget(self, action: #selector(choiceMade(sender:)), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [choiceOneButton, choiceTwoButton])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20
        
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        choiceOneButton.translatesAutoresizingMaskIntoConstraints = false
        choiceTwoButton.translatesAutoresizingMaskIntoConstraints = false
        
        let vStack = UIStackView(arrangedSubviews: [storyLabel, buttonStack])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fillEqually
     
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            vStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            storyLabel.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.3)])
    }


    func updateUI(story: Int) {
        storyLabel.text = storyBrain.stories[story].title
        choiceOneButton.setTitle(storyBrain.stories[story].choice1, for: .normal)
        choiceTwoButton.setTitle(storyBrain.stories[story].choice2, for: .normal)
    }
}



//MARK: - Canvas
struct FlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let view = ViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> ViewController {
            return view
        }
        
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
        
    }
    
}
