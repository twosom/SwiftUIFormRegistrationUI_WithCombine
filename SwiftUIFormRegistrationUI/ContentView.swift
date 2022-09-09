//
//  ContentView.swift
//  SwiftUIFormRegistrationUI
//
//  Created by hope on 2022/09/09.
//
//

import SwiftUI

struct ContentView: View {

    @StateObject
    var viewModel: UserRegistrationViewModel = .init()

    var body: some View {
        VStack {
            Text("Create an account")
                .font(.system(.largeTitle, design: .rounded).bold())
                .padding(.bottom, 30)
                .padding(.top, 10)
            Group {
                FormField(fieldName: "Username", fieldValue: $viewModel.username)
                RequirementText(text: "A minimum of 4 characters", isStrikeThrough: viewModel.isUsernameLengthValid)
                    .animation(.default, value: viewModel.isUsernameLengthValid)

                FormField(fieldName: "Password", fieldValue: $viewModel.password, isSecure: true)
                RequirementText(iconName: "lock.open", text: "A minimum of 8 characters", isStrikeThrough: viewModel.isPasswordLengthValid)
                    .animation(.default, value: viewModel.isPasswordLengthValid)
                RequirementText(iconName: "lock.open", text: "One uppercase letter", isStrikeThrough: viewModel.isPasswordCapitalLetter)
                    .animation(.default, value: viewModel.isPasswordCapitalLetter)

                FormField(fieldName: "Confirm Password", fieldValue: $viewModel.passwordConfirm, isSecure: true)
                RequirementText(text: "Your confirm password should be the same as password", isStrikeThrough: viewModel.isPasswordConfirmValid)
                    .animation(.default, value: viewModel.isPasswordConfirmValid)
            }
            Spacer()
            SignUpButton(buttonActivate: $viewModel.buttonActivate)
            Spacer()
            HStack {
                Text("Already have an account?")
                    .font(.system(.body, design: .rounded).bold())

                Button {
                    print("Sign in button tapped")
                } label: {
                    Text("Sign in")
                        .font(.system(.body, design: .rounded).bold())
                        .foregroundColor(.red.opacity(0.5))
                }

            }
            Spacer()
            Spacer()
        }
            .autocapitalization(.none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FormField: View {

    var fieldName: String

    @Binding
    var fieldValue: String

    var isSecure: Bool = false

    var body: some View {
        VStack {
            Group {
                if isSecure {
                    SecureField(fieldName, text: $fieldValue)
                } else {
                    TextField(fieldName, text: $fieldValue)
                }
            }
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal)
            Divider()
                .frame(height: 1)
                .background(Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255))
        }
            .padding(.horizontal, 40)
            .padding([.bottom, .top], 15)
    }
}

struct RequirementText: View {

    var iconName = "xmark.app"
    var iconColor = Color(red: 251 / 255, green: 128 / 255, blue: 128 / 255)

    var text: String

    var isStrikeThrough: Bool = false

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(isStrikeThrough ? .secondary : iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
            Spacer()
        }
            .padding(.horizontal, 40)
    }
}

struct SignUpButton: View {

    @Binding
    var buttonActivate: Bool

    var body: some View {
        Button {
            print("Sign Up Tapped")
        } label: {
            Group {
                if buttonActivate {
                    Text("Sign Up")
                        .font(.system(.body, design: .rounded).bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [.red.opacity(0.5), .yellow.opacity(0.5)], startPoint: .leading, endPoint: .trailing))

                } else {
                    Text("Sign Up")
                        .font(.system(.body, design: .rounded).bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                }
            }
                .cornerRadius(10)
                .padding(.horizontal, 30)

        }
            .animation(.easeInOut(duration: 0.4), value: buttonActivate)
            .disabled(!buttonActivate)
    }
}
