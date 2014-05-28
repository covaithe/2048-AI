
class BoardState
  constructor: ->
    @rows = for row in [0..3]
      for col in [0..3]
        null
    @cols = @rows.map (r) -> r.slice(0)

  cell: (col, row) ->
    @rows[row-1][col-1]

  move: (direction) ->
    rows = @rows.map this.combineRight
    new BoardStateFactory().fromRows(rows)

  combineRight: (row, i=3) ->
    return row if i == 0
    return row if row[0..i].every (x) -> x == null

    if row[i] == null
      row[0..i] = row[0..i-1]
      row.unshift null
      return this.combineRight row, i

    else if row[i] == row[i-1]
      row[i] *= 2
      row[i-1] = null
    this.combineRight row, i-1



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
