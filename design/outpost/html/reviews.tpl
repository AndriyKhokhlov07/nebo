{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}


{get_posts type=2 var=posts limit=16}
{if $posts}
<div class="w800 reviews_list page_wrap">
    <h4 class="h3 center">Members Reviews</h4>
    <div class="reviews reviews_slider">
        {foreach $posts as $post}
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
