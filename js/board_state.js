// Generated by CoffeeScript 1.7.1
var BoardState, BoardStateFactory;

BoardState = (function() {
  var moveRight;

  function BoardState() {
    var col, row;
    this.rows = (function() {
      var _i, _results;
      _results = [];
      for (row = _i = 0; _i <= 3; row = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (col = _j = 0; _j <= 3; col = ++_j) {
            _results1.push(null);
          }
          return _results1;
        })());
      }
      return _results;
    })();
    this.cols = this.rows.map(function(r) {
      return r.slice(0);
    });
  }

  BoardState.prototype.cell = function(col, row) {
    return this.rows[row - 1][col - 1];
  };

  BoardState.prototype.move = function(direction) {
    var cols, rows, self;
    self = this;
    if (direction === 'right') {
      rows = this.rows.map(this.combine);
      return new BoardStateFactory().fromRows(rows);
    }
    if (direction === 'left') {
      rows = this.rows.map(function(row) {
        return self.combine(row.reverse()).reverse();
      });
      return new BoardStateFactory().fromRows(rows);
    }
    if (direction === 'down') {
      cols = this.cols.map(this.combine);
      return new BoardStateFactory().fromCols(cols);
    }
    if (direction === 'up') {
      cols = this.cols.map(function(col) {
        return self.combine(col.reverse()).reverse();
      });
      return new BoardStateFactory().fromCols(cols);
    }
  };

  moveRight = function(row, index, steps) {
    var k, _i, _ref, _ref1, _results;
    [].splice.apply(row, [0, index - 0 + 1].concat(_ref = row.slice(0, +(index - steps) + 1 || 9e9))), _ref;
    _results = [];
    for (k = _i = 0, _ref1 = steps - 1; 0 <= _ref1 ? _i <= _ref1 : _i >= _ref1; k = 0 <= _ref1 ? ++_i : --_i) {
      _results.push(row.unshift(null));
    }
    return _results;
  };

  BoardState.prototype.combine = function(row) {
    var i, j, _i, _j, _k, _ref, _ref1;
    for (i = _i = 3; _i >= 1; i = --_i) {
      if (row[i] === null) {
        for (j = _j = _ref = i - 1; _ref <= 0 ? _j <= 0 : _j >= 0; j = _ref <= 0 ? ++_j : --_j) {
          if (row[j] !== null) {
            moveRight(row, i, i - j);
            break;
          }
        }
      }
      if (row[i] === null) {
        return row;
      }
      for (j = _k = _ref1 = i - 1; _ref1 <= 0 ? _k <= 0 : _k >= 0; j = _ref1 <= 0 ? ++_k : --_k) {
        if (row[j] !== null) {
          if (row[j] === row[i]) {
            row[i] *= 2;
            row[j] = null;
          }
          break;
        }
      }
    }
    return row;
  };

  return BoardState;

})();

BoardStateFactory = (function() {
  function BoardStateFactory() {}

  BoardStateFactory.prototype.fromGrid = function(grid) {
    var bs, col, row, v;
    bs = new BoardState();
    v = function(cell) {
      if (!cell) {
        return null;
      }
      return cell.value;
    };
    bs.rows = (function() {
      var _i, _results;
      _results = [];
      for (row = _i = 0; _i <= 3; row = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (col = _j = 0; _j <= 3; col = ++_j) {
            _results1.push(v(grid.cells[col][row]));
          }
          return _results1;
        })());
      }
      return _results;
    })();
    this.doCols(bs);
    return bs;
  };

  BoardStateFactory.prototype.fromRows = function(rows) {
    var bs;
    bs = new BoardState();
    bs.rows = rows.map(function(row) {
      return row.slice(0);
    });
    this.doCols(bs);
    return bs;
  };

  BoardStateFactory.prototype.fromCols = function(cols) {
    var bs, col, row;
    bs = new BoardState();
    bs.cols = cols.map(function(col) {
      return col.slice(0);
    });
    bs.rows = (function() {
      var _i, _results;
      _results = [];
      for (row = _i = 0; _i <= 3; row = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (col = _j = 0; _j <= 3; col = ++_j) {
            _results1.push(cols[col][row]);
          }
          return _results1;
        })());
      }
      return _results;
    })();
    return bs;
  };

  BoardStateFactory.prototype.doCols = function(bs) {
    var col, row;
    return bs.cols = (function() {
      var _i, _results;
      _results = [];
      for (col = _i = 0; _i <= 3; col = ++_i) {
        _results.push((function() {
          var _j, _results1;
          _results1 = [];
          for (row = _j = 0; _j <= 3; row = ++_j) {
            _results1.push(bs.rows[row][col]);
          }
          return _results1;
        })());
      }
      return _results;
    })();
  };

  return BoardStateFactory;

})();

this.BoardState = BoardState;

this.BoardStateFactory = BoardStateFactory;
