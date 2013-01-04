# DocNav

Create a [DocPad](https://github.com/bevry/docpad) directory structure based off of a yaml navigation file, including specific metadata.

Install
-------
Requires [node.js](http://nodejs.org/)
```
[sudo] npm install -g docnav
```

Usage
-----
```
> docnav
```

```
Options:
  -d  /src/documents directory  [required]
  -n  Location of Nav File      [required]
```

Example nav.yml
---------------
```yaml
main:
  - ''
  - page-one:
    - child-one:
      - subchild-test-one
      - subchild-test-two
      - subchild-test-three
  - page-two:
    - child-two:
      - subchild-test
  - page-three
  - page-four
```

Metadata
--------
By default, DocNav creates an index.html file in each of the directories. It also includes basic metadata for DocPad in each file.

```
---
layout: 'default'
title: 'Page One'
nav_title: 'Page One'
---
