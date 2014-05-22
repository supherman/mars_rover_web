var TO_RADIANS = Math.PI/180;

__bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

var Rover = function(grid, id, x, y, facing){
  this.id      = id;
  this.grid    = grid;
  this.canvas  = this.grid.canvas;
  this.context = this.grid.context;
  this.image   = document.getElementById('robot');
  this.setPosition({ x: x, y: y, facing: facing })
  this.eventHandler = __bind(this.eventHandler, this);
};

Rover.prototype.setPosition = function(params) {
  var angleMap = {
    north: 0,
    west: 270,
    east: 90,
    south: 180
  };

  this.x       = params['x'];
  this.y       = params['y'];
  this.facing  = params['facing'];
  this.angle   = angleMap[this.facing];
  this.updateDOM(params);
};

Rover.prototype.updateDOM = function(params){
  document.getElementById('rover-x').textContent = params['x']
  document.getElementById('rover-y').textContent = params['y']
  document.getElementById('rover-facing').textContent = params['facing']
};

Rover.prototype.draw = function () {
  this.grid.reset();
  this.context.save();
  this.context.translate((this.x*50) + 25, (this.y*50) + 25);
  this.context.rotate(this.angle * TO_RADIANS);
  this.context.drawImage(this.image, -(this.image.width/2), -(this.image.height/2));
  this.context.restore();
};

Rover.prototype.move = function(movement) {
  that = this;
  $.ajax({ type: 'POST', url: ('/rovers/' + this.id + '/' + movement) }).done(function(response){
    that.setPosition(response);
    that.draw();
  });
};

Rover.prototype.eventHandler = function(event) {
  event.preventDefault();
  var code = (event.which) ? event.which : event.keyCode;
  switch (code) {
    case 37: this.move('turn_left');  break;
    case 38: this.move('move_forwards');  break;
    case 39: this.move('turn_right');   break;
    case 40: this.move('move_backwards');  break;
  }
};

Rover.prototype.listen = function() {
  if (window.document.addEventListener) {
    window.document.addEventListener("keydown", this.eventHandler, false);
  } else {
    window.document.attachEvent("onkeydown", this.eventHandler);
  }
};

