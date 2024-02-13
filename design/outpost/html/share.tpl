{* Share *}

{if !$share_img}
 {$share_img = "`$config->root_url|urlencode`/design/`$settings->theme|escape`/images/logo.png"}
{/if}

<div class="share_socials">
  <div class="title">Поделиться:</div>
  {*
	<a href="#" title="ВКонтакте" rel="me nofollow" onClick='window.open("http://vk.com/share.php?url={$share_url}&amp;image={$share_img}&amp;title={$share_title}&amp;description={$share_description}&amp;noparse=true","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
		<i class="fa fa-vk"></i>
  	</a>
    *}
 
  	<a href="#" title="Facebook" onClick='window.open("http://www.facebook.com/sharer.php?u={$share_url}","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
  		<i class="fa fa-facebook"></i>
  	</a>

  	<a href="#" title="Twitter" onClick='window.open("http://twitter.com/share?text={$share_title}&amp;url={$share_url}&amp;hashtags={$meta_keywords|replace:' ':''|urlencode}","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
  		<i class="fa fa-twitter"></i>
  	</a>

  	<a href="#" title="Google+" rel="me nofollow" onClick='window.open("https://plus.google.com/share?url={$share_url}","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
		<i class="fa fa-google-plus"></i>
  	</a>

</div>

