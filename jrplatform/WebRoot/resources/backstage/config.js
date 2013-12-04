/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	
	config.filebrowserUploadUrl='/MS/handleFormUpload';
	
	
	/*
	config.toolbar_Full =

		[

		    ['Source','-','Save','NewPage','Preview','-','Templates'],

		    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],

		    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],

		    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],

		    '/',

		    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],

		    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],

		    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],

		    ['BidiLtr', 'BidiRtl'],

		    ['Link','Unlink','Anchor'],

		    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],

		    '/',

		    ['Styles','Format','Font','FontSize'],

		    ['TextColor','BGColor'],

		    ['Maximize', 'ShowBlocks','-','About']

		];
		*/
	
	 config.toolbar = 'TJ';
	    config.toolbar_TJ =
	    [
	     	['Save','Preview','-','Templates'],

		    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','SpellChecker', 'Scayt'],

		    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],

		    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select'],

		    '/',

		    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],

		    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],

		    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],

		    ['BidiLtr', 'BidiRtl'],

		    ['Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],

		    '/',

		    ['Styles','Format','Font','FontSize'],

		    ['TextColor','BGColor'],

		    ['ShowBlocks']
	    ];
};