//
//  AddAssetView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 25-03-22.
//

import SwiftUI

struct AddAssetView: View {
    
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel = FavouriteAssetViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var amount: String = ""
    @State var quantity: Double = 1
    @State var purcharsePriceString: String = ""
    @State var purcharsePrice: Double
    @Binding var isAddedToPorfolio: Bool
    @State var assetName: String
    @State var assetId: String
    @State var currentPrice: Double
    @State var assetSymbol: String
    @State var assetImgURL: String
    @State var assetChangePercentage: Double
    @State var isQuantityChanging: Bool = false
    @State var isPurchasePriceChanging: Bool = false
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topTrailing) {
                VStack {
                    
                    HStack {
                        Text("Add \(self.assetName) to portfolio")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .matchedGeometryEffect(id: "name", in: animation)
                    }
                    
                    VStack(spacing: 15) {
                        //Quantity
                        VStack(alignment: .leading) {
                            Text("Amaunt of \(self.assetSymbol.uppercased()) you want to add")
                                .foregroundColor(.white)
                                .font(.system(size: 14, design: .rounded))
                                .padding(.bottom, -5)
                            
                            HStack {
                                ZStack(alignment: .leading) {
                                    
                                    TextField("1", value: $quantity, format: .number)
                                        .onChange(of: quantity, perform: { newValue in
                                            self.isQuantityChanging = true
                                        })
                                        .foregroundColor(self.isQuantityChanging ? .white : .gray)
                                        .keyboardType(.decimalPad)
                                        .font(.system(size: 12, design: .rounded))
                                        .padding(8)
                                        .padding(.leading, 2)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                }
                                
                                Text("\(self.assetSymbol.uppercased())")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, design: .rounded))
                                    .padding(.trailing, 10)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .blur(radius: 0)
                                    .opacity(0.7)
                            )
                        }
                        
                        //Price per coin
                        VStack(alignment: .leading)  {
                            Text("Purchase price")
                                .foregroundColor(.white)
                                .font(.system(size: 14, design: .rounded))
                                .padding(.bottom, -5)
                            
                            HStack {
                                ZStack(alignment: .leading) {
                                    
                                    TextField("\(purcharsePrice.formatted())", value: $purcharsePrice, format: .number)
                                        .onChange(of: purcharsePrice, perform: { newValue in
                                            self.isPurchasePriceChanging = true
                                        })
                                        .foregroundColor(self.isPurchasePriceChanging ? .white : .gray)
                                        .keyboardType(.decimalPad)
                                        .font(.system(size: 12, design: .rounded))
                                        .padding(8)
                                        .padding(.leading, 2)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                    
                                    if purcharsePrice == 0 {
                                        Text("\(currentPrice.formatted())")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, design: .rounded))
                                            .padding(.leading, 10)
                                    }
                                }
                                
                                Text("USD")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, design: .rounded))
                                    .padding(.trailing, 10)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .blur(radius: 0)
                                    .opacity(0.7)
                            )
                            
                        }

                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, 20)
                    
                    Button {
                        
                        withAnimation(.spring(response: 0.1, dampingFraction: 1)) {
                            isAddedToPorfolio = false
                        }
                        
                        self.favouriteAssetViewModel.updateAsset(id: self.assetId, name: self.assetName, symbol: self.assetSymbol, imgURL: self.assetImgURL, purchasePrice: self.purcharsePrice, purchaseQuantity: self.quantity, currentPrice: self.currentPrice, priceChangePercentage24h: self.assetChangePercentage)
                    } label: {
                        Text("Add")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding()
                            .frame(maxWidth: 250)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("Buttons").opacity(0.85), Color("Buttons").opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .padding(.horizontal, 30)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    }
                    .padding(.top)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .padding(10)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                        presentationMode.wrappedValue.dismiss()
                        self.isAddedToPorfolio = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .padding(6)
                        .foregroundColor(Color("Buttons"))
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.8)
                        )
                }
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .padding(20)
            }
            .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .background(
            Image("wallpaper2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.4)
        )
        .preferredColorScheme(.dark)
        .onAppear {
            self.purcharsePrice = self.currentPrice
        }
    }
}

struct AddAssetView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var currentPrice = 47000.2
    @State static var name = "Bitcoin"
    @State static var id = "bitcoin"
    @State static var symbol = "btc"
    
    
    static var previews: some View {
        AddAssetView(purcharsePrice: currentPrice, isAddedToPorfolio: .constant(true),assetName: name, assetId: id, currentPrice: currentPrice, assetSymbol: symbol,assetImgURL: "", assetChangePercentage: currentPrice, animation: animation)
            .preferredColorScheme(.light)
    }
}
