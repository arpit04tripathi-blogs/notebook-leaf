---
layout: page
title: Chrome
permalink: /chrome
---

- TOC
{:toc}

---

# External Links
- Project - [extn-video-speed](https://github.com/arpit04tripathi/extn-video-speed){:target="_blank"}
- [manifest](https://developer.chrome.com/extensions/manifest){:target="_blank"}
- [user_interface](https://developer.chrome.com/extensions/user_interface){:target="_blank"}
- [content_scripts](https://developer.chrome.com/extensions/content_scripts){:target="_blank"}
- [background_pages](https://developer.chrome.com/extensions/background_pages){:target="_blank"}
- [messaging](https://developer.chrome.com/extensions/messaging){:target="_blank"}

# Introduction

# Manifest


# Content Scripts

- Content scripts are files that run in the context of web pages.
- By using the standard Document Object Model (DOM), they are able to read details of the web pages the browser visits, make changes to them and pass information to their parent extension.
- Content scripts can access Chrome APIs used by their parent extension by exchanging messages with the extension.
- They can also access the URL of an extension's file with chrome.runtime.getURL() and use the result the same as other URLs.

# Background.js

- Extensions are event based programs used to modify or enhance the Chrome browsing experience.
- Events are browser triggers, such as navigating to a new page, removing a bookmark, or closing a tab.
- Extensions monitor these events in their background script, then react with specified instructions.
- A background page is loaded when it is needed, and unloaded when it goes idle.
 
Some examples of events include:
- The extension is first installed or updated to a new version.
- The background page was listening for an event, and the event is dispatched.
- A content script or other extension sends a message.
- Another view in the extension, such as a popup, calls runtime.getBackgroundPage.

