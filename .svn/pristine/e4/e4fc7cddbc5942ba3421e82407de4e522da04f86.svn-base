
<div class="row page-header">
	<div class="col-sm-12 col-lg-7 infobox-container">
		<div class="space-10"></div>
		
		<div class="infobox infobox-green  ">
			<div class="infobox-icon">
				<i class="icon-comments"></i>
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number">32</span>
				<div class="infobox-content">comments + 2 reviews</div>
			</div>
			<div class="stat stat-success">8%</div>
		</div>

		<div class="infobox infobox-blue  ">
			<div class="infobox-icon">
				<i class="icon-twitter"></i>
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number">11</span>
				<div class="infobox-content">new followers</div>
			</div>

			<div class="badge badge-success">
				+32%
				<i class="icon-arrow-up"></i>
			</div>
		</div>

		<div class="infobox infobox-pink  ">
			<div class="infobox-icon">
				<i class="icon-shopping-cart"></i>
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number">8</span>
				<div class="infobox-content">new orders</div>
			</div>
			<div class="stat stat-important">4%</div>
		</div>

		<div class="infobox infobox-red  ">
			<div class="infobox-icon">
				<i class="icon-beaker"></i>
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number">7</span>
				<div class="infobox-content">experiments</div>
			</div>
		</div>

		<div class="infobox infobox-orange2  ">
			<div class="infobox-chart">
				<span class="sparkline" data-values="196,128,202,177,154,94,100,170,224"></span>
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number">6,251</span>
				<div class="infobox-content">pageviews</div>
			</div>

			<div class="badge badge-success">
				7.2%
				<i class="icon-arrow-up"></i>
			</div>
		</div>

		<div class="infobox infobox-blue2  ">
			<div class="infobox-progress">
				<div class="easy-pie-chart percentage" data-percent="42" data-size="46">
					<span class="percent">42</span>%
				</div>
			</div>

			<div class="infobox-data">
				<span class="infobox-text">traffic used</span>

				<div class="infobox-content">
					<span class="bigger-110">~</span>
					58GB remaining
				</div>
			</div>
		</div>

		<div class="space-6"></div>

		<div class="infobox infobox-green infobox-small infobox-dark">
			<div class="infobox-progress">
				<div class="easy-pie-chart percentage" data-percent="61" data-size="39">
					<span class="percent">61</span>%
				</div>
			</div>

			<div class="infobox-data">
				<div class="infobox-content">Task</div>
				<div class="infobox-content">Completion</div>
			</div>
		</div>

		<div class="infobox infobox-blue infobox-small infobox-dark">
			<div class="infobox-chart">
				<span class="sparkline" data-values="3,4,2,3,4,4,2,2"></span>
			</div>

			<div class="infobox-data">
				<div class="infobox-content">Earnings</div>
				<div class="infobox-content">$32,000</div>
			</div>
		</div>

		<div class="infobox infobox-grey infobox-small infobox-dark">
			<div class="infobox-icon">
				<i class="icon-download-alt"></i>
			</div>

			<div class="infobox-data">
				<div class="infobox-content">Downloads</div>
				<div class="infobox-content">1,205</div>
			</div>
		</div>
	</div>
	<div class="col-sm-12 col-lg-5">
		<div class="widget-box transparent">
			<div class="widget-header widget-header-flat">
				<h4 class="lighter">
					<i class="icon-circle-blank"></i>
					Product Stats <small>( Top 10 selling products )</small>
				</h4>
	
				<div class="widget-toolbar">
					<a href="#" data-action="collapse">
						<i class="icon-chevron-up"></i>
					</a>
				</div>
			</div>
	
			<div class="widget-body">
				<div class="widget-main padding-0">
					<div id="piechartdiv" style="height: 200px;"></div>
				</div><!-- /widget-main -->
			</div><!-- /widget-body -->
		</div><!-- /widget-box -->
	</div>	
	
	<div class="col-sm-12 col-lg-12">
		<div class="widget-box transparent padding-0">
			<!-- <div class="widget-header widget-header-flat">
				<h4 class="lighter">
					<i class="icon-signal"></i>
					Sale Stats
				</h4>
			</div> -->
	
			<div class="widget-body">
				<div class="widget-main padding-0">
	
					<div id="legenddiv"></div>
					<div id="myChartdiv" style="height: 250px;"></div>
				</div>
			</div>
		</div>
	</div>
		
