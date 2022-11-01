#!/bin/sh
hexo clean
hexo g
echo "User-Agent: *
Allow: /
Allow: /archives/
Allow: /tags/
Sitemap: https://b.groupserver.xyz/sitemap.xml" > "public/robots.txt"
hexo d