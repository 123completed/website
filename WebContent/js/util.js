(function($){

	C123 = {};

	C123.Util = {};


	/* CONSTANTS */

	C123.Util.Constants = {};

	C123.Util.Constants.BASE_PATH = '/123completed-website/WebContent/';

	C123.Util.Constants.CONTENT_PATH = C123.Util.Constants.BASE_PATH + 'content/';

	C123.Util.Constants.SNIPPETS_PATH = C123.Util.Constants.BASE_PATH + 'snippets/';

	C123.Util.Constants.DYMAMIC_CONTENT_PATH = C123.Util.Constants.BASE_PATH + 'ajax/';

	C123.Util.Constants.IMAGES_PATH = C123.Util.Constants.BASE_PATH + 'images/';

	C123.Util.Constants.CSS_PATH = C123.Util.Constants.BASE_PATH + 'css/';


	/* VARIABLES */

	C123.Util.Variables = {};

	C123.Util.Variables.isHomePage = false;


	/* FUNCTIONS */

	C123.Util.Fn = {};


	C123.Util.Fn.State = {};

	C123.Util.Fn.State.setHomePageFlag = function() {
		var docURL = document.URL;
		C123.Util.Variables.isHomePage =
				(docURL.indexOf('index.html') != -1 || docURL.indexOf('.com') == docURL.length - 5);
	};


	C123.Util.Fn.Load = {};


	C123.Util.Fn.Ajax = {};

	C123.Util.Fn.Ajax.loadAsObject = function(path, onSuccessFn) {
		return $('<div />').load(path, function(responseText, responseStatus, jqXmlHttpRequest) {
			onSuccessFn && onSuccessFn(responseText, responseStatus, jqXmlHttpRequest);
		});
	};


	/**
	 * JSON requests over Ajax:
	 * 
	 * dynamic-data.json: all string values should be normalized and must validate as strict HTML. 
	 * i.e. forbidden characters (e.g. '<', '&') should be replaced with their corresponding HTML entities.
	 */
	
	// TODO: inject into homepage
	
	C123.Util.Fn.Ajax.loadDynamicContent = function() {
		
		$.getJSON(
			C123.Util.Constants.DYMAMIC_CONTENT_PATH + 'dynamic-data.json'
		,	function(data) {

				var acks = data.acknowledgments;
				var news = data.news;
				var $acksContainer = $('.ticker-box.acknowledgments .ticker');
				var $newsContainer = $('.ticker-box.news .ticker');

				// TODO: benchmark
				// var start = new Date();
				// console.debug(new Date().getMilliseconds());
 				
 				// parse acknowledgments from JSON data and attach to the DOM 
				for (var n in acks) {
					var entry = acks[n];
					$('<div />').append(
						$('<blockquote />').text(entry.quote)
					).append(
						$('<p />').text(entry.ref).addClass('ref')
					).appendTo($acksContainer);
				}
				
				// console.debug(new Date().getMilliseconds());

 				// parse news from JSON data and attach to the DOM 
				for (var n in news) {
					var entry = news[n];
					$('<div />').addClass('item').append(
						$('<h3 />').text(entry.title).addClass('title')
					).append(
						$('<p />').text(entry.content).addClass('content')
					).append(
						$('<a />').attr('href', entry.more).html('Read More').addClass('more')
					).appendTo($newsContainer);
				}

				// initialize widgets
				C123.Util.Fn.Activation.initAcknowledgmentsTicker('.ticker-box.acknowledgments .ticker');
				C123.Util.Fn.Activation.initNewsTicker('.ticker-box.news .ticker');
			}
		);
	};


	C123.Util.Fn.Activation = {};

	C123.Util.Fn.Activation.initMainNavigation = function(elementSelector) {
		return $(elementSelector + ' ul.sf-menu').superfish({
			speed : 200
		,	disableHI : true
		});
	};

	C123.Util.Fn.Activation.initAcknowledgmentsTicker = function(elementSelector) {
		return $(elementSelector).innerfade({
			speed : 500
		,	timeout : 6700
		,	type : 'random_start'
		});
	};

	C123.Util.Fn.Activation.initNewsTicker = function(elementSelector) {
		return $(elementSelector).innerfade({
			speed : 500
		,	timeout : 3000
		});
	};


	C123.Util.Fn.Style = {};

	C123.Util.Fn.Style.hoverInteraction = function() {

		// footer container opacity
		$('#footer')
		.css('opacity', .5)
		.hover(
			function(){
				$(this).css('opacity', .9);
			}
		,	function(){
				$(this).css('opacity', .5);
			}
		);
		
		// custom buttons
		var $buttons = $('.c123-button');
		var $buttonsBorderColor = $buttons.css('border-color');
		var $buttonsBackgroundColor = $buttons.css('background-color');
		$buttons.hover(
			function(){
				$(this).css({
					'border-color' : '#eee'
				,	'background-color' : '#f6f6f6'
				});
			}
		,	function(){
				$(this).css({
					'border-color' : $buttonsBorderColor
				,	'background-color' : $buttonsBackgroundColor
				});
			}
		);
	};

	C123.Util.Fn.Style.loadingMaskShow = function() {
		$('<div class="loading-mask" />').append(
			$('<div class="label">1 2 3 Completed website is loading, please wait...</div>')
		).appendTo('html');
	};

	C123.Util.Fn.Style.loadingMaskHide = function() {
		$('.loading-mask').remove();
	};

/*
	C123.Util.Fn.Style.initTechnologiesLogoList = function(elementSelector) {
		
		$(elementSelector + ' ul li a img').hover(
			function() {
				var src = $(this).attr('src');
				var ext = C123.Util.Fn.String.getExtention(src);
				$(this).attr('src', src.replace('_gray' + ext, ext));
			}
		,	function() {
				var src = $(this).attr('src');
				var ext = C123.Util.Fn.String.getExtention(src);
				$(this).attr('src', src.replace(ext, '_gray' + ext));
			}
		);
	};
*/


	C123.Util.Fn.Aggregation = {};

	C123.Util.Fn.Aggregation.onDomReady = function(){
		
		C123.Util.Fn.Activation.initMainNavigation('#main-nav');

		C123.Util.Fn.Ajax.loadDynamicContent();

		C123.Util.Fn.Style.hoverInteraction();

	};


	C123.Util.Fn.String = {};

	C123.Util.Fn.String.getExtention = function(path) {
		return path.substring(path.lastIndexOf('.'));
	};



	/**
	 * Built-in types augmentation
	 */
	String.prototype.equalsIgnoreCase = function(str) {
		return this.toUpperCase() === str.toUpperCase();
	};


	
	/**
	 * flow invocations
	 */

	C123.Util.Fn.State.setHomePageFlag();

	C123.Util.Fn.Style.loadingMaskShow();
		
	$(document).ready(function(){
		C123.Util.Fn.Aggregation.onDomReady();
	});

	$(window).load(function(){
		C123.Util.Fn.Style.loadingMaskHide();
	});
	
})(jQuery);
