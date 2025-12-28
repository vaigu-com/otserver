import socket
import struct

def ots_status(host, port, timeout=2.0):
    # Build payload: FF FF "info"
    payload = b'\xFF\xFF' + b'info'

    # Prepend length (little-endian uint16)
    packet = struct.pack('<H', len(payload)) + payload

    with socket.create_connection((host, port), timeout=timeout) as sock:
        sock.sendall(packet)

        # Read everything until server closes connection
        data = b''
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                break
            data += chunk

    if not data:
        return None  # server offline or empty reply

    return data  # XML bytes


xml = ots_status("vaigu.com", 7171)

if xml:
    print(xml.decode(errors="ignore"))
else:
    print("Server offline")
