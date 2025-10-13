//
//  ContentView.swift
//  Flashcard
//
//  Created by Kabir Dhillon on 10/12/25.
//

import SwiftUI

/// Content View
struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var deckId: Int = 0
    @State private var cards: [Card] = Card.mockedCards
    @State private var cardsToPractice: [Card] = [] // <-- Store cards removed from cards array
    @State private var cardsMemorized: [Card] = []
    @State private var createCardViewPresented = false
    
    // MARK: - Views
    
    var body: some View {
        //        originalCardView
        cardDeck
    }
    
    var originalCardView: some View {
        ZStack {
            // MARK: Card background
            RoundedRectangle(cornerRadius: 25.0)
            //                .fill(Color.blue)
                .fill(Color.blue.gradient)
                .shadow(color: .black, radius: 4, x: -2, y: 2)
            // MARK: Card text
            //            Text("Located at the southern end of Puget Sound, what is the capitol of Washington?")
            //                .font(.title)
            //                .foregroundStyle(Color.white)
            //                .padding()
            
            VStack(spacing: 20) {
                //  MARK: Card type (question vs answer)
                Text("Question")
                    .bold()
                
                //  MARK: Separator
                Rectangle()
                    .frame(height: 1)
                
                //  MARK: Card text
                Text("Located at the southern end of Puget Sound, what is the capitol of Washington?")
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding()
        }
        .frame(width: 300, height: 500)
    }
    
    var cardDeck: some View {
        ZStack {
            // Reset buttons
            VStack { // <-- VStack to show buttons arranged vertically behind the cards
                Button("Reset") { // <-- Reset button with title and action
                    cards = cardsToPractice + cardsMemorized // <-- Reset the cards array with cardsToPractice and cardsMemorized
                    cardsToPractice = [] // <-- set both cardsToPractice and cardsMemorized to empty after reset
                    cardsMemorized = [] // <--
                    deckId += 1 // <-- Increment the deck id
                }
                .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)
                
                Button("More Practice") { // <-- More Practice button with title and action
                    cards = cardsToPractice // <-- Reset the cards array with cardsToPractice
                    cardsToPractice = [] // <-- Set cardsToPractice to empty after reset
                    deckId += 1 // <-- Increment the deck id
                }
                .disabled(cardsToPractice.isEmpty)
            }
            
            // Cards
            
            ForEach(0..<cards.count, id: \.self) { index in
                //                CardView(card: cards[index])
                //                    .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
                CardView(card: cards[index], onSwipedLeft: { // <-- Add swiped left property
                    //                    cards.remove(at: index) // <-- Remove the card from the cards array
                    let removedCard = cards.remove(at: index) // <-- Get the removed card
                    cardsToPractice.append(removedCard)
                }, onSwipedRight: { // <-- Add swiped right property
                    //                    cards.remove(at: index) // <-- Remove the card from the cards array
                    let removedCard = cards.remove(at: index) // <-- Get the removed card
                    cardsMemorized.append(removedCard) // <-- Add removed card to memorized cards array
                })
                .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
            }
        }
        .animation(.bouncy, value: cards)
        .id(deckId) // <-- Add an id modifier to the main card deck ZStack
        .sheet(isPresented: $createCardViewPresented, content: {
            //            Text("Create cards here...")
            CreateFlashcardView { card in
                cards.append(card)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- Force the ZStack frame to expand as much as possible (the whole screen in this case)
        //        .overlay(alignment: .topTrailing) {
        //            Button("Add Flashcard", systemImage: "plus") {
        //                createCardViewPresented.toggle()
        //            }
        //        }
        .overlay(alignment: .topTrailing) { // <-- Add an overlay modifier with top trailing alignment for its contents
            Button("Add Flashcard", systemImage: "plus") {  // <-- Add a button to add a flashcard
                createCardViewPresented.toggle() // <-- Toggle the createCardViewPresented value to trigger the sheet to show
            }
        }
        
    }
}

#Preview {
    ContentView()
}
