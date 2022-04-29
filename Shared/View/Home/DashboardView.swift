//
//  DashboardView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 09-03-22.
//

import SwiftUI

let tabs = ["gearshape.fill", "chart.bar.xaxis", "house.fill", "magnifyingglass"]

struct DashboardView: View {
    
    @State var backToLogin = false
    @State var selectedTab = "chart.bar.xaxis"
    
    var body: some View {
        
        ZStack {
            CustomTabView()
                .accentColor(.white)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .preferredColorScheme(.dark)
                .background(
                    RoundedRectangle(cornerRadius: 1, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .blur(radius: 20)
                        .opacity(0.8)
                )
                .padding(.bottom, 25)
        }
        .ignoresSafeArea()
        .background(
            Image("wallpaper2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.4)
        )
       
    }
    
}

struct TabButtonview: View {
    
    @Binding var selectedTab: String
    var imageName: String
    
    var body: some View {
        Button {
            selectedTab = imageName
        } label: {
            VStack(spacing: 2) {
                Image(systemName: imageName)
                    .foregroundColor(selectedTab == imageName ? Color("Buttons") : Color.gray)
                    .font(.system(size: 24, weight: .bold))
            }
            .padding(13)
        }

    }
}


struct CustomTabView: View {
    
    @State var selectedTab: String = "chart.bar.xaxis"
    @State var edge: CGFloat = 0.0
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                
                SettingsView()
                    .tag("gearshape.fill")
                
                CoinsListView()
                    .tag("chart.bar.xaxis")
                
                PortfolioView(isAddedToPorfolio: false, isTouched: .constant(false), name: "", id: "", symbol: "", currentPrice: 0)
                    .tag("house.fill")
                
                SearchView()
                    .tag("magnifyingglass")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { imageName in
                    TabButtonview(selectedTab: $selectedTab, imageName: imageName)
                    if imageName != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .blur(radius: 0)
                    .opacity(0.95)
            )
            .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.5), radius: 5, x: -3, y: -3)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
        
    }
    
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
