//
//  LoginView.swift
//  Firebase
//
//  Created by swft on 2/7/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginViewModelImpl(Service: LoginServiceImpl()
                                                    )
    
    var body: some View {
        VStack(spacing: 16){
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 26, alignment: .center)
                Text("Limit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.accentColor)
            }
            HStack {
                Text("Login:")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            VStack(spacing: 16){
                
                InputTextFieldView(text: $vm.credentials.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   sfSymbol: "envelope")
                
                InputPasswordView(password: $vm.credentials.password,
                                   placeholder: "Password",
                                   sfSymbol: "lock")
            }
            VStack(spacing: 16){
                
                ButtonView(title: "Login"){
                    
                    vm.login()
                    
                }
                
                ButtonView(title: "Register",
                           background: .clear,
                           foreground: .blue,
                           border: .blue){
                    showRegistration.toggle()
                
            }
                           .sheet(isPresented: $showRegistration, content:{
                               RegisterView()
                           })
            }
            HStack{
                
                Button(action:{
                    showForgotPassword.toggle()
                }, label:{
                    Text("Forgot Password?")
                })
                .font(.system(size: 16, weight: .bold))
                .sheet(isPresented: $showForgotPassword, content: {
                    ForgotPasswordView()
                })
            }
            
            
        }
        .padding(.horizontal, 15)
        .alert(isPresented: $vm.hasError, content: {
            
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Error"),
                             message: Text(error.localizedDescription)
                )
            }
            else {
                return Alert(title: Text("Error"),
                message: Text("Something went wrong"))
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
