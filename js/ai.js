function AI(grid) {
  this.grid = grid;
}

// performs a search and returns the best move
AI.prototype.getBest = function() {
  return { move: '0'};
}

AI.prototype.translate = function(move) {
 return {
    0: 'up',
    1: 'right',
    2: 'down',
    3: 'left'
  }[move];
}

