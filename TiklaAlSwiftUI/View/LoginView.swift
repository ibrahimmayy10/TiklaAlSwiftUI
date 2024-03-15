//
//  ContentView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 13.02.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.white)
                }
                
                Form {
                    TextField("Email adresinizi giriniz", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Şifrenizi giriniz", text: $viewModel.password)
                }
                .background(.red)
                .cornerRadius(20)
                .frame(height: 150)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                BigButtonView(title: "Giriş Yap", action: {
                    viewModel.signIn { success in
                        if success {
                            isPresented = true
                        } else {
                            
                        }
                    }
                })
                
                Spacer()
                
                VStack {
                    Text("Hesabın yok mu ?")
                        .foregroundStyle(.white)
                    NavigationLink("Hesap oluştur", destination: RegisterView())
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 20)
            }
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
            .edgesIgnoringSafeArea(.all)
            .background(
                NavigationLink(destination: MainView(), isActive: $isPresented) { EmptyView() }
            )
        }
    }
}

#Preview {
    LoginView()
}
