require 'socket'
require "openssl"


class ClaimRequestSenderWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'claims_send_and_process_response'
  def perform(*args)
    transmit(args)
    # Do something
  end

  def addWrapper(message,header)

    txsize = message.length + header.length + 9
    addETX = /\u0003$/.match(message) == nil
    transmission = ""
    transmission += "\u0002"
    len1 = message.length + header.length + 3 + (addETX ? 1 : 0)
    transmission += "%04d" % len1
    len2 = header.length
    transmission += "%03d" % len2
    transmission += header + message
    if addETX
      transmission += "\u0003"
    end
    transmission
  end

  def establish_connection
    # TODO replace transaction with appropriate model
    # TODO place sever name in yaml file
    eClaimServer = "dev-eclaimsrx.relayhealth.com";
    eClaimsPort = 18009;
    ctx = OpenSSL::SSL::SSLContext.new
    ctx.ssl_version = :TLSv1_2_client
    # TODO remove PUTS
    tcp_socket = TCPSocket.new(eClaimServer, eClaimsPort)
    ssl_socket = OpenSSL::SSL::SSLSocket.new(tcp_socket,ctx)
    ssl_socket.connect
    return ssl_socket
  end

  def preprocess_message(args)
    job_id = args.last[1]
    request = args[1][1]; #"007250D0B1TESTVD01  1010005123708     20161214VD0RRR    AM01CX01CY123456789C419610416C52CADANACBJOHNSONCM1801 NORMAN DRIVECNPINE LAKECOGACP30093CQ4047541821C71CZXYZ123AM04C2987654321AM07EM1D21463450E103D700006094268E730000D30D530D61D80DE20161214DF5DJ1NX1DK1DT128EAAM02EY05E93935939359AM03EZ01DB1234566119DRWRIGHTPM20136395722E01DL12345661194EWRIGHTAM11D9557{DC100{H71H801H9150{DQ807{DU807{DN03"
    string_to_write = addWrapper(request.encode('utf-8'),"146345000")
    return string_to_write
  end

  def wait_and_process_response(ssl_socket)
    receivedmessage = ""
    is_etx = false
    is_exception = false
    begin
      tstart = Time.now
      while ((lineIn = ssl_socket.getc) && (is_etx == false) && (Time.now - tstart < 10000))
        receivedmessage += lineIn
        is_etx = lineIn == "\u0003"

        if(is_etx == true)
          # TODO remove stdout
          $stdout.puts "Received - " + receivedmessage + " is etx" + is_etx.to_s
          break
        end
      end
    rescue Exception => e
      is_exception = true
      $stderr.puts "Error in input loop: " + $!
    end

    if receivedmessage == "" && is_etx == false && is_exception == false
      $stderr.puts "Connection timeout"
    end
    return receivedmessage
  end

  def transmit(args)
    ssl_socket = establish_connection
    string_to_write = preprocess_message(args)
    ssl_socket.write(string_to_write)
    receivedmessage = wait_and_process_response(ssl_socket)      
  end

end
