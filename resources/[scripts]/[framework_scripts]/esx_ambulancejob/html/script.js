window.addEventListener('message', function(event) {
	var item = event.data;

	if (item.type == "updateTime") {
		$('#licznik').text(item.minutes + ":" + item.seconds);
	}
	if (item.type == "showInformations") {
		$('body').css('display', 'block');
	}
	if (item.type == "hideInformations") {
		$('body').css('display', 'none');
	}
});