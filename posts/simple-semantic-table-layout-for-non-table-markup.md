---
title: Simple, semantic table layout for non-table markup
date: '2013-04-03'
description: "This post describes how to use display: table and company to add table-like layout to non-table markup (such as forms) without impacting the semantics of the markup."
categories: css
tags: []
type: draft
---

If you're familiar with HTML tables, by this point you know that they're
frowned upon for doing anything other layout of actual tabular data.
Back in the day they were valued for the control they gave over layout,
but have since been stigmatized for the amount of presentation-related
information they impart to markup elements rather than stylesheets,
where presentation information belongs.

I have to say, I'm no CSS expert by any means, so I can't give you a
strict explanation that gives you much more insight than that, but
having read a lot of articles on the subject, I can tell you that there
aren't a lot of others who can tell you much more about why it's wrong.
I just trust that when I see a lot of tr and td tags with multi-level
structural dependencies and lots of angle brackets, there's something
wrong.  There has to be a better way.

Recently I was given an assignment to deal with a mongo-sized,
multi-page form.  In the process of my first pass at it, I realized that
I needed a few things from a layout:

- table basis
- ability to span cells for long labels (for that checkbox on its own
  row with a long explanatory label)
- ability to pack smaller fields into a cell or extend outside a cell
- accomodate fieldsets (think like state and zip fields that don't need
  full columns)
- do these things without losing the flow of the rest of the table, so
  cells at the bottom still affect the width of their column as a whole

### Table Basis

Some sites advocate the "label above the field", single-column layout.
I can understand the simplicity of this approach and how it doesn't
require a lot of the user's eye, which is good.  It's not the most
economical use of page space, however, and when you've got more fields
than you can shake a stick at, it's a lot of scrolling.  Personally, I
like a tabular layout when you've got a dense form, with the labels to
the left of the fields and with multiple columns.

When it comes to multiple columns, it seems that for a while, floats
were the preferred method.  More recently, display: inline-block with an
assigned width or min-width is what I've seen recommended as "modern".
Both methods have drawbacks that I won't try to explain, I'll just say
that I've found them non-intuitive.  I just want a good, old-fashioned
table whose workings are pretty easy to understand for just about
anyone.  For those interested, there is a good [article on the various
layout alternatives].

We're going to use the seemingly under-appreciated `display: table-*`
property values.  These properties impart the behavior of table elements
to markup entirely through css, and make the browser anonymously create
any missing structure of the table (e.g. wrapping table-cells in a
table-row).  Here is [a good article on `display: table`].

If you aren't familiar with using the __display: table*__ property
values, let's take a moment to understand what's going on with the
tabular layout (with css).

Whenever the rendering engine sees table-related display property values
that are on their own, say a table-row without an enclosing table, it
creates the minimum set of required table elements surrounding and/or
inside the element to complete a table.  The [rules for table generation
are available from the W3C].

