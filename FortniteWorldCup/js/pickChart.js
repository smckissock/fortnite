
const green ='#319236';
const purple = '#9D4DBB';
const blue = '#4C51F7';
const red = '#DB4441';
const teal = '#3E93BC';
const lime = '#3CFF3E';
const grey = '#B3B3B3';
const brown = '#8B4513';


/**
 * The select menu is a simple widget designed to filter a dimension by selecting an option from
 * an HTML `<select/>` menu. The menu can be optionally turned into a multiselect.
 * @class selectMenu
 * @memberof dc
 * @mixes dc.baseMixin
 * @example
 * // create a select menu under #select-container using the default global chart group
 * var select = dc.pickChart('#select-container')
 *                .dimension(states)
 *                .group(stateGroup);
 * // the option text can be set via the title() function
 * // by default the option text is '`key`: `value`'
 * select.title(function (d){
 *     return 'STATE: ' + d.key;
 * })
 * @param {String|node|d3.selection|dc.compositeChart} parent - Any valid
 * [d3 single selector](https://github.com/mbostock/d3/wiki/Selections#selecting-elements) specifying
 * a dom block element such as a div; or a dom element or d3 selection.
 * @param {String} [chartGroup] - The name of the chart group this widget should be placed in.
 * Interaction with the widget will only trigger events and redraws within its group.
 * @returns {selectMenu}
 **/
dc.pickChart = function (parent, chartGroup) {
    var SELECT_CSS_CLASS = 'dc-select-menu';
    var OPTION_CSS_CLASS = 'dc-select-option';

    var _chart = dc.baseMixin({});

    var _select;
    var _promptText = 'Select all';
    var _multiple = false;
    var _promptValue = null;
    var _numberVisible = null;
    var _order = function (a, b) {
        return _chart.keyAccessor()(a) > _chart.keyAccessor()(b) ?
             1 : _chart.keyAccessor()(b) > _chart.keyAccessor()(a) ?
            -1 : 0;
    };

    var _filterDisplayed = function (d) {
        return _chart.valueAccessor()(d) > 0;
    };

    _chart.data(function (group) {
        return group.all().filter(_filterDisplayed);
    });

    _chart._doRender = function () {
        _chart.select('select').remove();
        _select = _chart.root().append('select')
                        .classed(SELECT_CSS_CLASS, true);
        _select.append('option').text(_promptText).attr('value', '');

        _chart._makeCircles();
        _chart._doRedraw();
        return _chart;
    };

    _chart._makeCircles = function () {
        
        let svg = _chart.root().append("svg")
            .attr("width", 300)
            .attr("height", 220);
        
        const radius = 45;    
        const regions = [
            {x:50, y:60, color: green, name: "NA EAST", textOffset:33},
            {x:150, y:60, color: purple, name: "NA WEST", textOffset:35},
            {x:250, y:60, color: blue, name: "EUROPE", textOffset:30},
            {x:50, y:160, color: red, name: "OCEANA", textOffset:32},
            {x:150, y:160, color: teal, name: "BRAZIL", textOffset:26},
            {x:250, y:160, color: brown, name: "ASIA", textOffset:20}
        ]; 

        regions.forEach(function(region) {
            svg.append("circle")
                .attr("cx", region.x)
                .attr("cy", region.y)
                .attr("r", radius)
                .attr("fill", region.color)
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .on('mouseover', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 6)
                })
                .on('mouseout', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0)
                })
                .on('mousedown', function (d) {
                    console.log("DOWN")
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 12)
                });
    
                
            svg.append("text")
                .attr("x", region.x - region.textOffset)
                .attr("y", region.y + 5)
                .text(region.name)
                .attr("font-size", "1.4em")
                .attr("fill", "black")
                .attr("pointer-events", "none");
        });
        console.log(_chart.data());
    }


    // Fixing IE 11 crash when redrawing the chart
    // see here for list of IE user Agents :
    // http://www.useragentstring.com/pages/useragentstring.php?name=Internet+Explorer
    var ua = window.navigator.userAgent;
    // test for IE 11 but not a lower version (which contains MSIE in UA)
    if (ua.indexOf('Trident/') > 0 && ua.indexOf('MSIE') === -1) {
        _chart.redraw = _chart.render;
    }

    _chart._doRedraw = function () {
        setAttributes();
        renderOptions();
        // select the option(s) corresponding to current filter(s)
        if (_chart.hasFilter() && _multiple) {
            _select.selectAll('option')
                .property('selected', function (d) {
                    return typeof d !== 'undefined' && _chart.filters().indexOf(String(_chart.keyAccessor()(d))) >= 0;
                });
        } else if (_chart.hasFilter()) {
            _select.property('value', _chart.filter());
        } else {
            _select.property('value', '');
        }
        return _chart;
    };

    function renderOptions () {
        var options = _select.selectAll('option.' + OPTION_CSS_CLASS)
          .data(_chart.data(), function (d) { return _chart.keyAccessor()(d); });

        options.exit().remove();

        options.enter()
              .append('option')
              .classed(OPTION_CSS_CLASS, true)
              .attr('value', function (d) { return _chart.keyAccessor()(d); })
            .merge(options)
              .text(_chart.title());

        _select.selectAll('option.' + OPTION_CSS_CLASS).sort(_order);

        _select.on('change', onChange);
    }

    function onChange (d, i) {
        var values;
        var target = d3.event.target;
        if (target.selectedOptions) {
            var selectedOptions = Array.prototype.slice.call(target.selectedOptions);
            values = selectedOptions.map(function (d) {
                return d.value;
            });
        } else { // IE and other browsers do not support selectedOptions
            // adapted from this polyfill: https://gist.github.com/brettz9/4212217
            var options = [].slice.call(d3.event.target.options);
            values = options.filter(function (option) {
                return option.selected;
            }).map(function (option) {
                return option.value;
            });
        }
        // console.log(values);
        // check if only prompt option is selected
        if (values.length === 1 && values[0] === '') {
            values = _promptValue || null;
        } else if (!_multiple && values.length === 1) {
            values = values[0];
        }
        _chart.onChange(values);
    }

    _chart.onChange = function (val) {
        if (val && _multiple) {
            _chart.replaceFilter([val]);
        } else if (val) {
            _chart.replaceFilter(val);
        } else {
            _chart.filterAll();
        }
        dc.events.trigger(function () {
            _chart.redrawGroup();
        });
    };

    function setAttributes () {
        if (_multiple) {
            _select.attr('multiple', true);
        } else {
            _select.attr('multiple', null);
        }
        if (_numberVisible !== null) {
            _select.attr('size', _numberVisible);
        } else {
            _select.attr('size', null);
        }
    }

    /**
     * Get or set the function that controls the ordering of option tags in the
     * select menu. By default options are ordered by the group key in ascending
     * order.
     * @name order
     * @memberof dc.selectMenu
     * @instance
     * @param {Function} [order]
     * @example
     * // order by the group's value
     * chart.order(function (a,b) {
     *     return a.value > b.value ? 1 : b.value > a.value ? -1 : 0;
     * });
     **/
    _chart.order = function (order) {
        if (!arguments.length) {
            return _order;
        }
        _order = order;
        return _chart;
    };

    return _chart.anchor(parent, chartGroup);
};
