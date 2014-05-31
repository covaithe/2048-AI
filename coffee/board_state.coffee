
class BoardState
  constructor: ->
    @rows = for row in [0..3]
      for col in [0..3]
        null
    @cols = @rows.map (r) -> r.slice(0)

  cell: (col, row) ->
    @rows[row-1][col-1]

  move: (direction) ->
    self = this
    if direction == 'right'
      rows = @rows.map this.combine
      return new BoardStateFactory().fromRows(rows)

    if direction == 'left'
      rows = @rows.map (row) ->
        self.combine(row.reverse()).reverse()
      return new BoardStateFactory().fromRows(rows)

    if direction == 'down'
      cols = @cols.map this.combine
      return new BoardStateFactory().fromCols(cols)

    if direction == 'up'
      cols = @cols.map (col) ->
        self.combine(col.reverse()).reverse()
      return new BoardStateFactory().fromCols(cols)



  moveRight = (row, index, steps) ->
    row[0..index] = row[0..index-steps]
    for k in [0..steps-1]
      row.unshift null
    

  combine: (row) ->
    for i in [3..1]
      # first try to move something non-null into this column
      if row[i] == null
        for j in [i-1..0]
          if row[j] != null
            moveRight(row, i, i-j)
            break

      # if this column is still null, then there were no non-null
      # columns to the left; we are done
      return row if row[i] == null

      # then try to combine similar things into this column
      # Find the next leftward non-null thing
      for j in [i-1..0]
        if row[j] != null
          # if it is the same, we combine.
          if row[j] == row[i]
            row[i] *= 2
            row[j] = null  #moving stuff rightward into j will happen in a later loop pass
            
          break
    row

  canGoForward = (set) ->
    [0..2].some (i) ->
      set[i] and (set[i+1] == null or set[i+1] == set[i])

  canGoBackward = (set) ->
    [3..1].some (i) ->
      set[i] and (set[i-1] == null or set[i-1] == set[i])
    

  canMoveRight: -> @rows.some canGoForward
  canMoveLeft: -> @rows.some canGoBackward
  canMoveUp: -> @cols.some canGoBackward
  canMoveDown: -> @cols.some canGoForward

  legalMoves: ->
    a = []
    a.push 'left' if this.canMoveLeft()
    a.push 'right' if this.canMoveRight()
    a.push 'up' if this.canMoveUp()
    a.push 'down' if this.canMoveDown()
    a

  emptySquares: ->
    a = []
    for r in [0..3]
      row = @rows[r]
      for c in [0..3]
        a.push new Square(c, r) if row[c] == null
    a

class Square
  constructor: (@col, @row) ->


class BoardStateFactory
  fromGrid: (grid) ->
    bs = new BoardState()
    v = (cell) ->
      return null unless cell
      cell.value

    bs.rows = for row in [0..3]
      for col in [0..3]
        v grid.cells[col][row]

    this.doCols bs
    bs

  fromRows: (rows) ->
    bs = new BoardState()
    bs.rows = rows.map (row) -> row.slice(0)
    this.doCols bs
    bs

  fromCols: (cols) ->
    bs = new BoardState()
    bs.cols = cols.map (col) -> col.slice(0)
    bs.rows = for row in [0..3]
      for col in [0..3]
        cols[col][row]
    bs
    
  doCols: (bs) ->
    bs.cols = for col in [0..3]
      for row in [0..3]
        bs.rows[row][col]
    

this.BoardState = BoardState
this.BoardStateFactory = BoardStateFactory
this.Square = Square
