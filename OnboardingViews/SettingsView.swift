//
//  SettingsView.swift
//  OnboardingViews
//
//  Created by Spencer Searle on 11/18/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            settingsScreen
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            Color.pink.opacity(0.5).edgesIgnoringSafeArea(.top)
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Cookbook")
                }
            Color.greenText.edgesIgnoringSafeArea(.top)
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Discover")
                }
            Color.red.edgesIgnoringSafeArea(.top)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shopping List")
                }
        }
    }
    
    private var settingsScreen: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.custom("Montserrat-Bold", size: 30))
                    .padding(.bottom, 5)
                
                threeItemList
                
                rateUsButton
                
                shareButton
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(20)
        }
        .background(Color.primaryBackground)
    }

    private struct SettingsButton: View {
        let title: String
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                HStack {
                    Text(title)
                        .foregroundStyle(Color.mainText)
                        .font(.custom("Montserrat-Medium", size: 16))
                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private var threeItemList: some View {
        VStack(spacing: 5) {
            SettingsButton(title: "Preferences") {
                print("Preferences")
            }

            Divider()
                .padding(.horizontal)

            SettingsButton(title: "Subscription") {
                print("Subscription")
            }

            Divider()
                .padding(.horizontal)

            SettingsButton(title: "Account") {
                print("Account")
            }
        }
        .background(Color.white)
        .cornerRadius(15)
        .padding(.bottom)
        .shadow(color: Color.gray.opacity(0.15), radius: 5)
    }
    
    private var rateUsButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "star")
                    .foregroundStyle(Color.white)
                    .font(Font.system(size: 16, weight: .semibold))
                Text("Rate Us")
                    .font(.custom("Montserrat-Semibold", size: 16))
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.accent, .accent.opacity(0.75)], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom)
    }
    
    private var shareButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(Color.mainText)
                    .font(Font.system(size: 16, weight: .semibold))
                Text("Share the App")
                    .font(.custom("Montserrat-Semibold", size: 16))
                    .foregroundStyle(Color.mainText)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.primaryBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 3)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsView()
}
