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
  
  // 나의강의실 tab
  const tabList = document.querySelectorAll('.tab_headerWrap .tab_header a');
  const contents = document.querySelectorAll('.tab_bodyWrap .tab_body')
  let activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)

  for (var i = 0; i < tabList.length; i++) {
      tabList[i].addEventListener('click', function (e) {
          e.preventDefault();
          for (var j = 0; j < tabList.length; j++) {
              tabList[j].parentNode.classList.remove('active');
              contents[j].style.display = 'none';
          }
          this.parentNode.classList.add('active');
          activeCont = this.getAttribute('tab');
          document.querySelector(activeCont).style.display = 'block';
      });
  }  

});