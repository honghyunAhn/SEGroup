/**
 * 
 */
function minMaxTime(frmId,endId,setting){
	
	$("#"+frmId).timepicker();
	$("#"+endId).timepicker();
	$("#"+frmId).timepicker("setDefaults", setting);
	$("#"+endId).timepicker("setDefaults", setting);

	$("#"+frmId).on('changeTime', function() {		
		$("#"+endId).timepicker("option", "minTime",$(this).val());
	});
	
	$("#"+endId).on('changeTime', function() {
		$("#"+frmId).timepicker("option", "maxTime",$(this).val());
	});
}