//
// Created by hope on 2022/09/09.
//

import Foundation
import Combine

final class UserRegistrationViewModel: ObservableObject {

    // INPUT
    @Published(initialValue: "")
    var username: String
    @Published(initialValue: "")
    var password: String
    @Published(initialValue: "")
    var passwordConfirm: String

    // OUTPUT
    @Published(initialValue: false)
    var isUsernameLengthValid: Bool
    @Published(initialValue: false)
    var isPasswordLengthValid: Bool
    @Published(initialValue: false)
    var isPasswordCapitalLetter: Bool
    @Published(initialValue: false)
    var isPasswordConfirmValid: Bool

    @Published(initialValue: false)
    var buttonActivate: Bool


    var subscriptions = Set<AnyCancellable>()

    init() {
        bind()
    }


    private func bind() {
        $username
            .receive(on: RunLoop.main)
            .map {
                $0.count >= 4
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &subscriptions)

        $password
            .receive(on: RunLoop.main)
            .map {
                $0.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &subscriptions)

        $password
            .receive(on: RunLoop.main)
            .map { password -> Bool in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &subscriptions)

        $password.combineLatest($passwordConfirm)
            .receive(on: RunLoop.main)
            .map { password, passwordConfirm in
                !password.isEmpty && (password == passwordConfirm)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &subscriptions)

        $isUsernameLengthValid
            .combineLatest($isPasswordLengthValid, $isPasswordCapitalLetter, $isPasswordConfirmValid)
            .map {
                $0 && $1 && $2 && $3
            }
            .assign(to: \.buttonActivate, on: self)
            .store(in: &subscriptions)
    }
}
