/**
 * This jQuery plugin displays pagination links inside the selected elements.
 *
 * 更新说明：本源码对齐样式为右对齐
 *
 * @author Gabriel Birke (birke *at* d-scribe *dot* de)
 * @version 1.2
 * @param {int} maxentries Number of entries to paginate
 * @param {Object} opts Several options (see README for documentation)
 * @return {Object} jQuery Object
 */
jQuery.fn.pagination = function(maxentries, opts){
	opts = jQuery.extend({
		items_per_page         : 20,
		num_display_entries    : 10,
		current_page           : 0,
		num_edge_entries       : 2,
		page_size              : [20],
		link_to                : "#",
		prev_text              : "上一页",
		next_text              : "下一页",
		jump_text              : "确认",
		jump_msg               : "请输入跳转的页数",
		jump_display           : true,
		pagesize_option_display: false,
		ellipse_text           : "...",
		prev_show_always       : true,
		next_show_always       : true,
		callback               : function(){return false;}
	},opts||{});
	
	return this.each(function() {
		/**
		 * Calculate the maximum number of pages
		 */
		function numPages() {
			return Math.ceil(maxentries/opts.items_per_page);
		}
		
		/**
		 * Calculate start and end point of pagination links depending on 
		 * current_page and num_display_entries.
		 * @return {Array}
		 */
		function getInterval()  {
			var ne_half = Math.ceil(opts.num_display_entries/2);
			var np = numPages();
			var upper_limit = np-opts.num_display_entries;
			var start = current_page>ne_half?Math.max(Math.min(current_page-ne_half, upper_limit), 0):0;
			var end = current_page>ne_half?Math.min(current_page+ne_half, np):Math.min(opts.num_display_entries, np);
			return [start,end];
		}
		
		/**
		 * This is the event handling function for the pagination links. 
		 * @param {int} page_id The new page number
		 */
		function pageSelected(page_id, evt){
		
			var np = numPages();
			if(page_id == "jumppage")
			{
				page_id = $("#jumppage").attr("value");	
				if(isNaN(page_id)){
					opts.callback(null,opts.jump_msg);
					return;	
				}
				page_id = Number(page_id)<0 ? 1 : (page_id>np ? (np-1) : (page_id-1)); 
			
				if(page_id < 0){
					page_id = 0;
				}
			
			}		
			
			current_page = page_id;
			drawLinks();
			var continuePropagation = opts.callback(page_id);
			if (!continuePropagation) {
				if (evt.stopPropagation) {
					evt.stopPropagation();
				}
				else {
					evt.cancelBubble = true;
				}
			}
			return continuePropagation;
		}
		
		/**
		 * This function inserts the pagination links into the container element
		 */
		function drawLinks() {
			panel.empty();
			
			var lastnum = 0;
			
			var interval = getInterval();
			var np = numPages();
			// This helper function returns a handler function that calls pageSelected with the right page_id
			var getClickHandler = function(page_id) {
				return function(evt){ return pageSelected(page_id,evt); }
			}
			// Helper function for generating a single link (or a span tag if it's the current page)
			var appendItem = function(page_id, appendopts){	
				if(page_id != "jumppage"){
					page_id = page_id<0?0:(page_id<np?page_id:np-1); // Normalize page id to sane value
				}			
				appendopts = jQuery.extend({text:page_id+1, classes:""}, appendopts||{});
				
				if(lastnum == appendopts.text){	return;	}
				lastnum = appendopts.text;
				
				if(page_id == current_page){
					var lnk = jQuery("<span class='current'>"+(appendopts.text)+"</span>");
				}
				else
				{
					var lnk = jQuery("<a>"+(appendopts.text)+"</a>")
						.bind("click", getClickHandler(page_id))
						.attr('href', opts.link_to.replace(/__id__/,page_id));						
				}
				if(appendopts.classes){lnk.addClass(appendopts.classes);}
				panel.append(lnk);
				
			}
			
			if(opts.pagesize_option_display)
			{
				var pagesizeLinks = "<select>";
				for(var pagei=0; pagei<opts.page_size.length; pagei++)
				{
					var pSize = opts.page_size[pagei];
					if(opts.items_per_page == pSize){
						pagesizeLinks += "<option selected>";
					}else{
						pagesizeLinks += "<option>";
					}
					pagesizeLinks += pSize;
					pagesizeLinks += "</option>";
				}
				pagesizeLinks = jQuery(pagesizeLinks+"</select>").bind("change",function(event){
					opts.items_per_page = $(this).val();
					pageSelected(current_page,event);
				});
				
				panel.append(pagesizeLinks);
			}
			
			if(opts.jump_display)
			{
				appendItem("jumppage",{text:opts.jump_text, classes:"next"});
				panel.append("<span><input id='jumppage' type='text'/></span>");			
				panel.append("<span class='jump_span'>共"+np+"页&nbsp;,共"+maxentries+"条数据/&nbsp;跳转至</span>");
			}
			
			// Generate "Next"-Link Ђһҳ
			if(opts.next_text && (current_page < np-1 || opts.next_show_always)){
				appendItem(current_page+1,{text:opts.next_text, classes:"next"});
			}
			
			//С˽ؖ
			// Generate starting points			
			if (interval[1] < np && opts.num_edge_entries > 0)
			{
				var begin = Math.max(np-opts.num_edge_entries, interval[1]);
				for(var i=np-1; i>=begin; i--) {
					appendItem(i);
				}
				if(np-opts.num_edge_entries > interval[1]&& opts.ellipse_text)
				{
					jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
				}
			}
			
			// Generate interval links
			for(var i=interval[1]; i>=interval[0]; i--) {
				appendItem(i);
			}
			
			//ճ˽ؖ
			// Generate ending points
			if (interval[0] > 0 && opts.num_edge_entries > 0)
			{
				if(opts.num_edge_entries < interval[0] && opts.ellipse_text)
				{
					jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
				}
				
				var end = Math.min(opts.num_edge_entries, interval[0]);
				for(var i=end-1; i>=0; i--) {
					appendItem(i);
				}
			}
			
			// Generate "Previous"-Link ʏһҳ
			if(opts.prev_text && (current_page > 0 || opts.prev_show_always)){
				appendItem(current_page-1,{text:opts.prev_text, classes:"prev"});
			}
		}
		
		// Extract current_page from options
		var current_page = opts.current_page;
		// Create a sane value for maxentries and items_per_page
		maxentries = (!maxentries || maxentries < 0)?1:maxentries;
		opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0)?1:opts.items_per_page;
		// Store DOM element for easy access from all inner functions
		var panel = jQuery(this);
		// Attach control functions to the DOM element 
		this.selectPage = function(page_id){ pageSelected(page_id);}
		this.prevPage = function(){ 
			if (current_page > 0) {
				pageSelected(current_page - 1);
				return true;
			}
			else {
				return false;
			}
		}
		this.nextPage = function(){ 
			if(current_page < numPages()-1) {
				pageSelected(current_page+1);
				return true;
			}
			else {
				return false;
			}
		}
		// When all initialisation is done, draw the links
		drawLinks();
        // call callback function
        //opts.callback(current_page, this);
	});
}


