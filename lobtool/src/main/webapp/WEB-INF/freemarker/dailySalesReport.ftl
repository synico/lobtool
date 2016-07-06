<#import "spring.ftl" as spring/>
<html>
<head>
	<link rel="stylesheet" href="../../resources/javascript/dojo/resources/dojo.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/dgrid.css" >
	<link rel="stylesheet" href="../../resources/javascript/dgrid/css/skins/claro.css" >
    <style type="text/css">
    table{
    	width:92%;
    	height:200;
    	position: relative;
    	left: 50px;
    	top: 15px;
    	frame:box;
    	border:none;
    	border-color:black;
    	border-radius:5px;
    	}
    table td{
    	color:blue;
    	text-align:center;
    	font-size:32;
    	color:#026EAC;
    	border:solid;
    	border-radius:5px;
    	border-color:#026EAC;
    	}
   	table th{
   	   	text-align:center;
   	   	color:#014A81;
   	   	font-size: 40;
   	   	font-family:Microsoft YaHei;
    	border:solid;
    	border-color:#026EAC;
   	   	padding: 10; 
    	border-radius:5px;
   		}
    
    h1{
    	color:white;
    	text-align:center;
       	font-family:Microsoft YaHei;
    	font-size: 20;
    }
    #grid {
        width:92%;
        height:300px;
        display:block;
        position: relative;
        left: 50px;
        right: 30px;
        top: 20px;
        background-color:#6113BC;
        border: 0;
       // padding-right:2cm
    }
    
    #chartNode,#chartSalesTrend {
        width:92%;
        height:400px;
        display:block;
        position: relative;
        left: 50px;
        top: 1px;
        bottom: 10px;
    }
    #symbol {
        width:92%;
        height:10px;
        display:block;
        position: relative;
        left: 50px;
        top: 1px;
        bottom: 2px;
        Color: #AB60F0;
        font-size: 20;
        font-family:Microsoft YaHei;
    }
    #bottomSpaceBlock {
        width:100%;
        height:100px;
        display:block;
        position: relative;
        left: 50px;
        top: 120px;
        bottom: 10px;
        text-align:center;
    }
    #paymentMethod {
        width:45%;
        height:400px;
        display:inline-block;
        position: relative;
        left: 50px;
        top: 65px;
        bottom: 10px;
    }
     #timePeriod {
        width:45%;
        height:400px;
        display:inline-block;
        position: relative;
        left: 7%;
        bottom: 10px;
        top: 65px;
        ticks: true;

    }
    #customerCount {
        width:45%;
        height:400px;
        display:inline-block;
        position: relative;
        left: 50px;
        bottom: 10px;
        top: 80px;
        ticks: true;

    }
    #avgPay {
        width:45%;
        height:400px;
        display:inline-block;
        position: relative;
        left: 7%;
        top: 80px;
        bottom: 10px;
    }

   
    </style>
