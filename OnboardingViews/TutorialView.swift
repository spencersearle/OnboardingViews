//
//  TutorialView.swift
//  Plaite
//
//  Created on 12/9/25.
//

import SwiftUI

struct TutorialView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPage = 0
    @State private var isCompleted = false

    let onTutorialCompleted: () -> Void

    // Tutorial pages content
    private let tutorialPages: [TutorialPage] = [
        TutorialPage(
            title: "Welcome to plaite",
            subtitle: "Your personal cooking companion",
            description: "Explore all the features of plaite and start your healthy recipe journey",
            iconName: "fork.knife",
            backgroundColor: .secondaryAccent.opacity(0.1)
        ),
        TutorialPage(
            title: "Smart Recipe Discovery",
            subtitle: "Find recipes that match your taste",
            description: "Swipe right 👉 to add to cookbook or swipe left 👈 to keep browsing",
            iconName: "magnifyingglass",
            backgroundColor: .secondaryAccent.opacity(0.1)
        ),
        TutorialPage(
            title: "Preview Recipes",
            subtitle: "See how a recipe looks before cooking",
            description: "Tap to preview recipes and get instructions before making a final decision",
            iconName: "checkmark.circle",
            backgroundColor: .secondaryAccent.opacity(0.1)
        ),
        TutorialPage(
            title: "Save & Cook",
            subtitle: "Build your personal cookbook",
            description: "Save your favorite recipes and get cooking instructions tailored to your needs",
            iconName: "heart",
            backgroundColor: .secondaryAccent.opacity(0.1)
        ),
        TutorialPage(
            title: "You're all set",
            subtitle: "Let's start cooking",
            description: "Discover healthy recipes and cook what you love",
            iconName: "sparkles",
            backgroundColor: .secondaryAccent.opacity(0.1)
        )
    ]

    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Button(action: completeTutorial) {
                        Text("Skip")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundStyle(.greenText)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 50)

                Spacer()

                // Tutorial Content
                TabView(selection: $currentPage) {
                    ForEach(0..<tutorialPages.count, id: \.self) { index in
                        TutorialPageView(page: tutorialPages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: .infinity)

                // Page Indicators
                HStack(spacing: 8) {
                    ForEach(0..<tutorialPages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.secondaryAccent : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 30)

                // Navigation Buttons
                HStack(spacing: 12) {
                    if currentPage > 0 {
                        Button(action: goToPreviousPage) {
                            Text("Back")
                                .font(.custom("Montserrat-Medium", size: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.buttonFill)
                                .foregroundColor(.greenText)
                                .cornerRadius(12)
                        }
                    }

                    Button(action: currentPage == tutorialPages.count - 1 ? completeTutorial : goToNextPage) {
                        Text(currentPage == tutorialPages.count - 1 ? "Get Started!" : "Next")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.secondaryAccent, .accent], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }

    private func goToNextPage() {
        if currentPage < tutorialPages.count - 1 {
            currentPage += 1
        }
    }

    private func goToPreviousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }

    private func completeTutorial() {
        isCompleted = true
        // Mark tutorial as completed and navigate to main app
        onTutorialCompleted()
        dismiss()
    }
}

// Tutorial Page Model
struct TutorialPage {
    let title: String
    let subtitle: String
    let description: String
    let iconName: String
    let backgroundColor: Color
}

// Individual Tutorial Page View
struct TutorialPageView: View {
    let page: TutorialPage

    var body: some View {
        VStack(spacing: 24) {
            // Icon
            ZStack {
                Circle()
                    .fill(page.backgroundColor)
                    .frame(width: 120, height: 120)

                Image(systemName: page.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.secondaryAccent)
            }

            // Content
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.custom("Montserrat-Bold", size: 28))
                    .foregroundStyle(.mainText)
                    .multilineTextAlignment(.center)

                Text(page.subtitle)
                    .font(.custom("Montserrat-Medium", size: 22))
                    .foregroundStyle(.greenText)
                    .multilineTextAlignment(.center)

                Text(page.description)
                    .font(.custom("Montserrat-Regular", size: 18))
                    .foregroundStyle(.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 20)
            }
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    TutorialView {
        print("Tutorial completed!")
    }
}
