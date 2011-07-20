{include file='header.tpl' menu='topic_action' showWhiteBack=true}


{literal}
<script language="JavaScript" type="text/javascript">
document.addEvent('domready', function() {	
	new Autocompleter.Request.LS.JSON($('topic_tags'), aRouter['ajax']+'autocompleter/tag/?security_ls_key='+LIVESTREET_SECURITY_KEY, {
		'indicatorClass': 'autocompleter-loading', // class added to the input during request
		'minLength': 2, // We need at least 1 character
		'selectMode': 'pick', // Instant completion
		'multiple': true // Tag support, by default comma separated
	}); 
});
</script>
{/literal}


{if $oConfig->GetValue('view.tinymce')}
<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/tinymce/tiny_mce.js"></script>

<script type="text/javascript">
{literal}
tinyMCE.init({
	mode : "specific_textareas",
         editor_selector : "mceEditor",
	theme : "advanced",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_buttons1 : "lshselect,bold,italic,underline,strikethrough,|,bullist,numlist,|,undo,redo,|,lslink,unlink,lsvideo,lsimage,pagebreak,code",
	theme_advanced_buttons2 : "",
	theme_advanced_buttons3 : "",
	theme_advanced_statusbar_location : "bottom",
	theme_advanced_resizing : true,
	theme_advanced_resize_horizontal : 0,
	theme_advanced_resizing_use_cookie : 0,
	theme_advanced_path : false,
	object_resizing : true,
	force_br_newlines : true,
    forced_root_block : '', // Needed for 3.x
    force_p_newlines : false,    
    plugins : "lseditor,safari,inlinepopups,media,pagebreak",
    inline_styles:false,
    formats : {
        underline : {inline : 'u', exact : true},
        strikethrough : {inline : 's', exact : true}
    },
    convert_urls : false,
    extended_valid_elements : "embed[src|type|allowscriptaccess|allowfullscreen|width|height]",
    pagebreak_separator :"<cut>",
    media_strict : false,
    language : TINYMCE_LANG
});
{/literal}
</script>

{else}
	{include file='window_load_img.tpl' sToLoad='topic_text'}
{/if}

<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/swfupload/swfupload.swfobject.js"></script>
<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/swfupload/swfupload.js"></script>
<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/swfupload/swfupload.handlers.js"></script>
<script type="text/javascript">
    {literal}
        if (Browser.Plugins.Flash.version) {
            {/literal}
            var path_root_engine_lib = '{cfg name='path.root.engine_lib'}';
            var topic_id = '{$_aRequest.topic_id}';
            var SSID='{$_sPhpSessionId}'
            {literal}
            var target_tmp = (Cookie.read('ls_photoset_target_tmp')) ? Cookie.read('ls_photoset_target_tmp') : 0;
           
            document.addEvent('domready', function() {	
                 swfu = new SWFUpload({
                    // Backend Settings
                    upload_url: aRouter['photoset']+"upload",
                    post_params: {'ls_photoset_target_tmp':target_tmp,'topic_id':topic_id, 'SSID':SSID, 'security_ls_key': LIVESTREET_SECURITY_KEY},

                    // File Upload Settings
                    file_types : "*.jpg; *.JPG;*.png;*.gif",
                    file_types_description : "Images",
                    file_upload_limit : "0",

                    // Event Handler Settings - these functions as defined in Handlers.js
                    //  The handlers are not part of SWFUpload but are part of my website and control how
                    //  my website reacts to the SWFUpload events.
                    file_queue_error_handler : fileQueueError,
                    file_dialog_complete_handler : fileDialogComplete,
                    upload_progress_handler : uploadProgress,
                    upload_error_handler : uploadError,
                    upload_success_handler : uploadSuccess,
                    upload_complete_handler : uploadComplete,

                    // Button Settings
                    button_placeholder_id : "topic-photo-upload-input",
                    button_width: 122,
                    button_height: 30,
                    button_text : '<span class="button">Загрузить фото</span>',
                    button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 14pt; } .buttonSmall { font-size: 10pt; }',
                    button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
                    button_text_left_padding: 6,
                    button_text_top_padding: 3,
                    button_cursor: SWFUpload.CURSOR.HAND,

                    // Flash Settings
                    flash_url : path_root_engine_lib+'/external/swfupload/swfupload.swf',

                    custom_settings : {
                        upload_target : "notice_wrap"
                    },

                    // Debug Settings
                    debug: false
                });
            });
        }
    {/literal}
