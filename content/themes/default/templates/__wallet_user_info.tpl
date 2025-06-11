<div class="user-info">
    <img class="avatar" src="{literal}{{user_picture}}{/literal}" alt="">
    <div class="user-name-bar">
      <p class="fullname">
        {literal}{{user_fullname}}{/literal}
      </p>
      {literal}{{#user_verified}}{/literal}
        <span class="verified-badge" data-bs-toggle="tooltip" title="{__("Verified User")}">
          {include file='__svg_icons.tpl' icon="verified_badge" width="32px" height="32px"}
        </span>
      {literal}{{/user_verified}}{/literal}
    </div>
    <p class="name">
      @{literal}{{user_name}}{/literal}
    </p>
</div>
