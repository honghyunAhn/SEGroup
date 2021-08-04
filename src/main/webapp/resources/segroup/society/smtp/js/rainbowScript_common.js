// [ onclick event ] --> background_video 클릭시 paly/pause
function togglePlay() {
  var video = document.querySelector(".background_video video");
  if (video.paused) {
    video.play();
  } else {
    video.pause();
  }
}