</div>
<script type="text/javascript">
	var chart,piechart;
	var chartData = [
	    {
	        "year": 2009,
	        "income": 23.5,
	        "expenses": 18.1
	    },
	    {
	        "year": 2010,
	        "income": 26.2,
	        "expenses": 22.8
	    },
	    {
	        "year": 2011,
	        "income": 30.1,
	        "expenses": 23.9
	    },
	    {
	        "year": 2012,
	        "income": 29.5,
	        "expenses": 25.1
	    },
	    {
	        "year": 2013,
	        "income": 30.6,
	        "expenses": 27.2
	    },
	    {
	        "year": 2010,
	        "income": 26.2,
	        "expenses": 22.8
	    },
	    {
	        "year": 2011,
	        "income": 30.1,
	        "expenses": 23.9
	    },
	    {
	        "year": 2012,
	        "income": 29.5,
	        "expenses": 25.1,
	        "dashLengthLine": 5
	    },
	    {
	        "year": 2014,
	        "income": 34.1,
	        "expenses": 29.9,
	        "dashLengthColumn": 5,
	        "alpha":0.2,
	        "additional":"(projection)"
	    }
	];
	
	$(document).ready(function () {
	    // SERIAL CHART  
 	    chart  = new AmCharts.AmSerialChart();
	    	    
	    chart.dataProvider = chartData;
	    chart.categoryField = "year";
	    chart.startDuration = 1;
	    
	    chart.handDrawn = true;
	    chart.handDrawnScatter = 3;
	
	    // AXES
	    // category
	    var categoryAxis = chart.categoryAxis;
	    categoryAxis.gridPosition = "start";
	
	    // value
	    var valueAxis = new AmCharts.ValueAxis();
	    valueAxis.axisAlpha = 0;
	    chart.addValueAxis(valueAxis);
	
	    // GRAPHS
	    // column graph
	    var graph1 = new AmCharts.AmGraph();
	    graph1.type = "column";
	    graph1.title = "Income";
	    graph1.lineColor = "#438EB9";
	    graph1.valueField = "income";
	    graph1.lineAlpha = 1;
	    graph1.fillAlphas = 1;
	    graph1.dashLengthField = "dashLengthColumn";
	    graph1.alphaField = "alpha";
	    graph1.balloonText = "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b> [[additional]]</span>";
	    chart.addGraph(graph1);
	
	    // line
	    var graph2 = new AmCharts.AmGraph();
	    graph2.type = "line";
	    graph2.title = "Expenses";
	    graph2.lineColor = "#fcd202";
	    graph2.valueField = "expenses";
	    graph2.lineThickness = 3;
	    graph2.bullet = "round";
	    graph2.bulletBorderThickness = 3;
	    graph2.bulletBorderColor = "#fcd202";
	    graph2.bulletBorderAlpha = 1;
	    graph2.bulletColor = "#ffffff";
	    graph2.dashLengthField = "dashLengthLine";
	    graph2.balloonText = "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b> [[additional]]</span>";
	    chart.addGraph(graph2);

	    // LEGEND
	    var legend = new AmCharts.AmLegend();
	    chart.addLegend(legend,"legenddiv");
	    chart.pathToImages = "${pageContext.request.contextPath}/assets/js/amcharts/images/";

	    chart.amExport= {
                top: 21,
                right: 21,
                buttonColor: '#EFEFEF',
                buttonRollOverColor:'#DDDDDD',
                exportPNG:true,
                exportJPG:true,
                exportPDF:true,
                exportSVG:true
            };
	    chart.depth3D = 10;
	    chart.angle = 15;
	    // WRITE
	    chart.write("myChartdiv");

	    
	    
	 	// PIE CHART
        
         chartData = [
                {
                    "country": "United States",
                    "visits": 9252
                },
                {
                    "country": "China",
                    "visits": 1882
                },
                {
                    "country": "Japan",
                    "visits": 1809
                },
                {
                    "country": "Germany",
                    "visits": 1322
                },
                {
                    "country": "United Kingdom",
                    "visits": 1122
                },
                {
                    "country": "France",
                    "visits": 1114
                },
                {
                    "country": "India",
                    "visits": 984
                },
                {
                    "country": "Spain",
                    "visits": 711
                }
            ];
	 	
	 	
	 	piechart = new AmCharts.AmPieChart();

        // title of the chart
        //piechart.addTitle("Visitors countries", 16);

        piechart.dataProvider = chartData;
        piechart.titleField = "country";
        piechart.valueField = "visits";
        piechart.sequencedAnimation = true;
        piechart.startEffect = "<";
        piechart.innerRadius = "30%";
        piechart.startDuration = 1;
        piechart.labelRadius = 15;
        piechart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
        // the following two lines makes the chart 3D
        piechart.depth3D = 10;
        piechart.angle = 15;
        piechart.pathToImages = "${pageContext.request.contextPath}/assets/js/amcharts/images/";
        piechart.amExport= {
                top: 21,
                right: 21,
                buttonColor: '#EFEFEF',
                buttonRollOverColor:'#DDDDDD',
                exportPNG:true,
                exportJPG:true,
                exportPDF:true,
                exportSVG:true
            };
        // WRITE                                 
        piechart.write("piechartdiv");
        
        
        $('.easy-pie-chart.percentage').each(function(){
			var $box = $(this).closest('.infobox');
			var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
			var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
			var size = parseInt($(this).data('size')) || 50;
			$(this).easyPieChart({
				barColor: barColor,
				trackColor: trackColor,
				scaleColor: false,
				lineCap: 'butt',
				lineWidth: parseInt(size/10),
				animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
				size: size
			});
		})
	
		$('.sparkline').each(function(){
			var $box = $(this).closest('.infobox');
			var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
			$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
		});
	
	
	});
 </script>