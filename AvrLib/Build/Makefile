
################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL := cmd.exe
PY := Python.exe
RM := del /F

PROJECT := $(Project)
PREPROCESSING_SRCS :=
OBJS :=
OBJS_AS_ARGS :=
C_DEPS :=
C_DEPS_AS_ARGS :=
EXECUTABLES :=
OUT_FILE_PATH := $(ProjectBuild)\$(Project).a
AVR_TOOLS_PATH := $(AvrGcc)
AVR_LIB_PATH := $(ToolsRoot)\AvrLib
QUOTE := "
OUTPUT_FILE_DEP:=
LIB_DEP:=
MMCU:=atmega32

# Add inputs and outputs from these tool invocations to the build variables
C_SRCS +=  C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\AvrLib.c

ASM_SRCS += 

OBJS +=  C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.o

OBJS_AS_ARGS +=  C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.o

C_DEPS +=  C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.d

C_DEPS_AS_ARGS +=  C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.d

LIB_DEP+= $(AVR_LIB_PATH)\lib\AvrLib.a

LINKER_SCRIPT_DEP+=

# compile sources

C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.o: C:\Users\rolfl\Documents\GitHub\Avr\AvrLib\Build\AvrLib.c
	@echo Building file: $<
	@echo Invoking: AVR\GNU C Compiler : 5.4.0
	$(AVR_TOOLS_PATH)\bin\avr-gcc.exe  -x c -funsigned-char -funsigned-bitfields -DDEBUG  -I "$(AVR_LIB_PATH)\include" -I"$(AVR_TOOLS_PATH)\avr\include" -I"$(ProjectRoot)"  -O1 -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -g2 -Wall -mmcu=$(MMCU) -B "$(AVR_TOOLS_PATH)\avr\Lib" -c -std=gnu99 -save-temps -MD -MP -MF "$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)"   -o "$@" "$<"
	@echo Finished building: $<



# AVR32\GNU Preprocessing Assembler

# AVR32\GNU Assembler

#include dependencies if it's not make clean
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

# Add inputs and outputs from these tool invocations to the build variables

#flash to device; includes building


# All Target
all: $(OUT_FILE_PATH)


$(OUT_FILE_PATH): $(OBJS) $(OUTPUT_FILE_DEP)
	@echo Building target: $@
	@echo Invoking: AVR/GNU Archiver : 5.4.0
	$(AVR_TOOLS_PATH)\bin\avr-ar.exe -ro $(OUT_FILE_PATH) $(OBJS) $(LIBS)
	@echo Finished building target: $@


# Other Targets
clean:
	$(RM) $(ProjectBuild)\*.c
	$(RM) $(ProjectBuild)\*.i
	$(RM) $(ProjectBuild)\*.d
	$(RM) $(ProjectBuild)\*.o
	$(RM) $(ProjectBuild)\$(Project).*
