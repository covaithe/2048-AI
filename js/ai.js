function AI(grid) {
  this.grid = grid;
}

// TODO:  columns and rows collections

AI.prototype.canGoUp = function() {
  // needs either an empty space at the top of the column, 
  //console.log(this.grid);
  for(var x=0; x<4; x++) {
    var spaceFound = false;
    for(var y=0; y<4; y++) {
      var tile = this.grid.cells[x][y];
      if (tile) {
        if(spaceFound) {
          // here we found a column that has a space 
          // above a non-space; we can go up. 
          return true;
        }
      } else {
        spaceFound = true;
      }
    }
  }
  
  // or a pair of the same number in the same col with nothing between
  for(var x=0; x<4; x++) {
    var currentNum = null;
    for(var y=0; y<4; y++) {
      var tile = this.grid.cells[x][y];
      if (tile) {
        if (tile.value == currentNum) {
          // this tile's value is the same as that of its nearest upward
          // neighbor; we can go up. 
          return true;
        } else {
          currentNum = tile.value;
        }
      }
    }
  }

  return false;
}

AI.prototype.canGoLeft = function() {
  // needs either a space to the left of a non-space,
  for(var y=0; y<4; y++) {
    var spaceFound = false;
    for(var x=0; x<4; x++) {
      var tile = this.grid.cells[x][y];
      if (tile) {
        if(spaceFound) {
          return true;
        }
      } else {
        spaceFound = true;
      }
    }
  }
  
  // or a pair of the same number in the same row with nothing between
  for(var y=0; y<4; y++) {
    var currentNum = null;
    for(var x=0; x<4; x++) {
      var tile = this.grid.cells[x][y];
      if (tile) {
        if (tile.value == currentNum) {
          return true;
        } else {
          currentNum = tile.value;
        }
      }
    }
  }

  return false;
}

// performs a search and returns the best move
AI.prototype.getBest = function() {
  var bot = new Bot(this.grid);
  return { move: bot.getBestMove() };

  if (this.canGoUp()) {
    return { move: '0'};
  } 
  if (this.canGoLeft()) {
    return { move: '3'};
  } 
  return { move: '1'};
}

AI.prototype.translate = function(move) {
 return {
    0: 'up',
    1: 'right',
    2: 'down',
    3: 'left'
  }[move];
}

