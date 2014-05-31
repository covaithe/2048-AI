function AI(grid) {
  this.grid = grid;
}

// performs a search and returns the best move
AI.prototype.getBest = function() {
  var bot = new Bot(this.grid);
  return { move: bot.getBestMove() };
}

AI.prototype.translate = function(move) {
 return {
    0: 'up',
    1: 'right',
    2: 'down',
    3: 'left'
  }[move];
}

