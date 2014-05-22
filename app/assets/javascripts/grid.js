var Grid = function(length, height) {
  this.length  = length;
  this.height  = height;
  this.canvas  = document.getElementById('grid');
  this.context = this.canvas.getContext('2d');
};

Grid.prototype.draw = function() {
  var color = true;
  this.context.font = "25px serif";
  this.context.font = "20px serif";

  for (var i=0;i < this.length;i++)
  {
    color = !color;
    for (var j=0;j < this.height;j++)
    {
      if (color)
      {
        this.context.fillStyle = "rgb(255, 255, 255)";
        color = false;
      }
      else
      {
        this.context.fillStyle = "rgb(100, 100, 100)";
        color = true;
      }
      this.context.fillRect(i*50, j*50, 50, 50);
    }
  }
};

Grid.prototype.clear = function(){
  var currentWidth = this.canvas.width;
  this.canvas.width = 0;
  this.canvas.width = currentWidth;
};

Grid.prototype.reset = function() {
  this.clear();
  this.draw();
};
