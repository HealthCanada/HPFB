var screenWidth = (window.innerWidth > 0) ? window.innerWidth : screen.width;
var tocNodes = [];
var tocIndex = 0;
var currentId = "";
var expandCollapse;
$(window).resize(function(){
	contentHeight = $(window).height() - $("#pageHeader").outerHeight() - 18;
	$(".leftColumn").css('height', contentHeight);
	$(".rightColumn").css('height', contentHeight);
	if($(".leftColumn").width() > 10 ){
		showTriangle(true);
	}
	setWatermarkBorder();
	twoColumnsDisplay();
	rightBoxWidth($(".leftColumn"));
	if(currentId != ""){
		location.href = currentId ;
	}
});
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
//	$("#pageHeaderTitle").height($("#approvedRevisionDateLabel").height() + $("#approvedRevisionDateValue").height() + 5);
	$("#tableOfContent").hide();
	expandCollapse = $("#tableOfContent").attr("expandCollapse");
	if(tocNodes.length < 1){
		$("#approvedRevisionDateLabel").html($("#approveDate").attr("headerdatelabel"));
		$("#headerBrandName").html($("#approveDate").attr("headerBrandName"));
		$("#approvedRevisionDateValue").html($("#approveDateValue").html() + "/" + $("#revisionDateValue").html());
//		$("#approvedRevisionDateLabel").parent().width($("#approvedRevisionDateLabel").width()+5);
//		$("#approvedRevisionDateValue").parent().width($("#approvedRevisionDateValue").width()+5);
//		$("#headerBrandName").parent().width($("#headerBrandName").width()+5);
		insertComa = false;
		headerTitle = "";
		$("h2 a[href^='#product']").each(function(){
			if(insertComa){
				headerTitle += ", "
			}
			insertComa = true;
			title = $(this).html();
			headerTitle += title.substring(0, title.lastIndexOf(' - '));
		});
		$("#pageHeaderTitle").html(headerTitle);
		$("#pageHeaderTitle").parent().width("100%");
		buildTreeNodes();
		drawToC($("#toc"), tocNodes);
		leftBoxWidth = $(".leftColumn").outerWidth();
		parentWidth = $(window).width();
		rightBox = $(".rightColumn");
	    rightBoxW = (parentWidth - leftBoxWidth - rightBox.outerWidth() + rightBox.width() - 1)/parentWidth*100 +"%";
	    rightBox.width(rightBoxW);
	    tocOnClick();
		$(".leftColumn").css('height', ($(window).height() - $("#pageHeader").outerHeight() - 18));
		$(".rightColumn").css('height', $(".leftColumn").outerHeight() + 15);
	}
	$(".leftColumn").resizable({
	        autoHide: true,
	        handles: 'e',
	        resize: function(e, ui) 
	        {
                rightBoxWidth(ui);
                showTriangle(true);
            },
	        stop: function(e, ui) 
	        {
	            var parent = null;
	            if(ui.element){
	            	parent = ui.element.parent();
	            }else {
	            	parent = ui.parent();
	            }
	            ui.element.css(
	            {
	                width: ui.element.width()/parent.width()*100+"%",
	            });
	        }
    });	
	if(screenWidth < 580){
		$(".leftColumn").width('100%');
		$(".rightColumn").width(screenWidth - 5);
	}
	collapseAll();
	$(".triangle-left").on('click', function(){
		$(".leftColumn").width(1);
		rightBoxWidth($(".leftColumn"));
		showTriangle(false);
	});
	$(".triangle-right").on('click', function(){
		if(screenWidth < 450 ){
			$(".leftColumn").width("100%");
		} else {
			$(".leftColumn").width("25%");
		}
		rightBoxWidth($(".leftColumn"));
		showTriangle(true);
	});
	showTriangle(true);
}
function rightBoxWidth(ui){
    var parent = null;
    var leftColumnSpace = null; 
    if(ui.element){
    	parent = ui.element.parent();
        leftColumnSpace = parent.width() - ui.element.outerWidth();
        redbox = ui.element.next();
    }else {
    	parent = ui.parent();
    	leftColumnSpace = parent.width() - ui.outerWidth();
        redbox = ui.next();
    }
    redboxwidth = (leftColumnSpace - (redbox.outerWidth() - redbox.width()))/parent.width()*100 +"%";
	redbox.width(redboxwidth);
}
function showTriangle(left){
	leftColumnTop = $(".leftColumn").position().top + $(".leftColumn").height() / 2;
	if(left){
		$(".triangle-left").css('top', leftColumnTop);
		$(".triangle-left").css('left', $(".leftColumn").outerWidth() - 12);
		$(".triangle-left").css('position','absolute');
		$( '.triangle-left' ).each(function () {
		    this.style.setProperty( 'display', 'block', 'important' );
		});
		$( '.triangle-right' ).each(function () {
		    this.style.setProperty( 'display', 'none', 'important' );
		});
	} else {
		$(".triangle-right").css('top', leftColumnTop);
		$(".triangle-right").css('left', $(".leftColumn").outerWidth() - 12);
		$(".triangle-right").css('position','absolute');
		$( '.triangle-left' ).each(function () {
		    this.style.setProperty( 'display', 'none', 'important' );
		});
		$( '.triangle-right' ).each(function () {
		    this.style.setProperty( 'display', 'block', 'important' );
		});
	}
}
function buildTreeNodes(){
	var node = null;
	var stack = [];
	var titlePage = "<h1><a href='#titlePage'>" + $("#titlePage").attr("toc") + "</a></h1>";
	tocNodes.push({'node':$(titlePage), 'children':[]});
	if($("div .Section[data-sectionCode='440']").attr("toc-include")
			&& $("div .Section[data-sectionCode='440']").attr("toc-include").toLowerCase() == "true"){
		var footNote = "<h1><a href='#440'>" + $(".Section[data-sectioncode='440'] h2").html() + "</a></h1>";
		tocNodes.push({'node':$(footNote), 'children':[]});
	}
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
function isMobile() {
	  var check = false;
	  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
	  return check;
	};function tocOnClick(){
		$(".leftColumn a").each(function(index, value){
//			console.log($(this).attr('href'));
			$(this).on('click', function(){ currentId = $(this).attr('href'); location.href = currentId;});
			
		});
	}