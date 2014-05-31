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

  describe 'legalMoves', ->
    bs = null

    beforeEach ->
      bs = new stuff.BoardState()

    describe 'canMoveRight', ->
      it 'should be false when all nulls', ->
        bs.rows[0] = [ null, null, null, null ]
        expect(bs.canMoveRight()).toBe false

      it 'should be false when full with no combines possible', ->
        bs.rows[0] = [ 2, 4, 2, 4 ]
        expect(bs.canMoveRight()).toBe false

      it 'should be false when the nulls are packed left', ->
        bs.rows[0] = [ null, null, 8, 16 ]
        expect(bs.canMoveRight()).toBe false

      it 'should be true when there is a null to the right of a non-null', ->
        bs.rows[0] = [ null, 4, null, 16 ]
        expect(bs.canMoveRight()).toBe true

      it 'should be true when there is a combine possible', ->
        bs.rows[0] = [ null, 4, 4, 16 ]
        expect(bs.canMoveRight()).toBe true

      it 'should check all rows for one that can move right', ->
        bs.rows[3] = [ null, 4, 4, 16 ]
        expect(bs.canMoveRight()).toBe true

    describe 'canMoveLeft', ->
      it 'should be false when all nulls', ->
        bs.rows[0] = [ null, null, null, null ]
        expect(bs.canMoveLeft()).toBe false

      it 'should be false when full with no combines possible', ->
        bs.rows[0] = [ 2, 4, 2, 4 ]
        expect(bs.canMoveLeft()).toBe false

      it 'should be false when the nulls are packed right', ->
        bs.rows[0] = [ 8, 16, null, null ]
        expect(bs.canMoveLeft()).toBe false

      it 'should be true when there is a null to the left of a non-null', ->
        bs.rows[0] = [ null, 4, null, 16 ]
        expect(bs.canMoveLeft()).toBe true

      it 'should be true when there is a combine possible', ->
        bs.rows[0] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveLeft()).toBe true

      it 'should check all rows for one that can move right', ->
        bs.rows[3] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveLeft()).toBe true

    describe 'canMoveUp', ->
      it 'should be false when all nulls', ->
        bs.cols[0] = [ null, null, null, null ]
        expect(bs.canMoveUp()).toBe false

      it 'should be false when full with no combines possible', ->
        bs.cols[0] = [ 2, 4, 2, 4 ]
        expect(bs.canMoveUp()).toBe false

      it 'should be false when the nulls are packed down', ->
        bs.cols[0] = [ 8, 16, null, null ]
        expect(bs.canMoveUp()).toBe false

      it 'should be true when there is a null above a non-null', ->
        bs.cols[0] = [ 2, 4, null, 16 ]
        expect(bs.canMoveUp()).toBe true

      it 'should be true when there is a combine possible', ->
        bs.cols[0] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveUp()).toBe true

      it 'should check all cols for one that can move', ->
        bs.cols[3] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveUp()).toBe true

    describe 'canMoveDown', ->
      it 'should be false when all nulls', ->
        bs.cols[0] = [ null, null, null, null ]
        expect(bs.canMoveDown()).toBe false

      it 'should be false when full with no combines possible', ->
        bs.cols[0] = [ 2, 4, 2, 4 ]
        expect(bs.canMoveDown()).toBe false

      it 'should be false when the nulls are packed up', ->
        bs.cols[0] = [ null, null, 8, 16 ]
        expect(bs.canMoveDown()).toBe false

      it 'should be true when there is a null below a non-null', ->
        bs.cols[0] = [ 2, 4, null, 16 ]
        expect(bs.canMoveDown()).toBe true

      it 'should be true when there is a combine possible', ->
        bs.cols[0] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveDown()).toBe true

      it 'should check all cols for one that can move', ->
        bs.cols[3] = [ 2, 4, 4, 16 ]
        expect(bs.canMoveDown()).toBe true

    describe 'legalMoves', ->
      it 'should include left when canMoveLeft', ->
        spyOn(bs, 'canMoveLeft').andReturn true
        expect(bs.legalMoves()).toContain('left')
      it 'should not include left when canMoveLeft is false', ->
        spyOn(bs, 'canMoveLeft').andReturn false
        expect(bs.legalMoves()).toNotContain('left')
      it 'should include right when canMoveRight', ->
        spyOn(bs, 'canMoveRight').andReturn true
        expect(bs.legalMoves()).toContain('right')
      it 'should not include Right when canMoveRight is false', ->
        spyOn(bs, 'canMoveRight').andReturn false
        expect(bs.legalMoves()).toNotContain('right')
      it 'should include up when canMoveUp', ->
        spyOn(bs, 'canMoveUp').andReturn true
        expect(bs.legalMoves()).toContain('up')
      it 'should not include up when canMoveUp is false', ->
        spyOn(bs, 'canMoveUp').andReturn false
        expect(bs.legalMoves()).toNotContain('up')
      it 'should include down when canMoveDown', ->
        spyOn(bs, 'canMoveDown').andReturn true
        expect(bs.legalMoves()).toContain('down')
      it 'should not include down when canMoveDown is false', ->
        spyOn(bs, 'canMoveDown').andReturn false
        expect(bs.legalMoves()).toNotContain('down')

  describe 'emptySquares', ->
    it "should be the square coords of the squares that are null", ->
      bs = factory.fromRows [
        [ null, 2,    4,  null]
        [ 2,    4,    8,  16]
        [ null, 4   , 16, 16]
        [ 4,    null, 32, 16]
      ]
      es = bs.emptySquares()
      expect(es.length).toBe 4
      expect(es).toContain(new stuff.Square(0,0))
      expect(es).toContain(new stuff.Square(0,2))
      expect(es).toContain(new stuff.Square(1,3))
      expect(es).toContain(new stuff.Square(3,0))



