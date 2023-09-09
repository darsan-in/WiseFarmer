import socket
from predictor import predictDisease
from sendop import sendOp

def startServer():
    # set up the server socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('192.168.29.2', 8000))
    server_socket.listen(1)

    print("Waiting for client connections...")

    while True:
        # accept a new client connection
        (client_socket, address) = server_socket.accept()
        print("Client connected:", address)

        # receive the text data
        leafname = client_socket.recv(1024).decode('utf-8')
        print("Leaf name:", leafname)

        # receive the image size
        image_size_bytes = client_socket.recv(4)
        image_size = int.from_bytes(image_size_bytes, byteorder='big')

        # receive the image data
        image_data = b''
        while len(image_data) < image_size:
            chunk = client_socket.recv(image_size - len(image_data))
            if not chunk:
                break
            image_data += chunk

        file = f'uploads/received_image_{address[0]}_{address[1]}.jpg'
        # save the image to a file
        with open(file, 'wb') as f:
            f.write(image_data)

        print(f"Image saved")

        res = predictDisease(leafname,file)
        diseasename = res[0]
        treatment = res[1]
        print(diseasename,treatment)
        mobileip = address[0]
        mobileport = 8000
        sendOp(mobileip,mobileport,diseasename,treatment)
        # close the client socket
        client_socket.close()
        
startServer()