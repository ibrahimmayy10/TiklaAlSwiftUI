//
//  AccountView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 7.03.2024.
//

import SwiftUI
import FirebaseFirestoreInternal

struct AccountView: View {
    
    @ObservedObject var accountViewModel = AccountViewModel()
    
    @State private var isOrderListVisible = false
    @State private var isLoading = false
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(.red)
                    Image(systemName: "person")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                .frame(width: 70, height: 70)
                
                VStack(alignment: .leading) {
                    Text(accountViewModel.name)
                    
                    Text(accountViewModel.email)
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
                
                Spacer()
            }
            .padding(.leading)
            
            Button(action: {
                isOrderListVisible.toggle()
            }, label: {
                Image(systemName: "cube.box")
                    .foregroundStyle(.red)
                
                Text("Tüm Siparişlerim")
                    .foregroundStyle(.black)
                    .padding(.leading, 5)
            })
            .padding(.top)
            
            Spacer()
            
            if isOrderListVisible {
                List(accountViewModel.orders, id: \.id) { order in
                    VStack(alignment: .leading) {
                        Text("\(order.time.dateValue(), formatter: DateFormatter())")
                            .foregroundStyle(Color(uiColor: .systemGray))
                        
                        HStack {
                            Text("Toplam")
                                .foregroundStyle(Color(uiColor: .systemGray))
                            
                            Text("$\(Int(order.totalPrice))")
                                .foregroundStyle(.red)
                        } 
                        
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                            
                            Text("Teslim Edildi")
                                .foregroundStyle(.green)
                        }
                        .padding(.top)
                        
                        AsyncImage(url: URL(string: order.thumbnail)) { image in image
                                .image?
                                .resizable()
                                .frame(width: 30, height: 40)
                        }
                        
                        Text("\(order.piece) ürün teslim edildi")
                            .foregroundStyle(Color(uiColor: .systemGray))
                            .font(.subheadline)
                    }
                }
                .padding(.top)
            }
            
            Button(action: {
                accountViewModel.signOut { success in
                    if success {
                        isPresented = true
                    } else {
                        
                    }
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .foregroundStyle(.red)
                    
                    Text("Çıkış Yap")
                        .foregroundStyle(.white)
                }
            })
            
            ButtonBarView(currentView: .account)
        }
        .navigationBarBackButtonHidden()
        .task {
            accountViewModel.getDataUser()
            accountViewModel.getDataOrder()
        }
        .background(
            NavigationLink(destination: LoginView(), isActive: $isPresented) { EmptyView() }
        )
    }
}

#Preview {
    AccountView()
}
