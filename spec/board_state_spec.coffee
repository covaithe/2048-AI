stuff = require '../js/board_state'

describe 'BoardState', ->

  factory = new stuff.BoardStateFactory()

  describe 'combine', ->
    bs = new stuff.BoardState()

    examples = [
        before: [ null, null, null, null ]
        after:  [ null, null, null, null ]
      ,
        before: [ null, null, 4,    null ]
        after:  [ null, null, null, 4 ]
      ,
        before: [ null, null, 4,    4 ]
        after:  [ null, null, null, 8 ]
      ,
        before: [ null, 4,    null, 4 ]
        after:  [ null, null, null, 8 ]
      ,
        before: [ null, 4,    2,    4 ]
        after:  [ null, 4,    2,    4 ]
      ,
        before: [ 4,    null, null, 4 ]
        after:  [ null, null, null, 8 ]
      ,
        before: [ 4,    null, 4,    null ]
        after:  [ null, null, null, 8 ]
      ,
        before: [ 4,    2,    null, 4 ]
        after:  [ null, 4,    2,    4 ]
      ,
        before: [ 4,    2,    2,    4 ]
        after:  [ null, 4,    4,    4 ]
      ,
        before: [ 4,    4,    1024, 1024 ]
        after:  [ null, null,    8, 2048 ]
      ,
        before: [ 4,    2,    2,    2 ]
        after:  [ null, 4,    2,    4 ]
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

  describe 'directions', ->
    bs = factory.fromRows [
      [ null, null, null, null]
      [ null, null, null, null]
      [ null, 4   , null, null]
      [ null, null, null, null]
    ]

    it 'should move right', ->
      new_state = bs.move 'right'
      expect(new_state.rows[2]).toEqual [null, null, null, 4]

    it 'should move left', ->
      new_state = bs.move 'left'
      expect(new_state.rows[2]).toEqual [4, null, null, null]

    it 'should move down', ->
      new_state = bs.move 'down'
      expect(new_state.cols[1]).toEqual [null, null, null, 4]

    it 'should move up', ->
      new_state = bs.move 'up'
      expect(new_state.cols[1]).toEqual [4, null, null, null]

