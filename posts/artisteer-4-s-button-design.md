---
title: Artisteer 4's button design
date: '2013-02-14'
description: A followup to my last post about using and designing Artisteer-friendly buttons
categories: artisteer
---

Earlier, I published [a post] on how Artisteer 3 does its buttons.  I
showed how you could make some minimal modifications and use mostly the
same css for your own buttons that work and look just like them.

In Artisteer 4, the button design has completely changed, rendering the
old buttons broken, but not useless.  I'll look at the new design and
what options there are for recreating or salvaging the buttons based on
the old one.

### The html

The html [used to be] a bit weighty, with three spans and a class on an
`a` tag.  The new design drops the spans, leaving just the anchor with
the class `art-button`.  This seems more elegant.

### The css

~~~
/* Reset buttons border. It's important for input and button tags. 
 * border-collapse should be separate for shadow in IE. 
 */
.art-button
{
   border-collapse: separate;
   -webkit-background-origin: border !important;
   -moz-background-origin: border !important;
   background-origin: border-box !important;
   background: #DDECF8;
   background: linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   background: -webkit-linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   background: -moz-linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   background: -o-linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   background: -ms-linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   background: linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   -svg-background: linear-gradient(top, #FFFFFF 0, #9AC6EA 100%) no-repeat;
   -webkit-border-radius:4px;
   -moz-border-radius:4px;
   border-radius:4px;
   border:1px solid #9EC8EA;
   padding:0 20px;
   margin:0 auto;
   height:29px;
}

a.art-button,
a.art-button:link,
a:link.art-button:link,
body a.art-button:link,
a.art-button:visited,
body a.art-button:visited,
input.art-button,
button.art-button
{
   text-decoration: none;
   font-size: 14px;
   font-family: Georgia, 'Times New Roman', Times, Serif;
   position:relative;
   display: inline-block;
   vertical-align: middle;
   white-space: nowrap;
   text-align: center;
   color: #133958;
   margin: 0 !important;
   overflow: visible;
   cursor: pointer;
   text-indent: 0;
   line-height: 29px;
   -webkit-box-sizing: content-box;
   -moz-box-sizing: content-box;
   box-sizing: content-box;
}

.art-button img
{
   margin: 0;
   vertical-align: middle;
}

.firefox2 .art-button
{
   display: block;
   float: left;
}

input.art-button
{
   float: none !important;
}

.art-button.active, .art-button.active:hover
{
   background: #6CACE0;
   background: linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   background: -webkit-linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   background: -moz-linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   background: -o-linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   background: -ms-linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   background: linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   -svg-background: linear-gradient(top, #96C3E9 0, #3D91D6 100%) no-repeat;
   -webkit-border-radius:4px;
   -moz-border-radius:4px;
   border-radius:4px;
   border:1px solid #3D91D6;
   padding:0 20px;
   margin:0 auto;
}
.art-button.active, .art-button.active:hover {
   color: #FFFFFF !important;
}

.art-button.hover, .art-button:hover
{
   background: #9EC8EA;
   background: linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   background: -webkit-linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   background: -moz-linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   background: -o-linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   background: -ms-linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   background: linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   -svg-background: linear-gradient(top, #CDE2F4 0, #70AEE1 100%) no-repeat;
   -webkit-border-radius:4px;
   -moz-border-radius:4px;
   border-radius:4px;
   border:1px solid #6CACE0;
   padding:0 20px;
   margin:0 auto;
}
.art-button.hover, .art-button:hover {
   color: #FFFFFF !important;
}
~~~

<span class="art-button-wrapper"><span class="art-button-l"></span><span
class="art-button-r"></span><a class="art-button-old">A button</a></span>

[a post]: /artisteer/coopting-artisteer-s-button-design-to-make-your-own-artisteer-like-buttons/
[used to be]: /artisteer/coopting-artisteer-s-button-design-to-make-your-own-artisteer-like-buttons/index.html#the-html

