stuff = require '../js/board_state'

describe 'BoardState', ->

  factory = new stuff.BoardStateFactory()

  describe 'combineRight', ->
    bs = new stuff.BoardState()

    it 'should ignore null rows', ->
      expect(bs.combineRight([null, null, null, null])).toEqual([null, null, null, null])

    it 'should do nothing when index is 0', ->
      expect(bs.combineRight([4], 0)).toEqual([4])

    it 'should move right when i is 1 if possible', ->
      expect(bs.combineRight([2, null], 1)).toEqual([null, 2])

    it 'should not move right when i is 1 if not possible', ->
      expect(bs.combineRight([2, 8], 1)).toEqual([2, 8])

    it 'should combine right if possible when i is 1', ->
      expect(bs.combineRight([2, 2], 1)).toEqual([null, 4])

    it 'should not move when i is 2 if not possible', ->
      expect(bs.combineRight([2, 4, 8], 2)).toEqual([2,4,8])

    it 'should move when i is 2 if possible', ->
      expect(bs.combineRight([2, 4, null], 2)).toEqual([null, 2,4])

    it 'should recurse movement when i is 2', ->
      expect(bs.combineRight([2, null, null], 2)).toEqual([null, null, 2])

    it 'should combine across gaps', ->
      expect(bs.combineRight([2, null, 2], 2)).toEqual([null, null, 4])


    xit 'combines rightmost first', ->
      expect(bs.combineRight([2, 4, 4, 4])).toEqual([null, 2,4,8])


    examples = [
        before: [ null, null, null, null ]
        after:  [ null, null, null, null ]
      ,
        #  before: [ null, null, 4,    null ]
        #after:  [ null, null, null, 4 ]
      #  before: [ null, null, 4,    4 ]
      #  after:  [ null, null, null, 8 ]
      #,
      #  before: [ null, 4,    null, 4 ]
      #  after:  [ null, null, null, 8 ]
      #,
      #  before: [ null, 4,    2,    4 ]
      #  after:  [ null, 4,    2,    4 ]
      #,
      #  before: [ 4,    null, null, 4 ]
      #  after:  [ null, null, null, 8 ]
      #,
      #  before: [ 4,    2,    null, 4 ]
      #  after:  [ null, 4,    2,    4 ]
    ]

    stateWithFirstRow = (row) ->
      bs = new stuff.BoardState
      bs.rows[0] = row
      bs

    testIt = (x) ->
      it "should combine #{x.before} to #{x.after}", ->
        state = stateWithFirstRow x.before
        new_state = state.move 'right'
        expect(new_state.rows[0]).toEqual x.after

    testIt x for x in examples



