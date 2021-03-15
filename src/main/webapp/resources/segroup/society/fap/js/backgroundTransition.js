
window.addEventListener("DOMContentLoaded", function(e) {

	var backgroundTransition = document.getElementById("backgroundTransition");
	var fadeComplete = function(e) {
		backgroundTransition.appendChild(arr[0]);
	};
	var arr = backgroundTransition.getElementsByTagName("a");
	for (var i = 0; i < arr.length; i++) {
		arr[i].addEventListener("animationend", fadeComplete, false);
	}

}, false);

