<template>
  <div class="bubble bubble-bottom-left typewrite" data-period="2000" data-type='[
            "🐈 ¡Miauloper! 🐈",
        ]'>
    <span class="wrap"></span>
  </div>
</template>

<style scoped>
  .bubble {
    position: relative;
    font-family: sans-serif;
    font-size: 18px;
    line-height: 24px;
    background: #fff;
    border-radius: 40px;
    padding: 24px;
    text-align: center;
    color: #000;
    right: 0;
    min-width: 300px;
    display: block;
    z-index: -100;
  }

  .bubble-bottom-left:before {
    content: "";
    width: 0px;
    height: 0px;
    position: absolute;
    border-left: 24px solid #fff;
    border-right: 12px solid transparent;
    border-top: 12px solid #fff;
    border-bottom: 20px solid transparent;
    left: 50%;
    bottom: -24px;
  }

  .envolpe {
    position: relative;
    min-width: 500px;
  }

  .line-1 {
    position: relative;
    top: 50%;
    width: 24em;
    margin: 0 auto;
    border-right: 2px solid rgba(255, 255, 255, 0.75);
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    transform: translateY(-50%);
  }

  /* Animation */
  .anim-typewriter {
    animation: typewriter 4s steps(44) 1s 1 normal both, blinkTextCursor 500ms steps(44) infinite normal;
  }

  @keyframes typewriter {
    from {
      width: 0;
    }
    to {
      width: 24em;
    }
  }
  @keyframes blinkTextCursor {
    from {
      border-right-color: rgba(255, 255, 255, 0.75);
    }
    to {
      border-right-color: transparent;
    }
  }
</style>

<script>
var TxtType = function(el, toRotate, period) {
  this.toRotate = toRotate;
  this.el = el;
  this.loopNum = 0;
  this.period = parseInt(period, 10) || 2000;
  this.txt = '';
  this.array = [];
  this.tick();
  this.isDeleting = false;
  this.videoFaded = false;
  this.imageFaded = false;
};

let times = 100000000000
let timeouts = []
TxtType.prototype.tick = function() {
  var i = this.loopNum % this.toRotate.length;
  var image = ''
  var video = ''
  if(typeof this.toRotate[i] === 'object') {
    var fullTxt = [...this.toRotate[i].text];
    if(typeof this.toRotate[i].video !== 'undefined')
      video = this.toRotate[i].video;
    if(typeof this.toRotate[i].image !== 'undefined')
      image = this.toRotate[i].image;
  } else {
    image = ''
    var fullTxt = [...this.toRotate[i]];
  }

  if(image != '' && !this.imageFaded){
    $("#image").css("background-image", "url('"+image+"')")
    $("#image").fadeIn()
    this.imageFaded = true
  }
  if(video != '' && !this.videoFaded) {
    $("#video>video").attr("src", video)
    $("#video").fadeIn()
    $("#video>video").trigger("play")
    this.videoFaded = true;
  }


  if (this.isDeleting) {
    this.array = fullTxt.slice(0, this.array.length - 1)
  } else {
    this.array = fullTxt.slice(0, this.array.length + 1)
  }

  this.el.innerHTML = '<span class="wrap">'+this.array.join('')+'</span>';

  var that = this;
  var delta = 170 - Math.random() * 100;

  if (this.isDeleting) { delta /= 3; }

  if (!this.isDeleting && fullTxt.length === this.array.length) {
    delta = this.period;
    this.isDeleting = true;
  } else if (this.isDeleting && this.array.length == 0) {
    $("#image").fadeOut()
    $("#video").fadeOut()
    $("#video>video").trigger("pause")
    image = ''
    video = ''
    this.videoFaded = false;
    this.imageFaded = false;
    this.isDeleting = false;
    this.loopNum++;
    delta = 500;
  }

  timeouts.push(
      setTimeout(function() {
        that.tick();
        if(times == 0){
          for (var i = 0; i < timeouts.length; i++) {
            clearTimeout(timeouts[i]);
          }
        }
        times -= 1
      }, delta)
  )
};

const startTyping = () => {
  var elements = document.getElementsByClassName('typewrite');
  for (var i=0; i<elements.length; i++) {
    var toRotate = elements[i].getAttribute('data-type');
    var period = elements[i].getAttribute('data-period');
    if (toRotate) {
      new TxtType(elements[i], JSON.parse(toRotate), period);
    }
  }
};

const changeTexts = (texts) => {
  times = 0
  textos = []
  for (var i = 0; i < texts.length; i++) {
    var text = ''
    if(typeof texts[i] == "object")
      text = texts[i].text
    else
      text = texts[i]

    if(i == texts.length-1)
      times += ([...text].length) - 2
    else
      times += ([...text].length * 2)
  }

  for (var i = 0; i < timeouts.length; i++) {
    clearTimeout(timeouts[i]);
  }
  $(".typewrite").attr("data-type", JSON.stringify(texts))
  startTyping()
}


window.onload = startTyping
</script>