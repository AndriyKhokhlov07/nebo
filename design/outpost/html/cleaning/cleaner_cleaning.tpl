{* Канонический адрес страницы *}
{$canonical="/cleaner_cleaning" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}

{$js_include="design/`$settings->theme`/js/cleaning.js?v1.3" scope=parent}


<div class="page_wrap">
    <div class="guest_home w1200 cleaner_cleaning">
        <div class="fx w w100">
    
            <div class="item white">
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-bell"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">Cleanings</div>
                        {if !$cleanings}
                            <p></p>
                            <p>No updates</p>
                        {/if}
                    </div><!-- title_bx -->
                </div><!-- header_bx --> 
            </div>   
            {if $cleanings}
            {foreach $cleanings as $k=>$day}    
            <div class="item w100 {if $k == $smarty.now|date_format:'Y-m-d'}today{/if}">
                <div class="box">
                    <table class="table_s">
                        <tr>
                            <td class="date">
                                <strong>{$k}</strong>
                            </td>
                        </tr>
                        {foreach $day as $h=>$house}
                        {foreach $house as $cleaning}
                        <tr>
                            <td>
                                {if $cleaning->bed && $cleaning->order_id}
                                <div class="cleaning_desc bl">Cleaning request: {$cleaning->order_id} 
                                    {if $purchases[$cleaning->order_id]}
                                    <br>
                                    <div class="invoice_desc">
                                        {foreach $purchases[$cleaning->order_id] as $pur}
                                        {if $pur@iteration != 1}, <br>{/if}{$pur->product_name}
                                        {/foreach}
                                    </div>
                                    {/if}
                                </div>
                                {elseif $cleaning->bed == 'Common Area'}
                                <div class="cleaning_desc bl">Common area cleaning</div>
                                {elseif $cleaning->bed != '' && $cleaning->order_id == '0' && $cleaning->type != 3}
                                <div class="cleaning_desc bl">Flip</div>
                                <div class="invoice_desc">{if $cleaning->bed != '' && $cleaning->order_id == '0' && $cleaning->type != 3}{$cleaning->date_from} - {$k}{/if}</div>
                                {elseif $cleaning->type == 3}
                                <div class="cleaning_desc bl">Room cleaning</div>
                                {else}
                                <div class="cleaning_desc bl">Regular cleaning</div>
                                {/if}
                            </td>
                            <td class="address">
                                {if $cleaning->address}
                                    {$cleaning->address}
                                {else}
                                    {$houses[$h]->name}
                                {/if}
                            </td>
                            <td class="room">
                                {if $cleaning->bed && $cleaning->order_id}
                                <div class="nowrap">Room: {$cleaning->bed|escape}</div>
                                <div class="name invoice_desc">{$cleaning->name|escape} {if $cleaning->name && $cleaning->paid != 1}<span class="red">(not paid)</span>{/if}</div>
                                {elseif $cleaning->bed == 'Common Area'}
                                <div class="nowrap">Common area</div>
                                {elseif $cleaning->bed != ''}
                                <div class="nowrap">Room: {$cleaning->bed|escape}</div>
                                {else}
                                <div class="nowrap">Common area</div>
                                {/if}
                            </td>
                            <td class="name invoice_desc">Responsible: {if $cleaners[$cleaning->cleaner_id]}<br>{$cleaners[$cleaning->cleaner_id]->name}{else}all{/if}</td>
                            <!-- $k == $smarty.now|date_format:'Y-m-d' &&  -->
                            <td>{if $cleaning->status == 0}<a href="#add_note" class="md_link button green button2" data-date="{$k}" data-house_id={$h} data-cl_id="{$cleaning->id}">Complete</a>{elseif $cleaning->status == 1}<strong>Completed</strong>{/if}</td>
                        </tr>
                        {/foreach}
                        {/foreach}
                    </table>
                </div>
            </div>
            {/foreach}
            {/if}

        </div>
    </div>
</div>

<div class="hide">
    <div id="add_note" class="form2">
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" class="date" name="date" value="{$k}">
            <input type="hidden" class="house_id" name="house_id" value="{$h}"> 
            <input type="hidden" class="cl_note_id" id='cl_id' name="cl_note_id">
            <p class="h5 left">Note for cleaning</p>
            <textarea class="note" name="note" value="" placeholder="Note" required=""></textarea>
            <div id="dropZone" class="to_add_photo">
                <div id="dropMessage"><i class="fa fa-picture-o"></i> Add 2 Bedroom photos (Before/After)</div>
                <input type="file" name="dropped_images[]"  multiple class="dropInput">
            </div>
            <div class="dropZone r_images_block images">
                <ul class="r_images fx w">
                </ul><!-- r_images -->
            </div><!-- r_images_block -->
            <div id="dropZone1" class="to_add_photo">
                <div id="dropMessage"><i class="fa fa-picture-o"></i> Add 2 Bathroom photos (Before/After)</div>
                <input type="file" name="dropped_images1[]"  multiple class="dropInput">
            </div>
            <div class="dropZone1 r_images_block images">
                <ul class="r_images fx w">
                </ul><!-- r_images -->
            </div><!-- r_images_block -->
            <div id="dropZone2" class="to_add_photo">
                <div id="dropMessage"><i class="fa fa-picture-o"></i> Add 2 Kitchen photos (Before/After)</div>
                <input type="file" name="dropped_images2[]"  multiple class="dropInput">
            </div>
            <div class="dropZone2 r_images_block images">
                <ul class="r_images fx w">
                </ul><!-- r_images -->
            </div><!-- r_images_block -->
            <div id="dropZone3" class="to_add_photo">
                <div id="dropMessage"><i class="fa fa-picture-o"></i> Add 2 Additional photos (Before/After)</div>
                <input type="file" name="dropped_images3[]" multiple class="dropInput">
            </div>
            <div class="dropZone3 r_images_block images">
                <ul class="r_images fx w">
                </ul><!-- r_images -->
            </div><!-- r_images_block -->
            <button class="button2" type="submit">Complete</button>
        </form><!-- form_view -->
        <div class="info hidden"><span></span></div>
    </div>
</div>

