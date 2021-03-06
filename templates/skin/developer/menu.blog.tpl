<div class="nav-filter-wrapper">
	<ul class="nav nav-filter">
		<li {if $sMenuItemSelect=='index'}class="active"{/if}>
			<a href="{cfg name='path.root.web'}/">{$aLang.blog_menu_all}</a> {if $iCountTopicsNew>0}<a href="{router page='index'}new/" class="new">+{$iCountTopicsNew}</a>{/if}
		</li>

		<li {if $sMenuItemSelect=='blog'}class="active"{/if}>
			<a href="{router page='blog'}">{$aLang.blog_menu_collective}</a> {if $iCountTopicsCollectiveNew>0}<a href="{router page='blog'}new/" class="new">+{$iCountTopicsCollectiveNew}</a>{/if}
		</li>

		<li {if $sMenuItemSelect=='log'}class="active"{/if}>
			<a href="{router page='personal_blog'}">{$aLang.blog_menu_personal}</a> {if $iCountTopicsPersonalNew>0}<a href="{router page='personal_blog'}new/" class="new">+{$iCountTopicsPersonalNew}</a>{/if}
		</li>
		
		{if $oUserCurrent}
			<li {if $sMenuItemSelect=='feed'}class="active"{/if}>
				<a href="{router page='feed'}">{$aLang.userfeed_title}</a>
			</li>
		{/if}

		{hook run='menu_blog'}
	</ul>



	{if $sMenuItemSelect=='index'}
		<ul class="nav nav-filter nav-filter-sub">
			<li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{cfg name='path.root.web'}/">{$aLang.blog_menu_all_good}</a></li>
			{if $iCountTopicsNew>0}<li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{router page='index'}new/">{$aLang.blog_menu_all_new} +{$iCountTopicsNew}</a></li>{/if}
			<li {if $sMenuSubItemSelect=='discussed'}class="active"{/if}><a href="{router page='index'}discussed/">{$aLang.blog_menu_all_discussed}</a></li>
			<li {if $sMenuSubItemSelect=='top'}class="active"{/if}><a href="{router page='index'}top/">{$aLang.blog_menu_all_top}</a></li>
			{hook run='menu_blog_index_item'}
		</ul>
	{/if}

	{if $sMenuItemSelect=='blog'}
		<ul class="nav nav-filter nav-filter-sub">
			<li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{$sMenuSubBlogUrl}">{$aLang.blog_menu_collective_good}</a></li>
			{if $iCountTopicsBlogNew>0}<li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{$sMenuSubBlogUrl}new/">{$aLang.blog_menu_collective_new} +{$iCountTopicsBlogNew}</a></li>{/if}
			<li {if $sMenuSubItemSelect=='discussed'}class="active"{/if}><a href="{$sMenuSubBlogUrl}discussed/">{$aLang.blog_menu_collective_discussed}</a></li>
			<li {if $sMenuSubItemSelect=='top'}class="active"{/if}><a href="{$sMenuSubBlogUrl}top/">{$aLang.blog_menu_collective_top}</a></li>
			{hook run='menu_blog_blog_item'}
		</ul>
	{/if}

	{if $sMenuItemSelect=='log'}
		<ul class="nav nav-filter nav-filter-sub">
			<li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{router page='personal_blog'}">{$aLang.blog_menu_personal_good}</a></li>
			{if $iCountTopicsPersonalNew>0}<li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{router page='personal_blog'}new/">{$aLang.blog_menu_personal_new} +{$iCountTopicsPersonalNew}</a></li>{/if}
			<li {if $sMenuSubItemSelect=='discussed'}class="active"{/if}><a href="{router page='personal_blog'}discussed/">{$aLang.blog_menu_personal_discussed}</a></li>
			<li {if $sMenuSubItemSelect=='top'}class="active"{/if}><a href="{router page='personal_blog'}top/">{$aLang.blog_menu_personal_top}</a></li>
			{hook run='menu_blog_log_item'}
		</ul>
	{/if}

	{if $sPeriodSelectCurrent}
		<ul class="nav nav-filter nav-filter-sub">
			<li {if $sPeriodSelectCurrent=='1'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=1">{$aLang.blog_menu_top_period_24h}</a></li>
			<li {if $sPeriodSelectCurrent=='7'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=7">{$aLang.blog_menu_top_period_7d}</a></li>
			<li {if $sPeriodSelectCurrent=='30'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=30">{$aLang.blog_menu_top_period_30d}</a></li>
			<li {if $sPeriodSelectCurrent=='all'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=all">{$aLang.blog_menu_top_period_all}</a></li>
		</ul>
	{/if}
</div>