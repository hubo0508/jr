if (!window.ol) {
	window.ol = {}
}
(function() {
	var a = jQuery;
	ol.loading = function(c) {
		var b = this;
		this.loadingImg;
		this.loadingMask;
		this.container;
		var d = {
			id : null,
			loadingClass : null,
			zIndex : 800
		};
		this.init = function() {
			c = a.extend( {}, d, c);
			this.container = a("#" + c.id);
			var e = this.container.css("position");
			var g = this.container.outerWidth();
			e = e == "absolute" ? "absolute" : "relative";
			g = g > 0 ? g : "";
			var h = a("<div></div>").css( {
				position : e,
				top : this.container.css("top"),
				left : this.container.css("left"),
				right : this.container.css("right"),
				bottom : this.container.css("bottom"),
				width : g
			});
			this.container.css( {
				position : "relative",
				width : "100%",
				top : null,
				right : null,
				left : null,
				bottom : null
			}).wrap(h);
			this.loadingMask = a('<div class="ol_loading_mask"></div>');
			this.loadingMask.css( {
				zIndex : c.zIndex
			});
			this.loadingImg = a('<div class="ol_loading"></div>').css(
					"z-index", c.zIndex + 1);
			if (!c.loadingClass) {
				this.loadingImg.addClass(c.loadingClass);
				this.loadingMask.addClass(c.loadingClass + "_mask")
			}
			this.container.parent().append(this.loadingMask).append(
					this.loadingImg);
			this.loadingMask.bgiframe()
		};
		this.show = function() {
			if (a.browser.msie && /6.0/.test(navigator.userAgent)) {
				this.loadingMask.css( {
					width : this.container.outerWidth(),
					height : this.container.outerHeight()
				})
			}
			this.loadingMask.css("display", "block");
			this.loadingImg.css("display", "block")
		};
		this.hide = function() {
			this.loadingMask.css("display", "none");
			this.loadingImg.fadeOut(0)
		};
		this.init()
	}
})();