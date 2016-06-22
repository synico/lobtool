<#import "spring.ftl" as spring/>
<html>
<head>
	<link rel="stylesheet" href="../../resources/javascript/dojo/resources/dojo.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/dgrid.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/skins/claro.css" >
	
    <link rel="stylesheet" href="../../resources/css/lobtool.css" >
</head>
<body background="../../resources/images/page_bg.jpg"
 class="claro">
	<script src="../../resources/javascript/dojoConfig.js"></script>
	<script src="../../resources/javascript/dojo/dojo.js"></script>
	
	<script>
		var data = [
			<#list dailySalesEntries as entry>
			{
				billDate: '${entry.billDate}',
				numOfBill: '${entry.numOfBill}',
				salesAmount: '${entry.totalAmount?string("##0.0#")}',
				numOfCust: '${entry.numOfCust}',
				billPerCust: '${entry.billPerCust}',
			},
			</#list>
		];
		
		require(['dgrid/Grid', 'dojo/domReady!'], function(Grid) {
			var grid = new Grid({
				columns: {
					billDate: "营业日期",
					salesAmount: "营业额",
					numOfBill: "订单数",
					numOfCust: "顾客数",
					billPerCust: "客单价",
				}
			}, 'grid');
			grid.renderArray(data);
		});
	</script>
	
	<script>
		var chartColumnsData = new Array(data.length);
		require([
			"dojox/charting/Chart",
	        //"dojox/charting/themes/MiamiNice",
	        "dojox/charting/themes/PlotKit/purple",
	        "dojox/charting/plot2d/Columns",
	        "dojox/charting/plot2d/Markers",
	        "dojox/charting/axis2d/Default",
	        "dojox/charting/plot2d/Lines",
	        "dojo/domReady!"
		], function(Chart, theme) {
			for(var i=0; i<data.length; i++) {
				chartColumnsData[i] = {};
				chartColumnsData[i].billDate = data[i].billDate;
				chartColumnsData[i].salesAmount = data[i].salesAmount;
				chartColumnsData[i].numOfBill = data[i].numOfBill;
			}
			var chart = new Chart("chartNode");
			chart.setTheme(theme);
			chart.addPlot("default", {
				type: "Columns",
				markers: true,
				gap: 5,
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
				
				yLabels[i] = parseFloat(chartColumnsData[i].salesAmount);
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
	<!--构建营业额数据统计表-->
	<h1><@spring.message "salesAnalysis.header"/></h1>
	<table border="1">
	<!--固定表头-->
	<tr bgcolor="#AB60F0">
		<th></th>
  		<th><@spring.message "salesAnalysis.header"/></th>
  		<th><@spring.message "salesAnalysis.salesAmount"/></th>
  		<th><@spring.message "salesAnalysis.numOfCust"/></th>
  		<th><@spring.message "salesAnalysis.billPerCust"/></th>
	</tr>
	<!--当日营业数据-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.dailySummary"/></th>
  		<td>123654</td>
  		<td>88</td>
  		<td>93</td>
  		<td>101</td>
	</tr>
	<!--占位行-->
	<tr bgcolor="#AB60F0"><th>&nbsp;</th><th></th><th></th><th></th><th></th></tr>
	<!--当月数据汇总-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.current"/></th>
  		<td>523654</td>
  		<td>888</td>
  		<td>1193</td>
  		<td>130.12</td>
	</tr>
	<!--上月同期数据汇总-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.previous"/></th>
  		<td>473654</td>
  		<td>898</td>
  		<td>1093</td>
  		<td>122</td>
	</tr>
	<!--环比增长-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.monthComparison"/></th>
  		<td>10.55%</td>
  		<td>-1.11%</td>
  		<td>9.62%</td>
  		<td>6.65%</td>
	</tr>
	</table>

	<br />

	<!--构建营业额走势图-->
	<p>
	<h1><@spring.message "salesTrend.title"/></h1>		
		<div id="chartSalesTrend"></div>

		<!-- load dojo and provide config via data attribute -->
		<script>
		require([
			"dojox/charting/Chart",
	        //"dojox/charting/themes/MiamiNice",
	        "dojox/charting/themes/PlotKit/purple",
	        "dojox/charting/plot2d/Columns",
	        "dojox/charting/plot2d/Bars",
	        "dojox/charting/plot2d/Markers",
	        "dojox/charting/plot2d/ClusteredColumns",
	        "dojox/charting/axis2d/Default",
	        "dojox/charting/plot2d/Lines",
	        "dojo/domReady!"
		], function(Chart, theme) {
			// Define the data
			var dailySales = [10000,9200,11811,12000,11111];
			var lastWeekDailySales = [12000,19200,10811,10000,17662,10087,10011];
			// Create the chart within it's "holding" node
			var chart = new Chart("chartSalesTrend");
			// Set the theme
			chart.setTheme(theme);
			// Add the only/default plot 
			chart.addPlot("default", {
				type: "ClusteredColumns",
				markers: true,
				minBarSize: 30, maxBarSize: 50,
				gap: 5
			});
			chart.addPlot("other", {type: "Lines", hAxis: "x", vAxis: "other y",labels: true, labelStyle: "outside", labelOffset: 25});
			
			// Add axes
			chart.addAxis("x",{
    	labels: [{value: 1, text: "Mon"}, {value: 2, text: "Tue"},
        {value: 3, text: "Wed"}, {value: 4, text: "Thu"},
        {value: 5, text: "Fri"},{value: 6, text: "Sat"},{value: 7, text: "Sun"}]
    	});
			chart.addAxis("y", { vertical: true, fixLower: "major", fixUpper: "major" });
			//chart.addAxis("other x", {leftBottom: false});
			chart.addAxis("other y", {min: 0, max: 100, fixLower: "minor", fixUpper: "minor", vertical: true, leftBottom: false});
				//chart.addAxis("y", { min: 5000, max: 15000, vertical: true, fixLower: "minor", fixUpper: "minor" });

			// Add the series of data
			chart.addSeries("MonthlySales",dailySales,{plot: "default",fill:"#AB60F0"});
			chart.addSeries("LastWeek",lastWeekDailySales,{plot: "default",fill:"lightblue"});
			chart.addSeries("avgCustomerPay", [70,19,18,10,17],{plot: "other", stroke: {color: "blue"}, fill:"lightblue"});
			chart.addSeries("sumOfCustomer", [60,39,48,60,97],{plot: "other", stroke: {color: "red"}, fill:"lightblue"});

			// Render the chart!
			chart.render();
			
		});
			
		</script>
		<br />
	<!--<div id="chartNode"></div>-->
	</p>
	<p>
	<br />
	<h1>Paymethod</h1>
	</p>
</body>
</html>