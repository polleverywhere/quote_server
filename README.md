# Example Live Slides application

This example application demonstrates how to build a web server that responds to the Live Slides slide color headers and the `projector` CSS media type.

## Getting started

1.  Clone this repo:

    ```
    $ git clone git@github.com:liveslides/quote_server.git && cd ./quote_server
    ```

2.  Install dependencies via bundler:

    ```
    $ bundle
    ```

3.  Run the Sinatra web server:

    ```
    $ ruby quote_server.rb
    ```

4.  Open `http://127.0.0.1:4567` on your web browser and you should see white quote text on a black background.

## Simulate a Live Slides request

To simulate a Live Slides HTTP request, run the following:

```
$ curl http://127.0.0.1:4567/projector.css \
  -H "Slide-Background-Color: #000000" \
  -H "Slide-Foreground-Color: #ffffff"
```

You should get an output like this:

```css
body {
  color: #ffffff;
  background-color: #000000;
  font-family: sans-serif;
}
```

## How it works

Live Slides makes all requests with the `Slide-Background-Color` and `Slide-Foreground-Color` requests. Your applicaiton can read these headers to change the look and feel of the content to more closely match the presenters formatting.

It's recommended that you dynamically generate stylesheets based on these headers that is applied to the content. The stylesheets should be a `projection` CSS media type.
