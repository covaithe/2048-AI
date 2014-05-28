stuff = require '../js/board_state'

describe 'BoardState', ->

  describe 'fromGrid', ->
    bs = new stuff.BoardStateFactory().fromGrid
      cells: [
        [ null, null, null, null ],
        [ null, null, null, null ],
        [ { value: 2 }, null, null, null ],
        [ null, null, { value: 16 }, null ],
      ]

    it 'should reference cells correctly', ->
      expect(bs.cell(3, 1)).toBe(2)
      expect(bs.cell(4, 3)).toBe(16)
      expect(bs.cell(3, 3)).toBe(null)

    it "should know its rows", ->
      expect(bs.rows[2]).toEqual [ null, null, null, 16 ]

    it "should know its cols", ->
      expect(bs.cols[2]).toEqual [ 2, null, null, null ]

  describe 'fromRows', ->
    bs = new stuff.BoardStateFactory().fromRows [
      [ 2, 4, 4, 8 ]
      [ 4, 4, 4, 8 ]
      [ 8, 4, 4, 8 ]
      [16, 4, 4, 8 ]
    ]

    it "should know its cells", ->
      expect(bs.cell(1,1)).toBe(2)
      expect(bs.cell(1,4)).toBe(16)

    it "should know its rows", ->
      expect(bs.rows[1]).toEqual [ 4, 4, 4, 8 ]

    it "should know its cols", ->
      expect(bs.cols[0]).toEqual [ 2, 4, 8, 16 ]

  describe 'fromCols', ->
    bs = new stuff.BoardStateFactory().fromCols [
      [ 2, 4, 4, 8 ]
      [ 4, 4, 4, 8 ]
      [ 8, 4, 4, 8 ]
      [16, 4, 4, 8 ]
    ]

    it "should know its cells", ->
      expect(bs.cell(1,1)).toBe(2)
      expect(bs.cell(4,1)).toBe(16)

    it "should know its rows", ->
      expect(bs.rows[0]).toEqual [ 2, 4, 8, 16]

    it "should know its cols", ->
      expect(bs.cols[0]).toEqual [ 2, 4, 4, 8 ]

