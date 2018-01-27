var tocNodes = [];
var tocIndex = 0;
var expandCollapse;
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
function twoColumnsDisplay(){
	$("#pageHeader").html(
			"<p class=\"pageTitle\">" 
			+ $("#pageTitle").html() + "</p><p>"
			+ "<span class=\"approveDate\">" 
			+ $("#approveDate").html() + "</span>"
			+ "<span class=\"revisionDate\">" + $("#revisionDate").html() + "</span></p>"
	);
	$("#toc").css('height', ($(window).height() - $("#pageHeader").height() - 10) + 'px');
	
	$("#spl").css('height', ($(window).height() - $("#pageHeader").height() - 10) + 'px');
	$("#tableOfContent").hide();
	expandCollapse = $("#tableOfContent").attr("expandCollapse");
	buildTreeNodes();
	drawToC($("#toc"), tocNodes);
	add2Nodes();
	$(".leftColumn h1").css("font-size","18px");
	$(".leftColumn h2").css("font-size","16px");
	$(".leftColumn h3").css("font-size","14px");
	$(".leftColumn h4").css("font-size","14px");
	$(".leftColumn h5").css("font-size","14px");
	collapseAll();
}
function buildTreeNodes(){
	var node = null;
	var stack = [];
	var titlePage = "<h1 style='text-transform:uppercase;'><a href='#titlePage'>" + $("#titlePage").attr("toc") + "</a></h1>";
	tocNodes.push({'node':$(titlePage), 'children':[]});
	var footNote = "<h1 style='text-transform:uppercase;'><a href='#440'>" + $(".Section[data-sectioncode='440'] h2").html() + "</a></h1>";
	tocNodes.push({'node':$(footNote), 'children':[]});
	$("#tableOfContent a").each(function(){
//		console.log($(this).parent().text());
			var tagName = $(this).parent()[0].tagName;
			node = {'node':$(this).parent()[0], 'children':[]};
			switch(tagName){
			case "H1":
				addNode(0, node, stack);
				tocNodes.push(node);
				break;
			case "H2":
				addNode(1, node, stack);
				break;
			case "H3":
				addNode(2, node, stack);
				break;
			case "H4":
				addNode(3, node, stack);
				break;
			case "H5":
				addNode(4, node, stack);
				break;
			case "H6":
				addNode(5, node, stack);
				break;
				
			}
//			console.log(tagName);
	});
	
}
function addNode(level, node, stack){
	while( stack.length > level){
		stack.pop();
	}
	if(level > 0){
		stack[level -1]['children'].push(node);
	}
	stack.push(node);
}
function drawToC(temp, items){
	if(items.length > 0){
		items.forEach(function(item){
			temp1 = $("<div id=toc_" + tocIndex++ +" style='display:inline;white-space:nowrap;clear:both;'></div>");
			if(item['children'].length > 0){
				node = $("<span style='float:left;'>&nbsp;+&nbsp;</span>");
				$(node).on('click', function(){toggleNodes(this);});
				$(temp1).append($(node));
			} else {
				$(temp1).append($("<div style='float:left;'>&nbsp;&nbsp;&nbsp;</div>"));
			}
			if(item['node'][0]){
				$(temp1).append($(item['node'][0].outerHTML));
			} else {
				$(temp1).append($(item['node'].outerHTML));
			}
			$(temp).append(temp1);
			if(item['children'].length > 0){
				temp1 = $("<div id=toc_" + tocIndex++ +"></div>");
				$(temp).append(temp1);
				drawToC(temp1, item['children']);
			}
		});
	}
}
function add2Nodes(){
	temp = $("#toc").append(
			$("<div style='float:left;'>&nbsp;&nbsp;&nbsp;</div><h1 style='text-transform: uppercase; font-size: 18px;white-space:nowrap;'><a href='#prodDesc'>" + $("#prodDesc tbody tr th").html() + "</a></h1>")
			).append(
				$("<div style='float:left;'>&nbsp;&nbsp;&nbsp;</div><h1 style='text-transform: uppercase; font-size: 18px;white-space:nowrap;'><a href='#organizations'>" + $("#organizations tbody tr th").html() + "</a></h1>")
			);
}
function toggleNodes(e){
	nodeID = "#toc_" + (parseInt($(e).parent()[0].id.substring(4)) + 1 );
	node = $(nodeID);
	$(node).toggle();
	if($(e).html() == "&nbsp;+&nbsp;"){
		$(e).html("&nbsp;-&nbsp;");
	} else {
		$(e).html("&nbsp;+&nbsp;");
	}
}
function collapseAll(){
	$(".leftColumn div span").each(function(index, node){
		displayChildren(node, false);
	});
}
function displayChildren(node, show){
	if($(node).parent().attr('id')){
		nodeID = "#toc_" + (parseInt($(node).parent().attr('id').substring(4)) + 1 );
		if(show){
			$(nodeID).show();
			$(node).html("&nbsp;-&nbsp;");
		} else {
			$(nodeID).hide();
			$(node).html("&nbsp;+&nbsp;");
		}
	} else {
		if(show){
			$(node).html("&nbsp;-&nbsp;" + expandCollapse);
		} else {
			$(node).html("&nbsp;+&nbsp;" + expandCollapse);
		}
	}
}
function expandAll(){
	$(".leftColumn div span").each(function(index, node){
		displayChildren(node, true);
	});
}
function expandCollapseAll(me){
	if($(me).html().substring(6,7) == "+"){
		expandAll();
	} else {
		collapseAll();
	}
}