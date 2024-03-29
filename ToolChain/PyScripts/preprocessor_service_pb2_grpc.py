# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

from google.protobuf import empty_pb2 as google_dot_protobuf_dot_empty__pb2
import preprocessor_service_pb2 as preprocessor__service__pb2


class PreprocessorStub(object):
    """The preprocessor service definition
    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.Reset = channel.unary_unary(
                '/preprocessor_service.Preprocessor/Reset',
                request_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
                response_deserializer=preprocessor__service__pb2.ResetResponse.FromString,
                )
        self.SetIncludePath = channel.unary_unary(
                '/preprocessor_service.Preprocessor/SetIncludePath',
                request_serializer=preprocessor__service__pb2.SetPathRequest.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.SetMacroProviderPath = channel.unary_unary(
                '/preprocessor_service.Preprocessor/SetMacroProviderPath',
                request_serializer=preprocessor__service__pb2.SetPathRequest.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.DefinePpSymbol = channel.unary_unary(
                '/preprocessor_service.Preprocessor/DefinePpSymbol',
                request_serializer=preprocessor__service__pb2.PpSymbolDefinition.SerializeToString,
                response_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                )
        self.GetMacroNames = channel.unary_unary(
                '/preprocessor_service.Preprocessor/GetMacroNames',
                request_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
                response_deserializer=preprocessor__service__pb2.GetMacroNamesResponse.FromString,
                )
        self.PreprocessFile = channel.unary_unary(
                '/preprocessor_service.Preprocessor/PreprocessFile',
                request_serializer=preprocessor__service__pb2.PreprocessFileRequest.SerializeToString,
                response_deserializer=preprocessor__service__pb2.PreprocessFileResponse.FromString,
                )
        self.GetMacroExpansions = channel.unary_unary(
                '/preprocessor_service.Preprocessor/GetMacroExpansions',
                request_serializer=preprocessor__service__pb2.GetMacroExpansionsRequest.SerializeToString,
                response_deserializer=preprocessor__service__pb2.GetMacroExpansionsResponse.FromString,
                )


class PreprocessorServicer(object):
    """The preprocessor service definition
    """

    def Reset(self, request, context):
        """reset service
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def SetIncludePath(self, request, context):
        """set include path
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def SetMacroProviderPath(self, request, context):
        """set path for MacroProdider assemblies
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def DefinePpSymbol(self, request, context):
        """set include path
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetMacroNames(self, request, context):
        """get the names of all defined macros
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def PreprocessFile(self, request, context):
        """preprocess a file
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetMacroExpansions(self, request, context):
        """get the information where a macro was used!
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_PreprocessorServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'Reset': grpc.unary_unary_rpc_method_handler(
                    servicer.Reset,
                    request_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                    response_serializer=preprocessor__service__pb2.ResetResponse.SerializeToString,
            ),
            'SetIncludePath': grpc.unary_unary_rpc_method_handler(
                    servicer.SetIncludePath,
                    request_deserializer=preprocessor__service__pb2.SetPathRequest.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'SetMacroProviderPath': grpc.unary_unary_rpc_method_handler(
                    servicer.SetMacroProviderPath,
                    request_deserializer=preprocessor__service__pb2.SetPathRequest.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'DefinePpSymbol': grpc.unary_unary_rpc_method_handler(
                    servicer.DefinePpSymbol,
                    request_deserializer=preprocessor__service__pb2.PpSymbolDefinition.FromString,
                    response_serializer=google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            ),
            'GetMacroNames': grpc.unary_unary_rpc_method_handler(
                    servicer.GetMacroNames,
                    request_deserializer=google_dot_protobuf_dot_empty__pb2.Empty.FromString,
                    response_serializer=preprocessor__service__pb2.GetMacroNamesResponse.SerializeToString,
            ),
            'PreprocessFile': grpc.unary_unary_rpc_method_handler(
                    servicer.PreprocessFile,
                    request_deserializer=preprocessor__service__pb2.PreprocessFileRequest.FromString,
                    response_serializer=preprocessor__service__pb2.PreprocessFileResponse.SerializeToString,
            ),
            'GetMacroExpansions': grpc.unary_unary_rpc_method_handler(
                    servicer.GetMacroExpansions,
                    request_deserializer=preprocessor__service__pb2.GetMacroExpansionsRequest.FromString,
                    response_serializer=preprocessor__service__pb2.GetMacroExpansionsResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'preprocessor_service.Preprocessor', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Preprocessor(object):
    """The preprocessor service definition
    """

    @staticmethod
    def Reset(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/Reset',
            google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            preprocessor__service__pb2.ResetResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def SetIncludePath(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/SetIncludePath',
            preprocessor__service__pb2.SetPathRequest.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def SetMacroProviderPath(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/SetMacroProviderPath',
            preprocessor__service__pb2.SetPathRequest.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def DefinePpSymbol(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/DefinePpSymbol',
            preprocessor__service__pb2.PpSymbolDefinition.SerializeToString,
            google_dot_protobuf_dot_empty__pb2.Empty.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetMacroNames(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/GetMacroNames',
            google_dot_protobuf_dot_empty__pb2.Empty.SerializeToString,
            preprocessor__service__pb2.GetMacroNamesResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def PreprocessFile(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/PreprocessFile',
            preprocessor__service__pb2.PreprocessFileRequest.SerializeToString,
            preprocessor__service__pb2.PreprocessFileResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetMacroExpansions(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/preprocessor_service.Preprocessor/GetMacroExpansions',
            preprocessor__service__pb2.GetMacroExpansionsRequest.SerializeToString,
            preprocessor__service__pb2.GetMacroExpansionsResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
