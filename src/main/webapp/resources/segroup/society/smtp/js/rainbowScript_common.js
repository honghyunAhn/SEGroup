// [ onclick event ] --> background_video 클릭시 paly/pause
function togglePlay() {
  var video = document.querySelector(".background_video video");
  if (video.paused) {
    video.play();
  } else {
    video.pause();
  }
}

// [ onclick event ] --> modal show/hide
function openModal() {
  const modal = document.querySelector('.modal');
  function first(){
    modal.style.display = "block";
    document.body.classList.add("not-scroll");
  }
  function second(){
    modal.addEventListener("click", function(){
      if(document.body.classList.contains("not-scroll")){
        closeModal();
      }
    })
  }
  first();
  second();
}

function closeModal() {
  document.querySelector('.modal').style.display = "none";
  document.body.classList.remove("not-scroll");
}

window.addEventListener("load", function() {
  

});