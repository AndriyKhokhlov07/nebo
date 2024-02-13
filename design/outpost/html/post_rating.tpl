{if $post->votes}
{$sum_rating = ($post->rating/$post->votes*10)|ceil / 10}
{/if}
<div class="sum_rating" data-type="post" data-id="{$post->id}">
    <i{if $sum_rating>4.8} class="s1"{elseif $sum_rating>4.1} class="s05"{/if} data-rating="5"></i>
    <i{if $sum_rating>3.8} class="s1"{elseif $sum_rating>3.1} class="s05"{/if} data-rating="4"></i>
    <i{if $sum_rating>2.8} class="s1"{elseif $sum_rating>2.1} class="s05"{/if} data-rating="3"></i>
    <i{if $sum_rating>1.8} class="s1"{elseif $sum_rating>1.1} class="s05"{/if} data-rating="2"></i>
    <i{if $sum_rating>1} class="s1"{/if} data-rating="1"></i>
</div>
{if $post->votes}
<div class="r_info">
    <div class="r_sum" itemprop="ratingValue">{$sum_rating}</div>
    <div class="r_count">оценок: <span itemprop="reviewCount">{$post->votes}</span></div>
    <meta itemprop="worstRating" content="1">
    <meta itemprop="bestRating" content="5">
</div>
{/if}
