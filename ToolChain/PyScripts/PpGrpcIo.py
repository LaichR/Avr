import grpc
import os, os.path, sys, pathlib, re, json, subprocess, time, psutil

#link to dot net libraries
p = pathlib.Path(__file__)

batchPath = (p.parent.parent / 'Batch').resolve()

assert( os.path.exists( batchPath ))

gccRoot = p.parent.parent / 'avr8-gnu-toolchain-win32_x86'
assert( os.path.exists( gccRoot ))


class TraceInfoEncoder(json.JSONEncoder):
    def default( self, obj):
        #print("encoding")
        if( isinstance(obj, TraceInfo)):
            return obj.GetAsJsonObj()
        return json.JSONEncoder.default( self, obj )

class TraceInfo:
    def __init__(self, id, traceString, fileName, lineNr, nrOfArguments ):
        self._id = id
        self._traceString = traceString
        self._file = fileName
        self._line = lineNr
        self._nrOfArgs = nrOfArguments
    def GetAsJsonObj(self):
        return {"class": "TraceInfo",
                "MsgId": self._id,
                "TraceString": self._traceString,
                "File": self._file,
                "LineNumber": self._line,
                "NumberOfArguments": self._nrOfArgs}

def DumpTraceRecords(path, traceInfo):
    #print("dumping traceinfo:")
    #print( __traceInfo )
    traceInfoFile = pathlib.Path(path) / "TraceRecords.json"
    with open(traceInfoFile, "w") as f:
        json.dump(traceInfo,f, cls=TraceInfoEncoder)

from google.protobuf import empty_pb2 as google_dot_protobuf_dot_empty__pb2
import preprocessor_service_pb2
import preprocessor_service_pb2_grpc
import AvrService_pb2
import AvrService_pb2_grpc

def PpDefinition(name, value):
    return preprocessor_service_pb2.PpSymbolDefinition(Name=name, Value=value)

def PreprocessRequest(input, output):
    return preprocessor_service_pb2.PreprocessFileRequest(file_name=str(input), result_path=str(output))
    
def GetMacroExpansionsRequest(name):
    return preprocessor_service_pb2.GetMacroExpansionsRequest(macro_name=name)

def PpPath(path_):
    return preprocessor_service_pb2.SetPathRequest(path=str(path_))

def AssertPpServiceServerRunning(toolsRoot):  
    for proc in psutil.process_iter(['name']):
        try:
            #print(proc.info['name'])
            if proc.info['name'].lower() == "grpcppservice.exe":
                return
        except:
            pass

    print( "trying to start server")
    subprocess.Popen([os.path.join(batchPath,"LaunchServer.bat"),  toolsRoot ])
    time.sleep(0.2)

def TryCloseOpenPorts():
    try:
        with grpc.insecure_channel('localhost:5000') as channel:
            _avrDriver = AvrService_pb2_grpc.ConnectionServiceStub(channel)
            _avrDriver.ClosePort(AvrService_pb2.OpenClosePortRequest(port='*')) 
    except:
        pass


def InitPreprocessor(toolsRoot):
    global __client
    AssertPpServiceServerRunning(toolsRoot)
    channel = grpc.insecure_channel('localhost:5050')
    __client = preprocessor_service_pb2_grpc.PreprocessorStub(channel)
    __client.Reset(google_dot_protobuf_dot_empty__pb2.Empty())
    #lib\gcc\avr\5.4.0\include
    __client.SetIncludePath(PpPath((gccRoot / 'lib' / 'gcc' / 'avr' / '5.4.0' / 'include' )))
    __client.SetIncludePath(PpPath((gccRoot / 'avr' / 'include')))
    __client.SetIncludePath(PpPath(pathlib.Path(toolsRoot)/'AvrLib'/'include'))
    __client.DefinePpSymbol(PpDefinition("__INT_MAX__", "0x7FFF"))
    __client.DefinePpSymbol(PpDefinition("__GNUC__", "5"))
    __client.DefinePpSymbol(PpDefinition("__SIZE_TYPE__", "unsigned int"))
    #__client.DefinePpSymbol(PpDefinition("__AVR_DEV_LIB_NAME__", "m32"))
    __client.DefinePpSymbol(PpDefinition("__AVR_ATmega328P__","1"))
    __client.DefinePpSymbol(PpDefinition("DEBUG","1"))
    return channel


def ClearTraceRecords():
    global __traceInfo
    __traceInfo = []

def DumpTraceRecords(path):
    global __client

    assert __client , "grpc client not valid!"

    ee = __client.GetMacroExpansions(GetMacroExpansionsRequest("TRACE"))
    traceInfo = list(map(
        lambda e: TraceInfo( e.id, e.arguments[0], e.file_name, e.line_number, len(e.arguments)), ee.expansions))

    traceInfoFile = pathlib.Path(path) / "TraceRecords.json"
    with open(traceInfoFile, "w") as f:
        json.dump(traceInfo,f, cls=TraceInfoEncoder)

def PreprocessFile( input, output):
    assert __client , "grpc client not valid!"
    __client.PreprocessFile(PreprocessRequest(input, output))

if __name__ == "__main__":
    toolsRoot = sys.argv[1]
    with InitPreprocessor(toolsRoot) as channel:    
        outputPath = pathlib.Path(sys.argv[2])
        for f in sys.argv[3:]:
            input = pathlib.Path(f)
            output = outputPath / input.name
            print ( "preprocessing {0} => {1}".format( input, output))
            PreprocessFile(input,output)
