import grpc
import psutil,os, os.path, time
import subprocess


serverPath = r"C:\Users\rolfl\Documents\GitHub\Builder\GrpcPpService\bin\Release\net5.0"

#
# installation of required tools:
# pip install:
# - protobuf
# - grpcio
# - grpcio-tools
#
# compile the code
# python -m grpc.tools.protoc -I==C:\Users\rolfl\Documents\GitHub\Builder\GrpcPpService\Protos --python_out=. --grpc_python_out=. preprocessor_service.proto
#
    
AssertPpServiceServierRunning()
with grpc.insecure_channel('localhost:5000') as channel:
#with grpc.insecure_channel(r'unix:C:\Users\rolfl\AppData\Local\Temp\socket.tmp') as channel:
    client = preprocessor_service_pb2_grpc.PreprocessorStub(channel)
    client.Reset(google_dot_protobuf_dot_empty__pb2.Empty())
    client.DefinePpSymbol(PpDefinition("PortC", "100"))
    client.DefinePpSymbol(PpDefinition("__INT_MAX__", "0x7FFF"))
    client.DefinePpSymbol(PpDefinition("__GNUC__", "5"))
    client.DefinePpSymbol(PpDefinition("__AVR_DEV_LIB_NAME__", "m32"))
    #client.SetMacroProviderPath(PpProviderPath(r'C:\Users\rolfl\Documents\GitHub\Builder\TraceMacro\bin\Debug\net5.0'))
    #client.SetMacroProviderPath(PpProviderPath(r'C:\temp\TraceMacros'))
    input= r"C:\Users\rolfl\Documents\GitHub\Builder\Clang.Test\Data\Stimuli\c_source\macro_expansions_19.c"
    output = r"C:\Users\rolfl\Documents\GitHub\Builder\Clang.Test\Data\Result\macro_expansions_19.pp"
    client.PreprocessFile(PreprocessRequest(input, output))
    macros = client.GetMacroNames(google_dot_protobuf_dot_empty__pb2.Empty())
   
    for m in macros.Symbols.items():
        print ( m[0], m[1] )
        
    ee = client.GetMacroExpansions(GetMacroExpansionsRequest("PadLeft"))
    for e in ee.expansions:
        print( e.id, e )

    input= r"C:\Users\rolfl\Documents\GitHub\Builder\Clang.Test\Data\Stimuli\c_source\macro_expansions_17.c"
    output = r"C:\temp\TraceMacros\macro_expansions_17.pp"
    client.PreprocessFile(PreprocessRequest(input, output))
    
    ee = client.GetMacroExpansions(GetMacroExpansionsRequest("TRACE"))
    for e in ee.expansions:
        print( e.id, e )

        