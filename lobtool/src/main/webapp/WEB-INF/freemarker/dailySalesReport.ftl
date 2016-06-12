<#import "spring.ftl" as spring/>
<html>
<head>
	<link rel="stylesheet" href="../../resources/javascript/dojo/resources/dojo.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/dgrid.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/skins/claro.css" >
    <style type="text/css">
    #grid {
        width:480px;
        height:300px;
        display:block;
        float:left;
        position: relative;
        left: 5px;
        top: 20px;
    }
    
    #chartNode {
        width:480px;
        height:400px;
        display:block;
        float:right;
        position: relative;
        right: 5px;
        top: 20px;
    }
    </style>
</head>
<body class="claro">
	<script src="../../resources/javascript/dojoConfig.js"></script>
	<script src="../../resources/javascript/dojo/dojo.js"></script>
	
	<script>
		var data = [
			<#list dailySalesEntries as entry>
			{
				billDate: '${entry.billDate}',
				numOfBill: '${entry.numOfBill}',
				totalAmount: '${entry.totalAmount?string("##0.0#")}',
				numOfCust: '${entry.numOfCust}',
				billPerCust: '${entry.billPerCust}',
			},
			</#list>
		];
		
		require(['dgrid/Grid', 'dojo/domReady!'], function(Grid) {
			var grid = new Grid({
				columns: {
					billDate: '',
					numOfBill: "订单总数",
					totalAmount: "消费总额",
					numOfCust: "顾客总数",
					billPerCust: "顾客平均消费",
				}
			}, 'grid');
			grid.renderArray(data);
		});
	</script>
	
	<script>
		var chartColumnsData = new Array(data.length);
		require([
			"dojox/charting/Chart",
	        "dojox/charting/themes/MiamiNice",
	        "dojox/charting/plot2d/Columns",
	        "dojox/charting/plot2d/Markers",
	        "dojox/charting/axis2d/Default",
	        "dojox/charting/plot2d/Lines",
	        "dojo/domReady!"
		], function(Chart, theme) {
			for(var i=0; i<data.length; i++) {
				chartColumnsData[i] = {};
				chartColumnsData[i].billDate = data[i].billDate;
				chartColumnsData[i].totalAmount = data[i].totalAmount;
				chartColumnsData[i].numOfBill = data[i].numOfBill;
			}
			var chart = new Chart("chartNode");
			chart.setTheme(theme);
			chart.addPlot("default", {
				type: "Columns",
				markers: true,
				gap: 5
			});
			
			chart.addPlot("lines", {
				type: "Lines",
				hAxis: "x", 
				vAxis: "ly"
			});
			
			var xLabels = new Array(chartColumnsData.length);
			var yLabels = new Array(chartColumnsData.length);
			var lyLabels = new Array(chartColumnsData.length);
			for(var i=0;i<chartColumnsData.length;i++) {
				xLabels[i] = {};
				xLabels[i].value = i + 1;
				xLabels[i].text = chartColumnsData[i].billDate;
				
				yLabels[i] = parseFloat(chartColumnsData[i].totalAmount);
				lyLabels[i] = parseInt(chartColumnsData[i].numOfBill);
			}
			console.log(lyLabels);
			chart.addAxis("x", { labels: xLabels });
			chart.addAxis("y", { vertical: true, fixLower: "major", fixUpper: "major", leftBottom: true});
			chart.addAxis("ly", { vertical: true, leftBottom: false });
			
			chart.addSeries("Daily Sales", yLabels);
			chart.addSeries("Num of Bills", lyLabels, {plot:"lines"});
			chart.render();
		});
	</script>
	
	<div id="grid"></div>
	<div id="chartNode"></div>
</body>
</html>