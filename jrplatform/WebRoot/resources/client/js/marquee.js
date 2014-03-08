// JavaScript Document

var Marquee = function(id){
    var container = document.getElementById(id),
    original = container.getElementsByTagName("dt")[0],
    clone = container.getElementsByTagName("dd")[0],
    speed = arguments[1] || 30;
    clone.innerHTML=original.innerHTML;
    var rolling = function(){
      if(container.scrollLeft == clone.offsetLeft){
        container.scrollLeft = 0;
      }else{
        container.scrollLeft++;
      }
    }
    var timer = setInterval(rolling,speed)//���ö�ʱ��
    container.onmouseover=function() {clearInterval(timer)}//����Ƶ�marquee��ʱ�����ʱ��ֹͣ��
    container.onmouseout=function() {timer=setInterval(rolling,speed)}//����ƿ�ʱ���趨ʱ��

}