//
//  GameMove.swift
//  ChessAI
//
//  Created by Zack Meath on 11/4/15.
//  Copyright © 2015 Pillowfort Architects. All rights reserved.
//

import Foundation


func == (lhs: GameMove, rhs: GameMove) -> Bool {
    return lhs.fromIndex == rhs.fromIndex && lhs.toIndex == rhs.toIndex
}

class GameMove: Equatable {
    
    enum Flag: Int {
        case NORMAL
        case PAWN_PUSH
        case PAWN_PROMOTION
        case PAWN_PROMOTION_CAPTURE
        case EN_PASSANT
        case CAPTURE
        case KINGSIDE_CASTLE
        case QUEENSIDE_CASTLE
    }
    
    var side: GamePiece.Side
    
    var castling: Dictionary<GamePiece.Side, Int>?
    var ROOKS: Dictionary<GamePiece.Side, Int>?
    var kings: Dictionary<GamePiece.Side, Int>?
    var epSquare: Int?
    var halfMoves: Int?
    var moveNumber: Int?
    
    var fromIndex: Int
    var toIndex: Int
    var flag: Flag
    var promotionPiece: GamePiece.Kind?
    var capturedPiece: GamePiece?
    
    init (side: GamePiece.Side, fromIndex: Int, toIndex: Int, flag: Flag, promotionPiece: GamePiece.Kind?, capturedPiece: GamePiece?){
        self.side = side
        self.fromIndex = fromIndex
        self.toIndex = toIndex
        self.flag = flag
        self.promotionPiece = promotionPiece
        self.capturedPiece = capturedPiece
    }
}