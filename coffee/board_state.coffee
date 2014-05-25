this.BoardState = class
  constructor: (@grid) ->

  cell: (row,col) ->
    c = @grid.cells[row-1][col-1]
    return null unless c
    c.value
