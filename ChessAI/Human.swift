//
//  Human.swift
//  ChessAI
//
//  Created by Liam Cain on 12/6/15.
//  Copyright © 2015 Pillowfort Architects. All rights reserved.
//

import SpriteKit

class Human: Player {
    
    var activePiece: Piece?
    var legalMoves: [GameMove]
    
    override init(side: Side, board: Board, game: Game) {
        legalMoves = []
        super.init(side: side, board: board, game: game)
    }
    
    override func handleMove(move: GameMove?) {
        legalMoves = game.generateMoves(GameOptions())
        super.handleMove(move)
    }
    
    override func makeMove(move: GameMove) {
        board.makeMove(activePiece!, move: move)
        game.makeMove(move)
        super.makeMove(move)
    }
    
    override func mouseUp() {
        if activePiece == nil { return }
        
        // Deselect all spaces
        for row in board.spaces {
            for space in row {
                space.invalidMove()
            }
        }
        
        let nextSpace = board.closestSpace(activePiece!)
        let currentSpace = activePiece!.boardSpace
        
        // If we haven't moved the piece
        if nextSpace == currentSpace {
            board.snapback(activePiece!)
            return
        }
        
        let move = game.buildMove(currentSpace, toPosition:nextSpace, promotionPiece: nil)
        if legalMoves.contains(move) {
            makeMove(move)
        } else {
            board.snapback(activePiece!)
        }
        activePiece?.zPosition = ZPOSITION_INACTIVE_PIECE
        activePiece = nil
    }
    
    override func mouseDown(piece: Piece) {
        activePiece = piece
        activePiece?.zPosition = ZPOSITION_ACTIVE_PIECE
        
        for move in legalMoves {
            if move.fromIndex == activePiece?.boardIndex() {
                board.get(move.toIndex).validMove()
            }
        }
    }
    
    override func mouseDragged(position: CGPoint) {
        activePiece?.position = position
    }
    
}