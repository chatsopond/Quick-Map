//
//  LegacyTextField.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//  Original: https://stackoverflow.com/a/67892111/11911474
//

import SwiftUI

struct LegacyTextField: UIViewRepresentable {
    @Binding public var isFirstResponder: Bool
    @Binding public var text: String
    public let placeholder: String

    public var configuration = { (view: UITextField) in }

//    public init(text: Binding<String>, isFirstResponder: Binding<Bool>, configuration: @escaping (UITextField) -> () = { _ in }) {
//        self.configuration = configuration
//        self._text = text
//        self._isFirstResponder = isFirstResponder
//    }

    public func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        view.placeholder = placeholder
        return view
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        DispatchQueue.main.async {
            switch isFirstResponder {
            case true: uiView.becomeFirstResponder()
            case false: uiView.resignFirstResponder()
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>

        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>) {
            self.text = text
            self.isFirstResponder = isFirstResponder
        }

        @objc public func textViewDidChange(_ textField: UITextField) {
            self.text.wrappedValue = textField.text ?? ""
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            self.isFirstResponder.wrappedValue = true
        }

//        public func textFieldDidEndEditing(_ textField: UITextField) {
//            self.isFirstResponder.wrappedValue = false
//        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.isFirstResponder.wrappedValue = false
            return true
        }
    }
}