</script>
<div class="topic" style="display: none;">
	<div class="content" id="text_preview"></div>
</div>

<div class="profile-user">
	{if $sEvent=='add'}
		<h1>{$aLang.topic_photoset_create}</h1>
	{else}
		<h1>{$aLang.topic_photoset_edit}</h1>
	{/if}
        <form id="photoset-upload-form" method="POST" enctype="multipart/form-data">
            <p id="topic-photo-upload-input" class="topic-photo-upload-input">
                <label for="">{$aLang.topic_photoset_choose_image}:</label><br />
                <input type="file" id="photoset-upload-file" name="Filedata" />
                <a href="javascript:photosetUploadPhoto()" >upload</a>
                <input type="hidden" name="is_iframe" value="true" />
                <input type="hidden" name="topic_id" value="{$_aRequest.topic_id}" />
            </p>
        </form>
	<form action="" method="POST" enctype="multipart/form-data">
		{hook run='form_add_topic_topic_begin'}
		<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" /> 
		
		<p><label for="blog_id">{$aLang.topic_create_blog}</label>
		<select name="blog_id" id="blog_id" onChange="ajaxBlogInfo(this.value);">
			<option value="0">{$aLang.topic_create_blog_personal}</option>
			{foreach from=$aBlogsAllow item=oBlog}
				<option value="{$oBlog->getId()}" {if $_aRequest.blog_id==$oBlog->getId()}selected{/if}>{$oBlog->getTitle()}</option>
			{/foreach}     					
		</select></p>
		
		<script language="JavaScript" type="text/javascript">
			ajaxBlogInfo($('blog_id').value);
		</script>
		
		<p><label for="topic_title">{$aLang.topic_create_title}:</label><br />
		<input type="text" id="topic_title" name="topic_title" value="{$_aRequest.topic_title}" class="w100p" /><br />
		<span class="form_note">{$aLang.topic_create_title_notice}</span>
		</p>

		<p>{if !$oConfig->GetValue('view.tinymce')}<div class="note">{$aLang.topic_create_text_notice}</div>{/if}<label for="topic_text">{$aLang.topic_create_text}:</label>
		{if !$oConfig->GetValue('view.tinymce')}
			<div class="panel_form">
				{hook run='form_add_topic_panel_begin'}
				<select onchange="lsPanel.putTagAround('topic_text',this.value); this.selectedIndex=0; return false;">
					<option value="">{$aLang.panel_title}</option>
					<option value="h4">{$aLang.panel_title_h4}</option>
					<option value="h5">{$aLang.panel_title_h5}</option>
					<option value="h6">{$aLang.panel_title_h6}</option>
				</select>            			
				<select onchange="lsPanel.putList('topic_text',this); return false;">
					<option value="">{$aLang.panel_list}</option>
					<option value="ul">{$aLang.panel_list_ul}</option>
					<option value="ol">{$aLang.panel_list_ol}</option>
				</select>
				<a href="#" onclick="lsPanel.putTagAround('topic_text','b'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/bold.png" title="{$aLang.panel_b}"></a>
				<a href="#" onclick="lsPanel.putTagAround('topic_text','i'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/italic.png" title="{$aLang.panel_i}"></a>	 			
				<a href="#" onclick="lsPanel.putTagAround('topic_text','u'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/underline.png" title="{$aLang.panel_u}"></a>	 			
				<a href="#" onclick="lsPanel.putTagAround('topic_text','s'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/strikethrough.png" title="{$aLang.panel_s}"></a>	 			
				&nbsp;
				<a href="#" onclick="lsPanel.putTagUrl('topic_text','{$aLang.panel_url_promt}'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/link.png"  title="{$aLang.panel_url}"></a>
				<a href="#" onclick="lsPanel.putQuote('topic_text'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/quote.png" title="{$aLang.panel_quote}"></a>
				<a href="#" onclick="lsPanel.putTagAround('topic_text','code'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/code.png" title="{$aLang.panel_code}"></a>
				<a href="#" onclick="lsPanel.putTagAround('topic_text','video'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/video.png" title="{$aLang.panel_video}"></a>
		
				<a href="#" onclick="showImgUploadForm(); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/img.png" title="{$aLang.panel_image}"></a> 			
				<a href="#" onclick="lsPanel.putText('topic_text','<cut>'); return false;" class="button"><img src="{cfg name='path.static.skin'}/images/panel/cut.png" title="{$aLang.panel_cut}"></a>	
				{hook run='form_add_topic_panel_end'}
			</div>
		{/if}
		<textarea name="topic_text" class="mceEditor" id="topic_text" rows="20">{$_aRequest.topic_text}</textarea></p>
		
		<!-- Topic Photo Add -->
		<div class="topic-photo-upload">
			<h2>{$aLang.topic_photoset_upload_title}</h2>
			
			<div class="topic-photo-upload-rules">
                                    {$aLang.topic_photoset_upload_rules|ls_lang:"SIZE%%`$oConfig->get('module.topic.photoset.photo_max_size')`":"COUNT%%`$oConfig->get('module.topic.photoset.count_photos_max')`"}
			</div>
                            <a href="javascript:photosetShowUploadForm()">Загрузить фото</a>
			<input type="hidden" name="topic_main_photo" id="topic_main_photo" />
			<ul id="swfu_images">
                                {if count($aPhotos)}
                                    {foreach from=$aPhotos item=oPhoto}
                                        {if $_aRequest.topic_main_photo && $_aRequest.topic_main_photo == $oPhoto->getId()}
                                            {assign var=bIsMainPhoto value=true}
                                         {/if}
                                        <li id="photo_{$oPhoto->getId()}" {if $bIsMainPhoto}class="marked-as-preview"{/if}>
                                            <img src="{$oPhoto->getWebPath(100)}" alt="image" />
                                            <textarea onBlur="topicImageSetDescription({$oPhoto->getId()}, this.value)">{$oPhoto->getDescription()}</textarea><br />
                                            <a href="javascript:deleteTopicImage({$oPhoto->getId()})" class="image-delete">Удалить</a>
                                            <span class="photo-preview-state">
                                                 {if $bIsMainPhoto}
                                                    {$aLang.topic_photoset_is_preview}
                                                {else}
                                                    <a href="javascript:setTopicMainPhoto({$oPhoto->getId()})" class="mark-as-preview">{$aLang.topic_photoset_mark_as_preview}</a>
                                                {/if}
                                            </span>
                                        </li>
                                        {assign var=bIsMainPhoto value=false}
                                    {/foreach}
                                {/if}
			</ul>
                           <div id="notice_wrap"></div>
		</div>
            
                  <p>
                        <label for="topic_maim_photo_description">{$aLang.topic_photoset_main_photo_description}:</label><br />
                        <textarea name="topic_main_photo_description" id="topic_main_photo_description" rows="5">{$_aRequest.topic_main_photo_description}</textarea></p>
                  </p>
		<!-- /Topic Photo Add -->
		
            
		
		<p><label for="topic_tags">{$aLang.topic_create_tags}:</label><br />
		<input type="text" id="topic_tags" name="topic_tags" value="{$_aRequest.topic_tags}" class="w100p" /><br />
		<span class="form_note">{$aLang.topic_create_tags_notice}</span></p>
									
		<p><label for="topic_forbid_comment"><input type="checkbox" id="topic_forbid_comment" name="topic_forbid_comment" class="checkbox" value="1" {if $_aRequest.topic_forbid_comment==1}checked{/if}/> 
		&mdash; {$aLang.topic_create_forbid_comment}</label><br />
		<span class="form_note">{$aLang.topic_create_forbid_comment_notice}</span></p>

		{if $oUserCurrent->isAdministrator()}
			<p><label for="topic_publish_index"><input type="checkbox" id="topic_publish_index" name="topic_publish_index" class="checkbox" value="1" {if $_aRequest.topic_publish_index==1}checked{/if}/> 
			&mdash; {$aLang.topic_create_publish_index}</label><br />
			<span class="form_note">{$aLang.topic_create_publish_index_notice}</span></p>
		{/if}
		
		{hook run='form_add_topic_topic_end'}					
		<p class="buttons">
		<input type="submit" name="submit_topic_publish" value="{$aLang.topic_create_submit_publish}" class="right" />
		<input type="submit" name="submit_preview" value="{$aLang.topic_create_submit_preview}" onclick="$('text_preview').getParent('div').setStyle('display','block'); ajaxTextPreview('topic_text',false); return false;" />&nbsp;
		<input type="submit" name="submit_topic_save" value="{$aLang.topic_create_submit_save}" />
		</p>
	</form>
        
</div>


{include file='footer.tpl'}
