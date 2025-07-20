from http.server import BaseHTTPRequestHandler, HTTPServer
import time

# hostName = "localhost" 
hostName = "0.0.0.0" #It is best to use 0.0.0.0 since using 127.0.0.1/localhost will have issues with python code in container.
serverPort = 8383

## Simplest configuration with only GET and text
#
# class MyRequestHandler(BaseHTTPRequestHandler):
#
#     def do_GET(self):
#         self.send_response(200)
#         self.end_headers()
#         self.wfile.write(b'Python Web Server - Text Context-type')
#
# webServer = HTTPServer((hostName, serverPort), MyRequestHandler)
# print("Text Server started http://%s:%s" % (hostName, serverPort))
# webServer.serve_forever()


## Configuration with only GET a Simple HTML included in file
#
# class MyRequestHandler(BaseHTTPRequestHandler):
#     def do_GET(self):
#         self.send_response(200)
#         self.send_header("Content-type", "text/html")
#         self.end_headers()
#         self.wfile.write(bytes("<html>", "utf-8"))
#         self.wfile.write(bytes("<head><title> Python Web Server </title></head>", "utf-8"))
#         self.wfile.write(bytes("<body>", "utf-8"))
#         self.wfile.write(bytes("<p> Welcome to a Simple Web Server </p>", "utf-8"))
#         self.wfile.write(bytes("</body>", "utf-8"))
#         self.wfile.write(bytes("</html>", "utf-8"))
#
# if __name__ == "__main__":        
#     webServer = HTTPServer((hostName, serverPort), MyRequestHandler)
#     print("HTML Server started http://%s:%s" % (hostName, serverPort))
#
#     try:
#         webServer.serve_forever()
#     except KeyboardInterrupt:
#         pass
#
#     webServer.server_close()
#     print("Server stopped.")

## Configuration with only GET a Simple HTML included in file
#
class MyRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

        # Read the HTML content from the file
        with open('index.html', 'rb') as file:
            html_content = file.read()

        # Set the response body with the HTML content
        self.wfile.write(html_content)


if __name__ == "__main__":        
    webServer = HTTPServer((hostName, serverPort), MyRequestHandler)
    print("HTML with index.html Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")


