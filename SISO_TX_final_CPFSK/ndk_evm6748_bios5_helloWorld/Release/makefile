################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

CG_TOOL_ROOT := C:/ti/ccsv5/tools/compiler/c6000_7.4.1

ORDERED_OBJS += \
$(GEN_CMDS__FLAG) \
"./SRC/psc.obj" \
"./SRC/main.obj" \
"./SRC/intvecs.obj" \
"./SRC/interrupt.obj" \
"./SRC/helloWorld.obj" \
"./SRC/hello.obj" \
"./SRC/evminit.obj" \
"./SRC/emacHooks.obj" \
"./SRC/edma.obj" \
"./SRC/connect.obj" \
"./helloWorldcfg_c.obj" \
"./helloWorldcfg.obj" \
-l"libc.a" \

-include ../makefile.init

RM := DEL /F
RMDIR := RMDIR /S/Q

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir_vars.mk
-include SRC/subdir_vars.mk
-include subdir_rules.mk
-include SRC/subdir_rules.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(S62_DEPS)),)
-include $(S62_DEPS)
endif
ifneq ($(strip $(C64_DEPS)),)
-include $(C64_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(S55_DEPS)),)
-include $(S55_DEPS)
endif
ifneq ($(strip $(C67_DEPS)),)
-include $(C67_DEPS)
endif
ifneq ($(strip $(C??_DEPS)),)
-include $(C??_DEPS)
endif
ifneq ($(strip $(CLA_DEPS)),)
-include $(CLA_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(S??_DEPS)),)
-include $(S??_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(C62_DEPS)),)
-include $(C62_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(K_DEPS)),)
-include $(K_DEPS)
endif
ifneq ($(strip $(C43_DEPS)),)
-include $(C43_DEPS)
endif
ifneq ($(strip $(S67_DEPS)),)
-include $(S67_DEPS)
endif
ifneq ($(strip $(SA_DEPS)),)
-include $(SA_DEPS)
endif
ifneq ($(strip $(S43_DEPS)),)
-include $(S43_DEPS)
endif
ifneq ($(strip $(OPT_DEPS)),)
-include $(OPT_DEPS)
endif
ifneq ($(strip $(S64_DEPS)),)
-include $(S64_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(C55_DEPS)),)
-include $(C55_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: ndk_evm6748_bios5_helloWorld.out

# Tool invocations
ndk_evm6748_bios5_helloWorld.out: $(OBJS) $(CMD_SRCS) $(GEN_CMDS)
	@echo 'Building target: $@'
	@echo 'Invoking: C6000 Linker'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/bin/cl6x" -mv6740 -g -O2 --diag_warning=225 --abi=coffabi -z -m"ndk_evm6748_bios5_helloWorld.map" --warn_sections -i"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/lib" -i"C:/ti/ccsv5/tools/compiler/c6000_7.4.1/include" -i"C:/ti/bios_5_42_00_07/packages/ti/rtdx/lib/c6000" -i"C:/ti/bios_5_42_00_07/packages/ti/bios/lib" --reread_libs --rom_model -o "ndk_evm6748_bios5_helloWorld.out" $(ORDERED_OBJS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(GEN_SRCS__QUOTED)$(GEN_MISC_FILES__QUOTED)$(C6000_EXECUTABLE_OUTPUTS__QUOTED)$(GEN_CMDS__QUOTED) "ndk_evm6748_bios5_helloWorld.out"
	-$(RM) "helloWorldcfg_c.pp" "SRC\connect.pp" "SRC\edma.pp" "SRC\emacHooks.pp" "SRC\evminit.pp" "SRC\hello.pp" "SRC\helloWorld.pp" "SRC\interrupt.pp" "SRC\main.pp" "SRC\psc.pp" 
	-$(RM) "helloWorldcfg.pp" 
	-$(RM) "helloWorldcfg.obj" "helloWorldcfg_c.obj" "SRC\connect.obj" "SRC\edma.obj" "SRC\emacHooks.obj" "SRC\evminit.obj" "SRC\hello.obj" "SRC\helloWorld.obj" "SRC\interrupt.obj" "SRC\intvecs.obj" "SRC\main.obj" "SRC\psc.obj" 
	-$(RM) "SRC\intvecs.pp" 
	-@echo 'Finished clean'
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
