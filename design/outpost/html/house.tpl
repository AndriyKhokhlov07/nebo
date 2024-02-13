{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_form="1" scope=parent}

<div class="{if $page->bg_image == ''}page_wrap{/if} house">
    <div class="main_width">
        <div class="fx ch2">
            <div class="txt">
                {$page->body}
            </div>
            <div class="form">
                 <div class="form_acnhor" id="apply"></div>
                <script src="//js.hsforms.net/forms/v2.js"></script>
                <script>
                  hbspt.forms.create({
                    portalId: "4068949",
                    formId: "f7fcf175-50eb-4637-b9f8-996aacd3bd71"
                });
                </script>
            </div>
        </div>
    </div>
    <div class="main_width txt room_blocks">
        {foreach $page->blocks as $pb}
        {if $pb->images != ""}
        <div class="room_block fx {if $pb->type == 1}ch2{else}w rv vc{/if}">
            {if $pb->images|count > 1}
            <div {if $pb->type != 1}class="w100"{/if}>
                <div class="img_slider">
                    {foreach $pb->images as $img}
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="../{$config->galleries_images_dir}{$img}" alt="{$pb->title}" />   
                        </div>  
                    </div>
                    {/foreach}
                </div>                
            </div>
            {else}
            {foreach $pb->images as $img}
            <div class="img">
                <img src="../{$config->galleries_images_dir}{$img}" alt="{$pb->title}" />                                   
            </div>
            {/foreach}
            {/if}
            <div>
                <p class="h5">{$pb->title}</p>
                <div class="info">{$pb->body}</div>
            </div>
        </div>
        {else}
        <div class="room_block">
            <p class="h5">{$pb->title}</p>
            <div class="info">{$pb->body}</div>
        </div>
        {/if}
        {/foreach}
    </div>
    {if $comments}
    <div class="main_width reviews_list">
        <h4 class="h3 center">Members Reviews</h4>
        <div class="reviews reviews_slider">
            {foreach $comments as $post}
            <div class="item">
                {if $post->image}
                    <div class="img">
                        <img src="{$post->image|resize:blog:380:380}" alt="{$post->name|escape}">
                    </div>
                {/if}
                <div class="preview">
                    <h4><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h4>
                    <div>{$post->text}</div>
                </div>
            </div>
            {/foreach}
        </div>

    </div>
    {/if}

    {get_posts type=1 var=posts limit=8 tag_id=27}
    {if $posts}
    <div class="main_width blog_list">
        <h4 class="h3 center">What do our members think about Outpost Club</h4>
        <div class="blog blog_slider">
            {foreach $posts as $post}
            <div class="item">
                {if $post->image}
                        <a class="img" href="blog/{$post->url}">
                            <img src="{$post->image|resize:blog:380:380}" alt="{$post->name|escape}">
                        </a>
                {/if}
                <div class="preview">
                    <h4><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h4>
                    <div>{$post->annotation}</div>
                    <a class="more" href="blog/{$post->url}">Read More →</a>
                    {*<p class="date">{$post->date|date_format:"%b %e, %Y"}</p>*}
                </div>
            </div>
            {/foreach}
        </div>
    </div>
    {/if}
</div>
