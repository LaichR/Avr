# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import AvrService_pb2 as AvrService__pb2
from google.protobuf import empty_pb2 as google_dot_protobuf_dot_empty__pb2


class ConnectionServiceStub(object):
    """
    These are the supported message formats that may be exchanged with the AVR board

    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.QueryPorts = channel.unary_unary(
                '/AvrDriver.ConnectionService/QueryPorts',
                request_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
                response_deserializer=AvrService__pb2.QueryPortsResponse.FromString,
                )
        self.OpenPort = channel.unary_stream(
                '/AvrDriver.ConnectionService/OpenPort',
                request_serializer=AvrService__pb2.OpenClosePortRequest.SerializeToString,
                response_deserializer=AvrService__pb2.AvrMessage.FromString,
                )
        self.ClosePort = channel.unary_unary(
                '/AvrDriver.ConnectionService/ClosePort',
                request_serializer=AvrService__pb2.OpenClosePortRequest.SerializeToString,
                response_deserializer=AvrService__pb2.AvrPortStatus.FromString,
                )
        self.ReadRegister = channel.unary_unary(
                '/AvrDriver.ConnectionService/ReadRegister',
                request_serializer=AvrService__pb2.ReadRegRequest.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.WriteRegister = channel.unary_unary(
                '/AvrDriver.ConnectionService/WriteRegister',
                request_serializer=AvrService__pb2.WriteRegRequest.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.WriteData = channel.stream_unary(
                '/AvrDriver.ConnectionService/WriteData',
                request_serializer=AvrService__pb2.AvrData.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.WriteTestCommand = channel.unary_unary(
                '/AvrDriver.ConnectionService/WriteTestCommand',
                request_serializer=AvrService__pb2.AvrData.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.WriteButtonStatus = channel.unary_unary(
                '/AvrDriver.ConnectionService/WriteButtonStatus',
                request_serializer=AvrService__pb2.WriteButtonStatusRequest.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )


class ConnectionServiceServicer(object):
    """
    These are the supported message formats that may be exchanged with the AVR board

    """

    def QueryPorts(self, request, context):
        """query the available ports of the system
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def OpenPort(self, request, context):
        """open the serial port
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ClosePort(self, request, context):
        """close the serial port
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def ReadRegister(self, request, context):
        """read a hw register
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def WriteRegister(self, request, context):
        """write a hw register
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def WriteData(self, request_iterator, context):
        """write data to the device
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def WriteTestCommand(self, request, context):
        """write a test command to the device
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def WriteButtonStatus(self, request, context):
        """simulate a buttonpress or release 
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_ConnectionServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'QueryPorts': grpc.unary_unary_rpc_method_handler(
                    servicer.QueryPorts,
                    request_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                    response_serializer=AvrService__pb2.QueryPortsResponse.SerializeToString,
            ),
            'OpenPort': grpc.unary_stream_rpc_method_handler(
                    servicer.OpenPort,
                    request_deserializer=AvrService__pb2.OpenClosePortRequest.FromString,
                    response_serializer=AvrService__pb2.AvrMessage.SerializeToString,
            ),
            'ClosePort': grpc.unary_unary_rpc_method_handler(
                    servicer.ClosePort,
                    request_deserializer=AvrService__pb2.OpenClosePortRequest.FromString,
                    response_serializer=AvrService__pb2.AvrPortStatus.SerializeToString,
            ),
            'ReadRegister': grpc.unary_unary_rpc_method_handler(
                    servicer.ReadRegister,
                    request_deserializer=AvrService__pb2.ReadRegRequest.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'WriteRegister': grpc.unary_unary_rpc_method_handler(
                    servicer.WriteRegister,
                    request_deserializer=AvrService__pb2.WriteRegRequest.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'WriteData': grpc.stream_unary_rpc_method_handler(
                    servicer.WriteData,
                    request_deserializer=AvrService__pb2.AvrData.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'WriteTestCommand': grpc.unary_unary_rpc_method_handler(
                    servicer.WriteTestCommand,
                    request_deserializer=AvrService__pb2.AvrData.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'WriteButtonStatus': grpc.unary_unary_rpc_method_handler(
                    servicer.WriteButtonStatus,
                    request_deserializer=AvrService__pb2.WriteButtonStatusRequest.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'AvrDriver.ConnectionService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class ConnectionService(object):
    """
    These are the supported message formats that may be exchanged with the AVR board

    """

    @staticmethod
    def QueryPorts(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/QueryPorts',
            google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            AvrService__pb2.QueryPortsResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def OpenPort(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_stream(request, target, '/AvrDriver.ConnectionService/OpenPort',
            AvrService__pb2.OpenClosePortRequest.SerializeToString,
            AvrService__pb2.AvrMessage.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def ClosePort(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/ClosePort',
            AvrService__pb2.OpenClosePortRequest.SerializeToString,
            AvrService__pb2.AvrPortStatus.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def ReadRegister(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/ReadRegister',
            AvrService__pb2.ReadRegRequest.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def WriteRegister(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/WriteRegister',
            AvrService__pb2.WriteRegRequest.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def WriteData(request_iterator,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.stream_unary(request_iterator, target, '/AvrDriver.ConnectionService/WriteData',
            AvrService__pb2.AvrData.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def WriteTestCommand(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/WriteTestCommand',
            AvrService__pb2.AvrData.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def WriteButtonStatus(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/AvrDriver.ConnectionService/WriteButtonStatus',
            AvrService__pb2.WriteButtonStatusRequest.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
