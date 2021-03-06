//
//  GameBoard.swift
//  ChessAI
//
//  Created by Zack Meath on 11/4/15.
//  Copyright © 2015 Pillowfort Architects. All rights reserved.
//

import Foundation

class GameBoard {
    let DEFAULT_POSITION = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
    var pieceLocations: [Int: GamePiece?]
    
    let SQUARES = [
        "a8":   0, "b8":   1, "c8":   2, "d8":   3, "e8":   4, "f8":   5, "g8":   6, "h8":   7,
        "a7":  16, "b7":  17, "c7":  18, "d7":  19, "e7":  20, "f7":  21, "g7":  22, "h7":  23,
        "a6":  32, "b6":  33, "c6":  34, "d6":  35, "e6":  36, "f6":  37, "g6":  38, "h6":  39,
        "a5":  48, "b5":  49, "c5":  50, "d5":  51, "e5":  52, "f5":  53, "g5":  54, "h5":  55,
        "a4":  64, "b4":  65, "c4":  66, "d4":  67, "e4":  68, "f4":  69, "g4":  70, "h4":  71,
        "a3":  80, "b3":  81, "c3":  82, "d3":  83, "e3":  84, "f3":  85, "g3":  86, "h3":  87,
        "a2":  96, "b2":  97, "c2":  98, "d2":  99, "e2": 100, "f2": 101, "g2": 102, "h2": 103,
        "a1": 112, "b1": 113, "c1": 114, "d1": 115, "e1": 116, "f1": 117, "g1": 118, "h1": 119
    ]
    
    let ATTACKS = [
        20, 0, 0, 0, 0, 0, 0,24, 0, 0, 0, 0, 0, 0,20, 0,
        0,20, 0, 0, 0, 0, 0, 24,  0, 0, 0, 0, 0,20, 0, 0,
        0, 0,20, 0, 0, 0, 0, 24,  0, 0, 0, 0,20, 0, 0, 0,
        0, 0, 0,20, 0, 0, 0, 24,  0, 0, 0,20, 0, 0, 0, 0,
        0, 0, 0, 0,20, 0, 0, 24,  0, 0,20, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,20, 2, 24,  2,20, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 2,53, 56, 53, 2, 0, 0, 0, 0, 0, 0,
        24,24,24,24,24,24,56, 0, 56,24,24,24,24,24,24, 0,
        0, 0, 0, 0, 0, 2,53, 56, 53, 2, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,20, 2, 24,  2,20, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0,20, 0, 0, 24,  0, 0,20, 0, 0, 0, 0, 0,
        0, 0, 0,20, 0, 0, 0, 24,  0, 0, 0,20, 0, 0, 0, 0,
        0, 0,20, 0, 0, 0, 0, 24,  0, 0, 0, 0,20, 0, 0, 0,
        0,20, 0, 0, 0, 0, 0, 24,  0, 0, 0, 0, 0,20, 0, 0,
        20, 0, 0, 0, 0, 0, 0,24,  0, 0, 0, 0, 0, 0,20
    ];
    
    let RAYS = [
        17,  0,  0,  0,  0,  0,  0, 16,  0,  0,  0,  0,  0,  0, 15, 0,
        0,  17,  0,  0,  0,  0,  0, 16,  0,  0,  0,  0,  0, 15,  0, 0,
        0,   0, 17,  0,  0,  0,  0, 16,  0,  0,  0,  0, 15,  0,  0, 0,
        0,   0,  0, 17,  0,  0,  0, 16,  0,  0,  0, 15,  0,  0,  0, 0,
        0,   0,  0,  0, 17,  0,  0, 16,  0,  0, 15,  0,  0,  0,  0, 0,
        0,   0,  0,  0,  0, 17,  0, 16,  0, 15,  0,  0,  0,  0,  0, 0,
        0,   0,  0,  0,  0,  0, 17, 16, 15,  0,  0,  0,  0,  0,  0, 0,
        1,   1,  1,  1,  1,  1,  1,  0, -1, -1,  -1,-1, -1, -1, -1, 0,
        0,   0,  0,  0,  0,  0,-15,-16,-17,  0,  0,  0,  0,  0,  0, 0,
        0,   0,  0,  0,  0,-15,  0,-16,  0,-17,  0,  0,  0,  0,  0, 0,
        0,   0,  0,  0,-15,  0,  0,-16,  0,  0,-17,  0,  0,  0,  0, 0,
        0,   0,  0,-15,  0,  0,  0,-16,  0,  0,  0,-17,  0,  0,  0, 0,
        0,   0,-15,  0,  0,  0,  0,-16,  0,  0,  0,  0,-17,  0,  0, 0,
        0, -15,  0,  0,  0,  0,  0,-16,  0,  0,  0,  0,  0,-17,  0, 0,
        -15,  0, 0,  0,  0,  0, 0, -16,  0,  0,  0,  0,  0,  0, -17
    ];
    
    init(){
        pieceLocations = [:]
    }
    
    func copy() -> GameBoard {
        let copy = GameBoard()
        copy.pieceLocations = Dictionary<Int, GamePiece>()
        for (loc, piece) in pieceLocations {
            if piece != nil {
                copy.pieceLocations[loc] = GamePiece(piece: piece!)
            }
        }
        return copy
    }
    
    func get(location: Int) -> GamePiece? {
        // Returns GamePiece at the int location
        if let piece = pieceLocations[location] {
            return piece
        }
        return nil
    }
    
    func set(location: Int, piece: GamePiece?) {
        pieceLocations[location] = piece
    }
    
        // Castling rules:
        // Can't be in check
        // Can't pass through check
        // Can't end up in check
        // King and Rook have not previously moved
        // No pieces between them
    
}