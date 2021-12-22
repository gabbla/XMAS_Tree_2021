###############################################################################
# Makefile for STM8L101F2P3 used on xmas deco 2021
###############################################################################
DEVICE = STM8L10x
OUT = xmas

# Compiler stuff
CC         = sdcc
CFLAGS     = -mstm8 -lstm8 --opt-code-size
OUTPUT_DIR = output

# Project
PRJ_SRC := main.c \
		   LIBS/LED/led.c \
		   LIBS/RANDOM/random.c \
		   LIBS/TIMER/timer.c

PRJ_INC := LIBS/LED/ \
		   LIBS/RANDOM \
		   LIBS/TIMER \
		   UTILS/ \
		   TEST/

# HAL
HAL_SRC := HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_awu.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_beep.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_clk.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_comp.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_exti.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_flash.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_gpio.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_i2c.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_irtim.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_itc.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_iwdg.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_rst.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_spi.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_tim2.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_tim3.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_tim4.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_usart.c \
		   HAL/STM8L10x_StdPeriph_Driver/src/stm8l10x_wfe.c \
		   HAL/STM8L10x_StdPeriph_Driver/stm8l10x_it.c

HAL_INC := HAL/STM8L10x_StdPeriph_Driver \
		   HAL/STM8L10x_StdPeriph_Driver/inc

PRJ_OBJ = $(addprefix $(OUTPUT_DIR)/, $(PRJ_SRC:.c=.rel))
HAL_OBJ = $(addprefix $(OUTPUT_DIR)/, $(HAL_SRC:.c=.rel))
OBJECTS = $(PRJ_OBJ) $(HAL_OBJ)
INCLUDE = $(addprefix -I, $(PRJ_INC) $(HAL_INC))

all: $(OUTPUT_DIR) $(OUT)

$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

$(OUT): $(OBJECTS)
	@printf "\e[33mLinking\e[0m %s\n" $@
	@$(CC) $(CFLAGS) -o $(OUTPUT_DIR)/$@.hex $^
	@printf "\e[34mDone!\e[0m\n"

$(OUTPUT_DIR)/%.rel: %.c
	@mkdir -p $(dir $@)
	@printf "\e[32mCompiling\e[0m %s\n" $@
	@$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

.PHONY: clean
clean:
	@rm -rf $(OUTPUT_DIR)
	@printf "\e[34mAll clear!\e[0m\n"

