stuff = require '../js/board_state'

describe 'BoardState', ->

  describe 'cell', ->
    bs = new stuff.BoardState
      cells: [
        [ null, null, null, null ],
        [ null, null, null, null ],
        [ { value: 2 }, null, null, null ],
        [ null, null, { value: 16 }, null ],
      ]

    it 'should report correct values', ->
      expect(bs.cell(3, 1)).toBe(2)
      expect(bs.cell(4, 3)).toBe(16)
      expect(bs.cell(3, 3)).toBe(null)

