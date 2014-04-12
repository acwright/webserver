require 'socket'

server = TCPServer.new '127.0.0.1', 3000

while session = server.accept
  session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
  if request = session.gets
    filename = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
    filename = "index.html" if filename == ""
    displayfile = File.open(filename, 'r')
    content = displayfile.read()
    session.print content
  end
  session.close 
end