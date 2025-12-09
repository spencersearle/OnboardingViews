//
//  TutorialView.swift
//  OnboardingViews
//
//  Created by Spencer Searle on 12/8/25.
//

import SwiftUI

struct TutorialView: View {
    @State private var selection = 0
    @State private var hasCompletedOnboarding: Bool = false

    var body: some View {
        ZStack {
            Color.pink.opacity(0.5).edgesIgnoringSafeArea(.all)
            if !hasCompletedOnboarding {
                TabView(selection: $selection) {
                    PageView(title: "How plaite works", subtitle: "Explore all the features of plaite and start your healthy recipe journey 🥗", buttonTitle: "Start", selection: $selection, index: 0, total: 5, hasCompletedOnboarding: $hasCompletedOnboarding)
                        .tag(0)
                    PageView(title: "Discover", subtitle: "Swipe right 👉 to add to cookbook or swipe left 👈 to keep browsing", buttonTitle: "Next", selection: $selection, index: 1, total: 5, hasCompletedOnboarding: $hasCompletedOnboarding)
                        .tag(1)
                    PageView(title: "Preview", subtitle: "Click to preview recipes before making a final decision 🤔", buttonTitle: "Next", selection: $selection, index: 2, total: 5, hasCompletedOnboarding: $hasCompletedOnboarding)
                        .tag(2)
                    PageView(title: "Cookbook", subtitle: "Access your chosen recipes in the cookbook 📖", buttonTitle: "Next", selection: $selection, index: 3, total: 5, hasCompletedOnboarding: $hasCompletedOnboarding)
                        .tag(3)
                    PageView(title: "Get Started", subtitle: "Share, love, cook, and enjoy healthy recipes on plaite 🍽️", buttonTitle: "Finish", selection: $selection, index: 4, total: 5, hasCompletedOnboarding: $hasCompletedOnboarding)
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        Button {
            hasCompletedOnboarding.toggle()
        } label: {
            Text("Appear")
                .font(.headline)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.blue.opacity(0.5))
                .clipShape(Capsule())
        }
    }
}

private struct PageView: View {
    @Environment(\.dismiss) private var dismiss

    let title: String
    let subtitle: String
    let buttonTitle: String
    @Binding var selection: Int
    let index: Int
    let total: Int
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text(title)
                    .font(.custom("Montserrat-Bold", size: 30))
                    .foregroundStyle(Color.secondaryAccent)
                    .padding(.top, 20)

                Text(subtitle)
                    .font(.custom("Montserrat-Medium", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Button row
                Button(action: {
                    if index == total - 1 {
                        hasCompletedOnboarding = true
                    } else {
                        withAnimation { selection = min(selection + 1, total - 1) }
                    }
                }) {
                    HStack(spacing: 8) {
                        Text(buttonTitle)
                            .font(.custom("Montserrat-Semibold", size: 20))
                        Image(systemName: index == total - 1 ? "checkmark" : "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Capsule().fill(Color.secondaryAccent)
                            .opacity(0.9)
                    )
                }
                .accessibilityLabel(index == total - 1 ? "Finish tutorial" : "Next")

                // Custom page indicator inside the rectangle
                HStack(spacing: 8) {
                    ForEach(0..<total, id: \.self) { dot in
                        Circle()
                            .fill(dot == selection ? Color.white : Color.white.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(20)
            .background(Color.black.opacity(0.35))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(alignment: .topTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.black.opacity(0.45))
                        .clipShape(Circle())
                        .accessibilityLabel("Close tutorial")
                }
                .offset(x: 5, y: -5)
            }
            .padding(20)
        }
    }
}

#Preview {
    TutorialView()
}
