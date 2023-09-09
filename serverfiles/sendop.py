import json
import socket

def sendOp(host, port,disease,treat):
    # set up the client socket
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host,port))

    # create and send the JSON data
    json_data = {'disease': disease, 'treatment': treat}
    json_string = json.dumps(json_data).encode('utf-8')
    client_socket.sendall(json_string)

    print('JSON data sent.')

    # close the client socket
    client_socket.close()

#sendOp('192.168.29.2', 8000,'blight','test')