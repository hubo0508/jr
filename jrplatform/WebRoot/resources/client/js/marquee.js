// JavaScript Document

var Marquee = function(id){
    var container = document.getElementById(id),
    original = container.getElementsByTagName("dt")[0],
    clone = container.getElementsByTagName("dd")[0],
    speed = arguments[1] || 10;
    clone.innerHTML=original.innerHTML;
    var rolling = function(){
      if(container.scrollLeft == clone.offsetLeft){
        container.scrollLeft = 0;
      }else{
        container.scrollLeft++;
      }
    }
    var timer = setInterval(rolling,speed)//设置定时器
    container.onmouseover=function() {clearInterval(timer)}//鼠标移到marquee上时，清除定时器，停止滚动
    container.onmouseout=function() {timer=setInterval(rolling,speed)}//鼠标移开时重设定时器

}