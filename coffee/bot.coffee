
class Bot
  constructor: (@grid) ->
    console.log @grid

  # this is pretty much pseudocode right now...
  expectimax: (boardState, depth, ourTurn) ->
    self = this
    if depth == 0
      return this.evaluate boardState

    if ourTurn
      childScores = boardState.legalMoves().map (move) ->
        this.expectimax boardState.move(move), depth-1, false
      return Math.max childScores...
    else
      emptySquares = boardState.emptySquares()
      return emptySquares.map (square) ->
        [ [2, 0.9], [4, 0.1] ].map((a) ->
          v,p = a...
          p * self.expectimax boardState.populateSquare(square, v), depth-1, true
        ).flatten.average

  getBestMove: ->
    '1'


