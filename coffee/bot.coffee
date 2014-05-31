
class Bot
  constructor: (@grid) ->
    console.log @grid
    @boardState = new BoardStateFactory().fromGrid(@grid)

  evaluate: (boardState) ->
    boardState.emptySquares().length

  expectimax: (boardState, depth, ourTurn) ->
    self = this
    if depth == 0
      return this.evaluate boardState

    if ourTurn == false and boardState.emptySquares().length == 0
      return 0  # we lose

    if ourTurn
      childScores = boardState.legalMoves().map (move) =>
        this.expectimax boardState.move(move), depth-1, false
      return Math.max childScores...
    else
      emptySquares = boardState.emptySquares()
      x = emptySquares.map (square) ->
        [ [2, 0.9], [4, 0.1] ].map (a) ->
          [v,p] = a
          p * self.expectimax boardState.populateSquare(square, v), depth, true
      x = _.flatten x
      sum = _.reduce x, (a,b) -> a+b
      sum / x.length

  getBestMove: =>
    # pick the best legal move.  A move's score is calculated by the expectimax value 
    # of having moved the board that way.  
    moveScores = @boardState.legalMoves().map (move) =>
      { move: move, score: this.expectimax(@boardState.move(move), 1, false) }
    console.log moveScores
    sortedScores = _.sortBy moveScores, (ms) -> ms.score
    this.translateMove sortedScores[0].move

  translateMove: (move) ->
    moves =
      up: '0'
      right: '1'
      down: '2'
      left: '3'
    moves[move]

