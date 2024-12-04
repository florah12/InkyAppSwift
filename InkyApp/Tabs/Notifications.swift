//
//  NotificationsPage.swift
//  InkyApp

import SwiftUI

struct Notifications: View {
    // View Properties
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                DummyMessagesView()
            }
            .padding(.horizontal, 15)
            .safeAreaInset(edge: .top, spacing: 0) {
                ExpandableNavigationBar()
            }
        }
    }

    // Expandable Navigation Bar
    @ViewBuilder
    func ExpandableNavigationBar(_ title: String = "Updates") -> some View {
        VStack(spacing: 10) {
            // Title
            Text(title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
        }
        .padding(.top, 25)
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        .background(Color(UIColor.systemBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }

    // Dummy Messages View
    @ViewBuilder
    func DummyMessagesView() -> some View {
        ForEach(0..<20, id: \.self) { index in
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 55, height: 55)
                    .accessibilityLabel("User profile picture placeholder")
                VStack(alignment: .leading, spacing: 6) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 140, height: 8)
                        .accessibilityHidden(true)
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 8)
                        .accessibilityHidden(true)
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 80, height: 8)
                        .accessibilityHidden(true)
                }
            }
            .padding(.vertical, 10)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    Notifications()
}
