//
//  MovieDetailsView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            content
                .padding(.horizontal)
                .padding(.bottom)
        }
        .scrollIndicators(.hidden)
        .background(Color(.systemBackground))
        .navigationTitle(viewModel.details?.title ?? "Details")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
        .task { await viewModel.load() }
        .overlay(alignment: SwiftUI.Alignment.bottom) {
            if let error = viewModel.errorMessage {
                toastView(message: error) {}
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if let details = viewModel.details {
            VStack(alignment: .leading, spacing: 16) {
                header(details)
                ratingAndMeta(details)
                overview(details)
            }
        } else if viewModel.viewState == .loading {
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            EmptyView()
        }
    }

//    private func header(_ details: MovieDetails) -> some View {
//        VStack(alignment: .center, spacing: 12) {
//            AsyncImageWrapper(url: details.posterURL?.absoluteString ?? "")
//                .scaledToFill()
//                .frame(maxWidth: .infinity, minHeight: 320, maxHeight: 400)
//                .clipped()
//                .cornerRadius(12)
//                .shadow(radius: 6)
//            Text(details.title)
//                .font(.title)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//        }
//        .frame(maxWidth: .infinity)
//    }
    private func header(_ details: MovieDetails) -> some View {
        VStack(alignment: .center, spacing: 12) {
            AsyncImageWrapper(url: details.posterURL?.absoluteString ?? "")
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .shadow(radius: 6)
            
//            Text(details.title)
//                .font(.title)
//                .fontWeight(.bold)
//                .lineLimit(2)
//                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private func ratingAndMeta(_ details: MovieDetails) -> some View {
        HStack(spacing: 16) {
            Label(details.voteAverage, systemImage: "star.fill")
                .foregroundColor(.yellow)
            Text(details.releaseDate)
                .foregroundColor(.secondary)
            Spacer()
            Text(details.originalLanguage.uppercased())
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(6)
        }
    }

    private func overview(_ details: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)
            Text(details.overview)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}


