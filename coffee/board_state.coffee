
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

  combine: (row) ->
    for i in [3..1]
      # first try to move something non-null into this column
      if row[i] == null
        for j in [i-1..0]
          if row[j] != null
            this._moveRight(row, i, i-j)

      # if this column is still null, then there were no non-null
      # columns to the left; we are done
      return row if row[i] == null

      # then try to combine similar things into this column
      # Find the next leftward non-null thing
      for j in [i-1..0]
        if row[j] != null
          # if it is different, nothing to do.  
          # if it is the same, we combine.
          if row[j] == row[i]
            row[i] *= 2
            row[j] = null  #moving stuff rightward into j will happen in a later loop pass
    row

  _moveRight: (row, index, steps) ->
    row[0..index] = row[0..index-steps]
    for k in [0..steps]
      row.unshift null
    



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
