//
//  RegisterView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
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
                    TextField("Adınızı Giriniz", text: $viewModel.name)
                    TextField("Email adresinizi giriniz", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Şifrenizi giriniz", text: $viewModel.password)
                }
                .background(.red)
                .cornerRadius(20)
                .frame(height: 200)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                BigButtonView(title: "Kayıt ol", action: {
                    viewModel.register { success in
                        if success {
                            isPresented = true
                        } else {
                            
                        }
                    }
                })
                
                Spacer()
                
                VStack {
                    Text("Zaten bir hesabın var mı ?")
                        .foregroundStyle(.white)
                    NavigationLink("Giriş yap", destination: LoginView())
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 20)
            }
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
            .edgesIgnoringSafeArea(.all)
            .background(
                NavigationLink(destination: LoginView(), isActive: $isPresented) { EmptyView() }
            )
        }
    }
}

#Preview {
    RegisterView()
}
