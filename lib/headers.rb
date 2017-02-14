class Headers

  def response_200
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{html_wrapper.length}\r\n\r\n"]
  end

  def response_302
    ["http/1.1 302 Moved Permanently",
      "Location: http://127.0.0.1:2000/game",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{html_wrapper.length}\r\n\r\n"]
  end

end

# A 3xx status code – in our case 302 will be the standard status code for redirecting
# A special header called Location – the Location header indicates the new URL the browser should visit. For example the header Location: http://google.com would tell a web browser to navigate to google’s homepage.
