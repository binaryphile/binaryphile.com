---
title: Home
description:
---
{{# posts_latest }}
  <article class="art-post art-article">
    <h2 class="art-postheader"><a href="{{url}}">{{title}}</a> <span class="date">{{ date }}</span></h2>
    <div class="art-postcontent art-postcontent-0 clearfix">
      {{{ summary }}}
      <div class="more">
        <a href="{{url}}" class="art-button">read more..</a>
      </div>
    </div>
  </article>
{{/ posts_latest }}
