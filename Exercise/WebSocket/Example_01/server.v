import net.websocket as socket
import net

addr := net.AddrFamily.ip
opt := socket.ServerOpt{}

mut server := socket.new_server(addr, 3000, '/hi', opt)

server.on_connect(fn (mut _ socket.ServerClient) !bool {
	println('client connection')
	return true
})!

server.on_message(fn (mut _ socket.Client, msg &socket.Message) ! {
	payload := msg.payload
	if payload.len > 0 {
		println(payload.bytestr())
	}
})

server.listen()!
