import net.websocket as socket

opt := socket.ClientOpt{}

mut client := socket.new_client('ws://127.0.0.1:3000/hi', opt)!

client.connect()!

client.write_string('hi from client')!

client.close()