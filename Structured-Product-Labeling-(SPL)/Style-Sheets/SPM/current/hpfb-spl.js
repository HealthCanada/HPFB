function setWatermarkBorder(){
	var watermarks = $(".Watermark");
	if(watermarks){
		//watermarks.forEach(initialWatermark);
		initialWatermark(watermarks, 1);
	}
}
function initialWatermark(item, index){
	var table = $(item).find('table');
	if(table){
		var watermarkText = $(item).find(".WatermarkTextStyle");
		var characters = (watermarkText.text()).length;
		var width = Math.sqrt($(table).height()*$(table).height()+$(table).width()*$(table).width())*0.9;
		var angle = Math.atan2($(table).height(),$(table).width())*180/Math.PI;
		var v_offset = $(table).height()/2 + $(watermarkText).height()/2; //$(table).height() / 2 + Math.cos(angle)*width/2;
		var h_offset = - (width - $(table).width())/2; //Math.sin(angle)*width/2 + $(table).width()/2;
		$(watermarkText).css("width", width);
		$(watermarkText).css({top : v_offset, left: h_offset});
		$(watermarkText).css("font-size", width / characters * 2 + "px");
		$(watermarkText).show();
		$(watermarkText).css({'transform' :  'rotate(-' + angle + 'deg)'});
	}
}