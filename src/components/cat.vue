
<template>
  <div class="cat">
    <div class="ear ear--left"></div>
    <div class="ear ear--right"></div>
    <div class="face">
      <div class="eye eye--left" id="leftEye">
        <div class="eye-pupil"></div>
      </div>
      <div class="eye eye--right" id="rightEye">
        <div class="eye-pupil"></div>
      </div>
      <div class="muzzle">
        <!--                <div class="whisker top-left"></div>-->
      </div>
      <!--            <div id="curves" class="width">-->
      <!--                <div class="mouth right"></div>-->
      <!--                <div class="mouth left"></div>-->
      <!--            </div>-->
    </div>
  </div>
</template>

<style scoped>
.cat {
  position: relative;
  height: 130px;
  width: 146.9px;
  margin: 80px auto 0 auto; }

.ear {
  position: absolute;
  top: -30%;
  height: 60%;
  width: 25%;
  background: #fff; }
.ear::before, .ear::after {
  content: '';
  position: absolute;
  bottom: 24%;
  height: 10%;
  width: 5%;
  border-radius: 50%;
  background: black; }
.ear::after {
  transform-origin: 50% 100%; }

.ear--left {
  left: -4%;
  border-radius: 70% 30% 0% 0% / 100% 100% 0% 0%;
  transform: rotate(-15deg); }
.ear--left::before, .ear--left::after {
  right: 10%; }
.ear--left::after {
  transform: rotate(-45deg); }

.ear--right {
  right: -4%;
  border-radius: 30% 70% 0% 0% / 100% 100% 0% 0%;
  transform: rotate(15deg); }
.ear--right::before, .ear--right::after {
  left: 10%; }
.ear--right::after {
  transform: rotate(45deg); }

.face {
  position: absolute;
  height: 100%;
  width: 100%;
  background: black;
  border-radius: 50%; }

.eye {
  position: absolute;
  top: 35%;
  height: 30%;
  width: 31%;
  background: #fff;
  border-radius: 50% 50% 50% 50% / 60% 60% 40% 40%; }
.eye::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  height: 0;
  width: 100%;
  border-radius: 0 0 50% 50% / 0 0 40% 40%;
  background: black;
  animation: blink 4s infinite ease-in; }

@keyframes blink {
  0% {
    height: 0; }
  90% {
    height: 0; }
  92.5% {
    height: 100%; }
  95% {
    height: 0; }
  97.5% {
    height: 100%; }
  100% {
    height: 0; } }
.eye::before {
  content: '';
  position: absolute;
  top: 60%;
  height: 10%;
  width: 15%;
  background: #fff;
  border-radius: 50%; }

.eye--left {
  left: 0; }
.eye--left::before {
  right: -5%; }

.eye--right {
  right: 0; }
.eye--right::before {
  left: -5%; }

.eye-pupil {
  position: absolute;
  top: 25%;
  height: 50%;
  width: 20%;
  background: black;
  border-radius: 50%;
  transition: transform 0.13s; }

@keyframes look-around {
  0% {
    transform: translate(0); }
  5% {
    transform: translate(50%, -25%); }
  10% {
    transform: translate(50%, -25%); }
  15% {
    transform: translate(-100%, -25%); }
  20% {
    transform: translate(-100%, -25%); }
  25% {
    transform: translate(0, 0); }
  100% {
    transform: translate(0, 0); } }
.eye--left .eye-pupil {
  right: 30%; }
.eye--right .eye-pupil {
  left: 30%; }
.eye-pupil::after {
  content: '';
  position: absolute;
  top: 30%;
  right: -5%;
  height: 20%;
  width: 35%;
  border-radius: 50%;
  background: #fff; }

.muzzle {
  position: absolute;
  top: 70%;
  left: 50%;
  height: 6%;
  width: 10%;
  background: #fff;
  transform: translateX(-50%);
  border-radius: 50% 50% 50% 50% / 30% 30% 70% 70%; }

#curves div {
  width: 100px;
  height: 100px;
  border: 1px solid #999; }

#curves.width div {
  border-color: transparent transparent transparent #999; }

#curves.color div {
  border-width: 0 0 0 1px; }

#curves.all div {
  border-width: 2px;
  border-color: white white white white; }

