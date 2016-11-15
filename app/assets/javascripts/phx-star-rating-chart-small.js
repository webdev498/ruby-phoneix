;function starRatingChartSmall(starRatings){
    var canvasHeight = 80;
    var dataSet = starRatings || [3, 4, 5, 5, 4, 3, 1, 4, 5, 4];
    var heightRatio = d3.max([5]) / canvasHeight;

    var canvas = d3.select("#star-rating-chart")
        .append("svg").attr("width", "100%")
        .attr("height", canvasHeight + "px")

    var rectWidth = canvas.style("width").replace("px", "") / dataSet.length;
    var barPadding = rectWidth / 5;

    //Chart
    canvas.selectAll('rect')
        .data(dataSet)
        .enter()
        .append('rect');

    canvas.selectAll('rect')
        .attr('x', function(d,i){return i*( rectWidth );})
        .attr('y',  function(d){return canvasHeight;})
        .attr("height", function(d){return 0;})
        .attr("width", rectWidth - barPadding)
        .attr("fill", function(d){ return "rgb(80, " + Math.floor(180 - d/d3.max(dataSet) * 100 )   +", 200)"; });

    //Animate the chart
    canvas.selectAll('rect')
        .transition().duration(1700)
        .attr('y',  function(d){return canvasHeight - d/heightRatio;})
        .attr("height", function(d){return d/heightRatio;});

    // Text
    canvas.selectAll('text')
        .data(dataSet)
        .enter()
        .append('text');

    canvas.selectAll('text')
        .attr('x', function(d,i){return i*( rectWidth ) + barPadding * 2 ;})
        .attr('y',  function(d){return canvasHeight - d/heightRatio + 15;})
        .style("text-anchor", "middle")
        .attr("font-size", "10px")
        .attr("fill", "#ffffff")
        .text(function(d){return d;});
}