So if you have an element that has the __table-row__ property value, an
anonymous __table__ element is created as a parent (you can't see this
in the DOM afaik).  Then, the elements below are enclosed in anonymous
cells, being glommed together until a non-cell compatible element is
found (usually one with the __table-row__ property value.

Likewise, the simplest method sometimes is to designate some sibling
elements as __display: table-cell__, just on their own with no other
table-related elements.  These cells will join together as neighbor
cells inside an anonymous row inside an anonymous table.  Pretty cool.
In fact, the only difficulty with that is that when you want to wrap to
a new row, you need to introduce a non-cell element surrounding or
between the rows (such as a blank __div__ or something with the
__table-row__ property value).  This means you can create tables with
leaner markup than a true __table__.

Let's start with this:

~~~
.tel-tabular > * {
  display: table-row;
}

.tel-tabular > * > * {
  display: table-cell;
}
~~~

Now, before you jump on me for using universal selectors (the \*'s),
bear these two things in mind:

- you can adapt this css to just as easily use selectors for particular
  elements or classes as you see fit and it will work just as well.  I
  use the \*'s for convenience, flexibility of markup that will match
  the selectors, and to show you that it's possible to do by just
  specifying the _structure_ of the markup without specifying the _type_
  of your markup.
- the performance penalty for using such a selector is more than
  compensated for by the fact that it's accompanied by the direct-child
  limitation (the >'s).  It may costly to search an entire dom subtree
  for a universal selector but it's rarely costly to search just the
  children of an element.

So what's this tell us?  There are two rules here, and the first one
says to make table rows out of the children of the element with the
class __tel-tabular__.  The classname __tel-tabular__ is just a
description of what we're trying to achieve, prefixed with my initials
so that it is namespaced to some degree and shouldn't conflict with your
existing classnames.

The second rule says to make all children of those rows into cells.  So
whatever kind of markup elements you have at two layers below the one
assigned the __tel-tabular__ class will be placed in separate columns
(even if the elements at that level aren't all the same kind).

So what this does is to make tabular any dual-level markup _under_ the
element which you give the __tel-tabular__ class.  The first level
elements underneath define the rows and the next level under that define
the content in the columns.  Any tag works at any of these levels, they
are all acceptable.

This is pretty flexible (without being unperformant).  It works with
some common organization methods that are already row-based:

~~~
<ul class="tel-tabular">
  <li>
    <label>First row, cell 1.</label>
    <input>
    <label>First row, cell 3.</label>
    <input>
  </li>
  <li>
    <label>Second row, cell 1.</label>
    <input>
    <label>Second row, cell 3.</label>
    <input>
  </li>
</ul>
~~~

This is a little bit unlike regular list markup in that there is no
content directly in the list items, there are only elements that turn
into cells.  Most of the time I'm using this for form layout, so it
works fine in that case as you can see.  If necessary for other kinds of
content you can simply add any kind of element to delineate your cells,
so if you have some paragraphs or cell content in an __li__, you can
just add a __span__ or __p__ tag around the content.  This is still less
markup than a regular __table__.

You can also use plain old __div's__ and/or __span's__:

~~~
<div class="tel-tabular">
  <div>
    <span>First row, cell 1.</span>
    <span>First row, cell 2.</span>
  </div>
  <div>
    <span>Second row, cell 1.</span>
    <span>Second row, cell 2.</span>
  </div>
</div>
~~~

There are varying opinions, but some people like the list (__ol__ or
__ul__).  When you use a list as your basic markup, you have the
advantage that when you don't have css, it still renders in a row
format.  You also have good accessibility, as most screen readers have a
little extra functionality around lists, such as telling you how many
elements are in the list.

So let's take a look at a real example:

~~~
<form class="tel-tabular">
  <div>
    <label>Label1 filler</label>
    <input>
    <label>Label2</label>
    <input>
  </div>
  <div>
    <label>Label3</label>
    <input>
    <label>Label4 filler</label>
    <input>
  </div>
</form>
~~~

I've chosen to use __div's__ rather than a list in this example so we
can focus on the rendering and not the semantics of the underlying
markup, but it works fine with the list markup as well, and __div__ is
semantic enough by itself.

The form renders as this:

![basic form]

Notice that the column widths are determined by the longest labels.
When I don't have css, it renders as this:

![basic form no css]

So you can see it's pretty close to the tabular layout, we just lose the
column alignment.  So, pretty good, and _we've been able to use semantic
markup that is meaningful on its own_.  The only thing we need to add to
get the presentation we want is css and that's the whole point.

So far, so good.  The layout looks good to the eye and we get the column
width behavior we want as long as we conform to the markup structure.

### Long Labels and Spanning

However, what happens if we want to add an element that's really long
and blows the layout for the rest of the cells?

![form with long element]

The simplest solution is to leave the cell alone and instead let the
content overflow out of the cell.  As long as there's no additional
fields, that works fine.  All you need to do is wrap the element in
another one, like so:

~~~
<div>
  <span><label>LOOOOOOONNNNNNNNGGGGG</label><span>
</div>
~~~

This makes the span get the __display: table-cell__ attribute from our
css that was going on the label before.  Then the label gets its normal
display type, which is __inline__.

That's not quite good enough, however, because the cell still adjusts to
the width of its content, so we've just pushed the problem down another
level.  There _is_ something we can do about that, though.  Since the
label is no longer a table-cell, we can assign a width of 0 to it.  The
cell around it will see it as no width and will shrink to match the rest
of the column.

Since you can't assign a width to an inline element, you also have to
change the display type of the span contents to __inline-block__.

~~~
.tel-tabular > * > * > * {
  display: inline-block;
  width: 0;
}
~~~

With this, the form becomes:

![form with long label fixed]

So far, so good.  However, it's no use if it's just a label on its own,
so let's make it a checkbox with a label after:

~~~
<div>
  <span>
    <input type="checkbox">
    <label>This is a long label</label>
  </span>
</div>
~~~

![form with wrapping]

Unfortunately, there's a problem.  The zero-width span is forcing the
content to wrap, so we have to add this to the css:

~~~
tel-tabular > * > * > * {
  display: inline-block;
  width: 0;
  white-space: nowrap;
}
~~~

Which gives:

![form with missing checkbox]

Better.  But where's the checkbox?  Remember at this point that we have
a form with the __tel-tabular__ class with children including a __div__
and a __span__ before we hit the __input__ (and sibling __label__).  The
__div__ is the row and the __span__ is the cell but inside the cell we
have multiple elements that are each getting __display: inline-block__
as well as width 0.  So they're just piling up on top of one another.

We need to break the assignment of inline-block and width 0 on these
elements.  We could create a class to do so and assign it to each
element, but it's easier to fix this particular issue with markup.
Introducing another __span__ around the elements fixes the issue:

~~~
<div>
  <span>
    <span>
      <input type="checkbox">
      <label>This is a long label</label>
    </span>
  </span>
</div>
~~~

![form with checkbox]

While css is usually preferable to change presentation style, the use of
spans and divs is also commonplace and necessary in many cases to give
css a place to attach or, sometimes, to change the structure so it no
longer attaches to certain elements as I've done here.

The other reason I've chosen to use a span rather than additional css is
simplicity.  Since there may be several elements that need to be in the
line, it's simpler to introduce a single span enclosing them all rather
than add a class to each and every potential item.

So now, even when you have one of these off rows that might normally
blow the layout, you can have it and even continue your table afterward,
with the columns lining up in a nice visually appealing manner:

![form with continued table]

### Packing Small Fields in a Cell

Sometimes you've got fields that you don't want as wide as the rest.
The classic example would be the state and zip fields of an address
form.

The state and zip fields are usually narrow enough to fit within a
single field's-width.  In fact, you may even want to put other fields
afterward in the same row.

The simplest way to accommodate this is to make the first field's label
(state, in this case) a regular cell and to make the following input as
well as the label and input for zip into the following cell.  We can do
this with the html/css as it stands by putting the input/label/input
sequence into a span, where the span becomes the cell and the rest the
contents of the cell:

~~~
<div>
  <label>State</label>
  <span>
    <span>
      <input class="tel-state">
      <label>Zip</label>
      <input class="tel-zip">
    </span>
  </span>
</div>
~~~

### Accomodate Fieldsets

Fieldsets are a convenient way of grouping related information,
especially

The table values for the display property actually make this very easy:

[article on the various layout alternatives]: http://somacss.com/cols.html
[a good article on `display: table`]: http://www.digital-web.com/articles/everything_you_know_about_CSS_Is_wrong/
[rules for table generation are available from the W3C]: http://www.w3.org/TR/CSS21/tables.html#anonymous-boxes
[basic form]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/basic-form.png
[basic form no css]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/basic-form-no-css.png
[form with long element]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-long-label.png
[form with long label fixed]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-long-label-fixed.png
[form with wrapping]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-wrapping.png
[form with missing checkbox]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-missing-checkbox.png
[form with checkbox]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-checkbox.png
[form with continued table]: {{urls.media}}/simple-semantic-table-layout-for-non-table-markup/form-with-continued-table.png

