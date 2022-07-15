---
layout: page
title: Jekyll
permalink: /jekyll
---

- TOC
  {:toc}

---

# Reference Articles

- [creating-jekyll-bootstrap-template](https://www.danielsieger.com/blog/2019/01/12/creating-jekyll-bootstrap-template.html)

# Introduction

- Jekyll is a static site generator.
- You give it text written in your favorite markup language and it uses layouts to create a static website.

```
bundle exec jekyll serve --incremental
bundle exec jekyll serve --port=4000
```

# Blank Jekyll Project

```
jekyll new <jekyll-project> --blank
gem install bundler
bundle init
bundle add <gem> or Edit gemfile - add project dependency
bundle install
bundle exec jekyll serve
git add Gemfile Gemfile.lock
```

updating

```
bundle install
bundle exec jekyll serve --incremental
bundle update
```

[Basic Gemfile](https://jekyllrb.com/docs/ruby-101/#gemfile){:target="\_blank"}

```
jekyll clean
jekyll build
https://jekyllrb.com/docs/ruby-101/#gemfile
```

# Themes

_Websites_

- https://jekyllrb.com/docs/themes
- http://jekyllthemes.org/
- https://jekyllthemes.io/

| Favourite Themes                                                                         |                                                                        |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [Documentation Jekyll theme](https://jekyllthemes.io/theme/documentation)                | [View Demo](https://idratherbewriting.com/documentation-theme-jekyll/) |
| [Carte Jekyll theme](https://jekyllthemes.io/theme/carte)                                | [View Demo](http://wiredcraft.github.io/carte/)                        |
| [Creative Jekyll theme](https://jekyllthemes.io/theme/creative-theme-jekyll)             | [View Demo](https://volny.github.io/creative-theme-jekyll/)            |
| [Modern Blog Jekyll theme](https://jekyllthemes.io/theme/jekyll-modern-blog)             | [View Demo](https://inded.xyz/Jekyll_modern-blog/)                     |
| [Resumecard Jekyll theme](https://jekyllthemes.io/theme/resumecard)                      | [View Demo](https://ddbullfrog.github.io/resumecard/)                  |
| [Stylish Portfolio Jekyll theme](https://jekyllthemes.io/theme/stylish-portfolio-jekyll) | [View Demo](https://volny.github.io/stylish-portfolio-jekyll/)         |
| [Millennial Jekyll theme](https://jekyllthemes.io/theme/millennial)                      | [View Demo](https://lenpaul.github.io/Millennial/)                     |
