---
parent: "?"
---
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  {%- for path in pages() | sort %}
  {%- set info = path | info %}
  {%- set page = path | value %}
  <url>
    <loc>{{ ("." + path | pathname) | url(site.url) }}</loc>
    <lastmod>{{ info.mtime.toISOString().substr(0, 10) }}</lastmod>
  </url>
  {%- endfor %}
</urlset>
