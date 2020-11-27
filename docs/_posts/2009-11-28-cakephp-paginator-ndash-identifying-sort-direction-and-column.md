---
title: CakePHP paginator – Identifying sort direction and column
date: 2009-11-28 22:39:00.000000000 -08:00
categories:
- php
- programming
permalink: "/2009/11/28/cakephp-paginator-ndash-identifying-sort-direction-and-column/"
---

I love CakePHP’s paginator. Its fairly easy to use and packs a punch of
features. The one missing feature, though, is that there is no automagic
mechanism to tell the user what column is being sorted on and in what
direction. But its easy enough to do. I came up with this paginator
header element that will output markup for the table header and shows
what column is sorted.

Here’s the code for the element:

~~~php
<?php
// required 1 input: \$fields = fields of the model and corresponding text to display as column header
$paginator->options(array('url' => $this->params['pass'\]));
foreach(\$fields as $title => $field)
{
?>
<?php echo $paginator->sort($title, $field, array('class' => ($field == \$paginator->sortKey()) ? $paginator->sortDir() : '')); ?>
<?php } ?>
~~~

Basically, it just outputs table header tags containing the sorting link
for the paginator to sort on that column. Adding the class attribute
allows us to show two separate images based on the sort direction.
Non-sortable columns can be added directly into the html. To use it, you
have to create an array that contains the title for each column as key
and the corresponding field in your model as the value. For example, if
you had a Person model, you would call the element like this:

~~~php
<?php
$fields = array('ID' => 'Person.id',
              'Name' => 'Person.Name',
              'Username' => 'Person.Username',
              'Title' => 'Person.Title');
echo $this->element('paginator_header', array('fields' => $fields));
?>
~~~

How it works:

It finds the the name of the column that is currently being sorted and
the sort direction from the paginator. Then it applies an “asc” or
“desc” css class to the markup of that column. So, you also need to
define the css for these “asc” and “desc” css classes. What you would
normally want is to put an up or down arrow images next to the column
header.

Here’s two sample classes I used in my application:

~~~css
a.asc {
padding-right: 20px;
background: url('../img/arrow_up.png') no-repeat top right;
}

a.desc {
padding-right: 20px;
background: url('../img/arrow_down.png') no-repeat top right;
}
~~~
