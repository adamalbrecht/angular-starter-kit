# Dev Server

A very basic dev server is included. By default, it runs your app on port 9000. This and all other settings can be modified in `gulpfile.coffee`.

## Live Reload

It also includes a live-reload feature that, when paired with browser extension, will reload the app in your browser whenever source files are changed. You can find the Chrome extension [here](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en).

## API Proxying

If your app needs to connect to an API that you also have running locally, you can easily do so. By default, it is configured so that requests made to `/api` will be sent to *http://localhost:3000/*.
