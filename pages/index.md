---
title: Home
description:
---
{{# posts_latest }}
  <div class="art-content-layout-br layout-item-1"></div>
  <div class="art-content-layout-br layout-item-4"></div>
  <h2 class="art-postheader"><a href="{{url}}">{{title}}</a> <span class="date">{{ date }}</span></h2>
  <div class="art-postcontent">
    {{{ summary }}}
    <div class="more">
      <a href="{{url}}" class="btn">read more..</a>
    </div>
  </div>
{{/ posts_latest }}
