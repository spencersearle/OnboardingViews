//
//  DietSelectionView.swift
//  OnboardingViews
//
//  Created by Spencer Searle on 10/6/25.
//

import SwiftUI

struct DietOption: Identifiable {
    let id: String
    let label: String
    let emoji: String
}

struct DietSelectionView: View {
    @EnvironmentObject var preferences: UserPreferences  // Inject shared model
    @Environment(\.dismiss) var dismissScreen
    
    let dietOptions = [
        DietOption(id: "balanced", label: "Balanced", emoji: "🥗"),
        DietOption(id: "vegetarian", label: "Vegetarian", emoji: "🥦"),
        DietOption(id: "vegan", label: "Vegan", emoji: "🌱"),
        DietOption(id: "keto", label: "Keto", emoji: "🥑"),
        DietOption(id: "paleo", label: "Paleo", emoji: "🍖"),
        DietOption(id: "mediterranean", label: "Mediterranean", emoji: "🫒"),
        DietOption(id: "low-carb", label: "Low Carb", emoji: "🥩"),
        DietOption(id: "gluten-free", label: "Gluten-Free", emoji: "🌾")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 12) {
                // leaf label
                Image(systemName: "leaf")
                    .font(.system(size: 30))
                    .foregroundColor(.accent)
                    .padding(12)
                    .background(Color.secondaryAccent)
                    .clipShape(Circle())
                    .padding(.top, 20)

                // text
                Text("What's your diet style?")
                    .font(.custom("Montserrat-Bold", size: 24))
                    .foregroundStyle(.mainText)
                
                Text("Select all that apply - we'll customize recipes for you")
                    .font(.custom("Montserrat-Medium", size: 16))
                    .foregroundStyle(Color.greenText)
                    .multilineTextAlignment(.center)
                
                // Grid
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(dietOptions) { diet in
                        DietCard(
                            diet: diet,
                            isSelected: preferences.selectedDiets.contains(diet.id),  // Use shared state
                            action: { toggleSelection(diet.id) }
                        )
                    }
                }
                .padding()
                                    
                // Buttons
                HStack(spacing: 10) {
                    Button {
                        dismissScreen()
                    } label: {
                        Text("Back")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.buttonFill)
                            .foregroundColor(.greenText)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink {
                        AllergySelectionView()
                    } label: {
                        Text("Continue")
                            .font(.custom("Montserrat-Semibold", size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.secondaryAccent, .accent], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(preferences.selectedDiets.isEmpty)  // Use shared state
                    .opacity(preferences.selectedDiets.isEmpty ? 0.5 : 1)
                }
                .padding()
            }
        }
        .background(Color(.primaryBackground))
        .onAppear {
            print("DietSelectionView loaded: Current selectedDiets = \(preferences.selectedDiets)")  // Debug
        }
    }
    
    private func toggleSelection(_ id: String) {
        if preferences.selectedDiets.contains(id) {
            preferences.selectedDiets.remove(id)
        } else {
            preferences.selectedDiets.insert(id)
        }
        print("Diet toggled: \(id), Now selected: \(preferences.selectedDiets)")  // Debug
    }
    
    private struct DietCard: View {
        let diet: DietOption
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack(alignment: .topTrailing) {
                    VStack(spacing: 8) {
                        Text(diet.emoji)
                            .font(.system(size: 32))
                        
                        Text(diet.label)
                            .font(.custom("Montserrat-Medium", size: 14))
                            .foregroundColor(.mainText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSelected ? Color.accent.opacity(0.1) : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.accent : Color.gray.opacity(0.2), lineWidth: 2)
                    )
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.accent)
                            .clipShape(Circle())
                            .padding(6)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    DietSelectionView()
        .environmentObject(UserPreferences())  // For preview
}
