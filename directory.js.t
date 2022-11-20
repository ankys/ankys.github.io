---
parent: "?"
---

var directoryInfoItems = [
  {%- for path in pages() | sort %}
  {%- set page = path | value %}
  {
    "url": "{{ path | pathname }}",
    "parent": "{{ page.parent }}",
    "title": "{{ page.title }}",
    "description": "{{ page.description }}",
  },
  {%- endfor %}
];