</head>
<body background="../../resources/images/page_bg.jpg"
 class="claro">
	<script src="../../resources/javascript/dojoConfig.js"></script>
	<script src="../../resources/javascript/dojo/dojo.js"></script>
	
	<!-- Script 营业额数据表格-->
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
					billDate: '<@spring.message "dailySalesReport.billDate"/>',
					salesAmount: '<@spring.message "dailySalesReport.salesAmount"/>',
					numOfBill: '<@spring.message "dailySalesReport.numOfBill"/>',
					numOfCust: '<@spring.message "dailySalesReport.numOfCust"/>',
					billPerCust: '<@spring.message "dailySalesReport.billPerCust"/>',
				}
			}, 'grid');
			grid.renderArray(data);
		});
	</script>
	
	<!-- Script 营业额柱状图 by Nick -->
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
				labels: true, labelStyle: "outside", labelOffset: 25,
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
			chart.addAxis("x", { labels: xLabels });
			chart.addAxis("y", { vertical: true, fixLower: "major", fixUpper: "major", leftBottom: true});
			chart.addAxis("ly", { vertical: true, leftBottom: false });
			
			chart.addSeries("Daily Sales", yLabels);
			chart.addSeries("Num of Bills", lyLabels, {plot:"lines"});
			chart.render();
		});
	</script>

	<!-- Script 营业额柱状图+折线图 by Sam -->
	<script>
		require([
			"dojox/charting/Chart",
	        "dojox/charting/themes/PlotKit/purple",
	        "dojox/charting/plot2d/Columns",
	        "dojox/charting/plot2d/Bars",
	       // "dojox/charting/plot2d/Markers",
	        "dojox/charting/plot2d/ClusteredColumns",
	        "dojox/charting/axis2d/Default",
	        "dojox/charting/plot2d/Lines",
	        "dojox/charting/action2d/Highlight",
	        "dojox/charting/action2d/Tooltip",
	        "dojo/domReady!"
		], function(Chart, theme) {
			// Define the data
			var dailySales = [];
		    var numOfBill = [];
		    var numOfCust = [];
		    var billPerCust = [];
		    <#list dailySalesEntries as entry>
		        numOfBill.push(${entry.numOfBill});
		        dailySales.push(${entry.totalAmount?string("##0.0#")});
		        numOfCust.push(${entry.numOfCust});
		        billPerCust.push(${entry.billPerCust});
            </#list>
            
            var preWkDailySales = [];
            var preWkNumOfBill = [];
            var preWkNumOfCust = [];
            var preWkBillPerCust = [];
            <#list preWeekDailySalesEntries as entry>
                preWkDailySales.push(${entry.numOfBill});
                preWkNumOfBill.push(${entry.numOfBill});
                preWkNumOfCust.push(${entry.numOfBill});
                preWkBillPerCust.push(${entry.numOfBill});
            </#list>
			
			// Create the chart within it's "holding" node
			var chart = new Chart("chartSalesTrend");
			// Set the theme
			chart.setTheme(theme);
			// Add the only/default plot 
			chart.addPlot("default", {
				type: "ClusteredColumns",
				columns: true,
				minBarSize: 30, maxBarSize: 50,
				font: "normal normal bold 8pt Tahoma",
				//labels: true, labelStyle: "inside", labelOffset: -50,
				gap: 10,
			});
			chart.addPlot("other", {type: "Lines", hAxis: "x", vAxis: "other y"});
	
			chart.addAxis("x",{
    	labels: [{value: 1, text: "Mon"}, {value: 2, text: "Tue"},
        {value: 3, text: "Wed"}, {value: 4, text: "Thu"},
        {value: 5, text: "Fri"},{value: 6, text: "Sat"},{value: 7, text: "Sun"}]
    	});
			chart.addAxis("y", { vertical: true, fixLower: "major", fixUpper: "major" });
			//chart.addAxis("other x", {leftBottom: false});
			chart.addAxis("other y", {min: 0, max: 100, fixLower: "minor", fixUpper: "minor", vertical: true, leftBottom: false});

			// Add the series of data
			chart.addSeries("MonthlySales",dailySales,{plot: "default",fill:"#AB60F0"});
			chart.addSeries("LastWeek",preWkDailySales,{plot: "default",fill:"lightblue"});
			chart.addSeries("avgCustomerPay", billPerCust,{plot: "other", stroke: {color: "blue"}, fill:"lightblue"});
			chart.addSeries("sumOfCustomer", numOfCust,{plot: "other", stroke: {color: "red"}, fill:"lightblue"});

			// Render the chart!
			var anim1 = new dojox.charting.action2d.Highlight(chart, "default", {highlight: "lightskyblue"});
			var anim2 = new dojox.charting.action2d.Tooltip(chart, "default");
			chart.render();
			
		});
			
		</script>

	<!-- Script 支付方式饼图 by Sam -->
		<script>

			// x and y coordinates used for easy understanding of where they should display
			// Data represents website visits over a week period
			chartData = [];
			<#list paymentMethods as entry>
                 chartData.push({ x: 1, y: ${entry.numOfTrans!'0'}, text: "${entry.payMethodName!'unknow'} ${entry.proportion?string("##.##")}'%'" });
            </#list>
			

			require([
				 // Require the basic 2d chart resource
				"dojox/charting/Chart",
				// Require the theme of our choosing
				"dojox/charting/themes/PlotKit/purple",
				// Charting plugins: 
				// 	Require the Pie type of Plot 
				"dojox/charting/plot2d/Pie",
				// Wait until the DOM is ready
				"dojo/domReady!"
			], function(Chart, theme, PiePlot){

				// Create the chart within it's "holding" node
				var pieChart = new Chart("paymentMethod", {
				                                          title: '<@spring.message "paymentMethodChart.title"/>',
                                                          titlePos: "bottom",
                                                          titleGap: 5,
                                                          titleFont: "normal normal normal 15pt Microsoft YaHei",
                                                          titleFontColor: "#014A81"});
				
				// Set the theme
				pieChart.setTheme(theme);
				
				// Add the only/default plot 
				pieChart.addPlot("default", {
					type: PiePlot, // our plot2d/Pie module reference as type value
					radius: 200,
					fontColor: "#014A81",
					title: "test",
					labelOffset: -20
				});
				
				// Add the series of data
				pieChart.addSeries("January",chartData);

				// Render the chart!
				pieChart.render();

			});
		</script>

	<!-- Script 营业额分时段饼图 by Sam -->
		<script>

			timePeriodData = [];
			<#list salesAmount4TimeChart as entry>
			     timePeriodData.push({ x: 1, y: ${entry.amount?string("##0.#")}, text: '<@spring.messageArgs code="timeChart.noon" args=["${entry.amount}","${entry.proportion?string('##.##')}"]/>' })
			</#list>
			require([
				"dojox/charting/Chart",
				"dojox/charting/themes/PlotKit/purple",
				"dojox/charting/plot2d/Pie",
				"dojo/domReady!"
			], function(Chart, theme, PiePlot){
				// Create the chart within it's "holding" node
				var pieChart = new Chart("timePeriod", 
											{title: '<@spring.messageArgs code="timeChart.title" args=[11136]/>',
      										 titlePos: "bottom",
      										 titleGap: 5,
      										 titleFont: "normal normal normal 15pt Microsoft YaHei",
      										 titleFontColor: "#014A81"});
				// Set the theme
				pieChart.setTheme(theme);		
				// Add the only/default plot 
				pieChart.addPlot("default", {
					type: PiePlot, // our plot2d/Pie module reference as type value
					radius: 200,
					fontColor: "#014A81",
					title: "test",
					labelOffset: -20,
					font: "normal normal normal 10pt Microsoft YaHei"

				});
				
				// Add the series of data
				pieChart.addSeries("January",timePeriodData);

				// Render the chart!
				pieChart.render();

			});
		</script>

	<!-- Script 用餐人次饼图 by Sam -->
		<script>

			customerCountData = [];
			<#list custAmount4TimeChart as entry>
			     customerCountData.push({ x: 1, y: ${entry.amount?string("##0")}, text: '<@spring.messageArgs code="numOfCustChart.noon" args=["${entry.amount}",'${entry.proportion?string("##.##")}']/>' });
			</#list>
			require([
				"dojox/charting/Chart",
				"dojox/charting/themes/PlotKit/purple",
				"dojox/charting/plot2d/Pie",
				"dojo/domReady!"
			], function(Chart, theme, PiePlot){
				// Create the chart within it's "holding" node
				var pieChart = new Chart("customerCount", 
											{title: '<@spring.messageArgs code="numOfCustChart.title" args=["98"]/>',
      										 titlePos: "bottom",
      										 titleGap: 5,
      										 titleFont: "normal normal normal 15pt Microsoft YaHei",
      										 titleFontColor: "#014A81"});
				// Set the theme
				pieChart.setTheme(theme);		
				// Add the only/default plot 
				pieChart.addPlot("default", {
					type: PiePlot, // our plot2d/Pie module reference as type value
					radius: 200,
					fontColor: "#014A81",
					title: "test",
					labelOffset: -20,
					font: "normal normal normal 10pt Microsoft YaHei"

				});
				
				// Add the series of data
				pieChart.addSeries("January",customerCountData);

				// Render the chart!
				pieChart.render();

			});
		</script>

	<!-- Script 人均消费饼图 by Sam -->
		<script>

			avgPayData = [
				{ x: 1, y: 81, text: '<@spring.messageArgs code="billPerCustChart.noon" args=["81","32.79%"]/>' },
				{ x: 1, y: 69, text: '<@spring.messageArgs code="billPerCustChart.afternoon" args=["69","27.93%"]/>' },
				{ x: 1, y: 97, text: '<@spring.messageArgs code="billPerCustChart.evening" args=["97","39.27%"]/>' }
			];
			require([
				"dojox/charting/Chart",
				"dojox/charting/themes/PlotKit/purple",
				"dojox/charting/plot2d/Pie",
				"dojo/domReady!"
			], function(Chart, theme, PiePlot){
				// Create the chart within it's "holding" node
				var pieChart = new Chart("avgPay", 
											{title: '<@spring.messageArgs code="billPerCustChart.title" args=["82.33"]/>',
      										 titlePos: "bottom",
      										 titleGap: 5,
      										 titleFont: "normal normal normal 15pt Microsoft YaHei",
      										 titleFontColor: "#014A81"});
				// Set the theme
				pieChart.setTheme(theme);		
				// Add the only/default plot 
				pieChart.addPlot("default", {
					type: PiePlot, // our plot2d/Pie module reference as type value
					radius: 200,
					fontColor: "#014A81",
					title: "test",
					labelOffset: -20,
					font: "normal normal normal 10pt Microsoft YaHei"

				});
				
				// Add the series of data
				pieChart.addSeries("January",avgPayData);

				// Render the chart!
				pieChart.render();

			});
		</script>






	<!--View 构建营业额数据统计表-->
	<h1><@spring.message "salesAnalysis.header"/></h1>

	<table border="1">
	<!--固定表头-->
	<tr bgcolor="#AB60F0">
		<th></th>
  		<th><@spring.message "salesAnalysis.salesAmount"/></th>
  		<th><@spring.message "salesAnalysis.numOfBill"/></th>
  		<th><@spring.message "salesAnalysis.numOfCust"/></th>
  		<th><@spring.message "salesAnalysis.billPerCust"/></th>
	</tr>
	<!--当日营业数据 table-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.dailySummary"/></th>
  		<td>${todaySE.totalAmount}</td>
  		<td>${todaySE.numOfBill}</td>
  		<td>${todaySE.numOfCust}</td>
  		<td>${todaySE.billPerCust}</td>
	</tr>
	<!--占位行-->
	<tr bgcolor="#AB60F0"><th>&nbsp;</th><th></th><th></th><th></th><th></th></tr>
	<!--当月数据汇总-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.current"/></th>
  		<td>${presentMonthSE.totalAmount?string("#0.0#")}</td>
  		<td>${presentMonthSE.numOfBill}</td>
  		<td>${presentMonthSE.numOfCust}</td>
  		<td>${presentMonthSE.billPerCust?string("#0.0#")}</td>
	</tr>
	<!--上月同期数据汇总-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.previous"/></th>
  		<td>${previousMonthSE.totalAmount?string("#0.0#")}</td>
  		<td>${previousMonthSE.numOfBill}</td>
  		<td>${previousMonthSE.numOfCust}</td>
  		<td>${previousMonthSE.billPerCust?string("#0.0#")}</td>
	</tr>
	<!--环比增长-->
	<tr bgcolor="#eee6f5">
  		<th><@spring.message "salesAnalysis.monthSummary.monthComparison"/></th>
  		<td>${(((presentMonthSE.totalAmount-previousMonthSE.totalAmount)/previousMonthSE.totalAmount)*100)?string("#0.0#")}%</td>
  		<td>${(((presentMonthSE.numOfBill-previousMonthSE.numOfBill)/previousMonthSE.numOfBill)*100)?string("#0.0#")}%</td>
  		<td>${(((presentMonthSE.numOfCust-previousMonthSE.numOfCust)/previousMonthSE.numOfCust)*100)?string("#0.0#")}%</td>
  		<td>${(((presentMonthSE.billPerCust-previousMonthSE.billPerCust)/previousMonthSE.billPerCust)*100)?string("#0.0#")}%</td>
	</tr>
	</table>

	<br />

	<!--View 构建营业额走势图-->
		<h1><@spring.message "salesTrend.title.currentWeek"/></h1>
		<p id=symbol><img src="../../resources/images/img_currentWeek.jpg"  alt='<@spring.message "salesTrend.legend.currentWeek"/>' />&nbsp&nbsp<@spring.message "salesTrend.salesData.currentWeek"/>&nbsp&nbsp
					 <img src="../../resources/images/img_lastWeek.jpg" alt='<@spring.message "salesTrend.legend.prevWeek"/>'/>&nbsp&nbsp<@spring.message "salesTrend.salesData.prevWeek"/>&nbsp&nbsp
					 <img src="../../resources/images/img_blueLine.jpg" alt='<@spring.message "salesTrend.legend.billPerCust"/>'/>&nbsp&nbsp<@spring.message "salesTrend.salesData.billPerCust"/>&nbsp&nbsp
					 <img src="../../resources/images/img_redLine.jpg" alt='<@spring.message "salesTrend.legend.numOfCust"/>'/>&nbsp&nbsp<@spring.message "salesTrend.salesData.numOfCust"/>&nbsp&nbsp
		</p>
		<div id="chartSalesTrend"></div>
		<div id="chartNode"></div>
		
	<!-- View 支付方式饼图 -->
		<div id="paymentMethod"></div>
		
	<!-- View 各时段消费金额汇总 -->
		<div id="timePeriod"></div>
		
	<!-- View 用餐人次 -->
		<div id="customerCount"></div>
		
	<!-- View 人均消费 -->
		<div id="avgPay"></div>
		
		
		<div id=bottomSpaceBlock> <h1>Loaded</h1>
		</div>




		
</body>
</html>