.mouth {
  position: absolute;
  -moz-border-radius: 30px 0 0 70px;
  border-radius: 30px 0 0 70px;
  z-index: 1; }

.mouth.right {
  top: 60px;
  left: 94px;
  transform: rotate(300deg); }

.mouth.left {
  top: 60px;
  left: -4px;
  transform: rotate(300deg) scaleX(-1); }
</style>

<script>
import $ from 'jquery'
window.$ = $

export default {
  name: 'cat',
  mounted() {
    let rightEye = $("#rightEye")
    let leftEye = $("#leftEye")
    let rightPupil = $("#rightEye .eye-pupil")
    let leftPupil = $("#leftEye .eye-pupil")

    let rightEyePos = rightPupil.offset().left + 3
    let leftEyePos = leftPupil.offset().left + 3

    let rightDeg = 0;
    let leftDeg = 0;

    let xpos = 0;
    let ypos = 0;

    let position = ''

    let secondsInactivity = 0;
    let lastXPos = 0;
    let lastYPos = 0;

    const checkInactivity = setInterval(() => {

      if((lastYPos == ypos) && (lastXPos == xpos)) {
        secondsInactivity += 1
      } else {
        secondsInactivity = 0
      }

      if(secondsInactivity > 3) {
        pointEyes(0,0,0);
      }

      lastXPos = xpos;
      lastYPos = ypos;

      //if(
      //    (xpos > leftEye.offset().left && xpos < (leftEye.offset().left + leftEye.height()))
      //    ||
      //    (xpos > rightEye.offset().left && xpos < (rightEye.offset().left + rightEye.height()))
      //) {
      //    console.log("SIII")
      //    leftEye.after().css({
      //        'animation': 'none',
      //        'height': '100%'
      //    })
      //    rightEye.after().css({
      //        'animation': 'none',
      //        'height': '100%'
      //    })
      //} else {
      //}
    }, 1000);


    const mouseMove = (event) => {
      xpos = event.clientX
      ypos = event.clientY
      position = ''


      if (xpos > rightEyePos) {
        let restaxPosRight = window.innerWidth - rightEyePos

        rightDeg = ((xpos - rightEyePos) / restaxPosRight) * 200
        leftDeg = 100
        position = 'right'
      } else if(xpos < leftEyePos) {
        let restaxPosLeft = window.innerWidth - rightEyePos

        leftDeg = ((xpos - leftEyePos) / restaxPosLeft) * 200
        rightDeg = -100
        position = 'left'
      } else if(xpos > leftEyePos && xpos < rightEyePos) {
        let restaxPosRight = (window.innerWidth - (window.innerWidth - rightEyePos) - leftEyePos) / 2
        let  restaxPosLeft = (rightEyePos - leftEyePos) / 2

        rightDeg = (xpos - (leftEyePos + restaxPosRight)) * 2 - 100
        leftDeg = (xpos - (leftEyePos)) / restaxPosLeft * 100

        if(leftDeg >= 100) {
          leftDeg = 100
          position = 'center right'
        }

        if(rightDeg <= -100) {
          rightDeg = -100
          position = 'center left'
        }
      }

      if(event.type === "click") {
        console.log(
            'Left: ' + leftDeg + '%\n' +
            'Right: ' + rightDeg + '%\n' +
            'Position: ' + position
        )
      }


      let yhalf = (window.innerHeight / 2)
      let yDeg = (ypos > yhalf) ? ((ypos - yhalf) / yhalf) * 40 : (ypos / yhalf) * 40 - 40;

      pointEyes(rightDeg, leftDeg, yDeg)
    }

    const resize = () => {
      rightPupil = $("#rightEye .eye-pupil")
      leftPupil = $("#leftEye .eye-pupil")

      rightEyePos = rightPupil.offset().left + 3
      leftEyePos = leftPupil.offset().left + 3
    }

    const pointEyes = (xr, xl, y) => {
      rightPupil.css({
        'transform' : 'translate('+xr+'%, '+y+'%)'
      });
      leftPupil.css({
        'transform' : 'translate('+xl+'%, '+y+'%)'
      });
    }

    window.onresize = resize
    window.onmousemove = mouseMove
    window.ontouchmove = mouseMove
  }
}


</script>