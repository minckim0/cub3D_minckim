# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minckim <minckim@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/06/29 16:58:52 by minckim           #+#    #+#              #
#    Updated: 2020/08/06 19:49:33 by minckim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#output
NAME = cub3D

# compile option
CC = gcc
FLAG = -Wall -Wextra -Werror -O3
# FLAG = -Wall -Wextra -Werror -O3 -g
# FLAG = -O3 -g
# FLAG = -O3

#library
LIBFT_DIR = ./libft/
LIBFT = libft.a

LIBGNL_DIR = $(LIBFT_DIR)get_next_line/
LIBGNL = libgnl.a

LIBFTPRINTF_DIR = $(LIBFT_DIR)ft_printf/
LIBFTPRINTF = libftprintf.a

OPENGL_DIR = ./mlx/
OPENGL = libmlx.a

#source files
SRCS_TEST = main_ex.c
OBJS_TEST = $(SRCS_TEST:.c=.o)

BITMAP_DIR = ./bitmap/
BITMAP_NAME = \
	bitmap.c

BITMAP_BONUS_DIR = ./bitmap_bonus/
BITMAP_BONUS_NAME = \
	bitmap_bonus.c

SCREEN_DIR = ./screen/
SCREEN_NAME = \
	init_screen.c\
	screen_entity.c\
	screen_face.c\
	screen_face_util.c\
	screen_bitmap.c\
	save_screenshot.c\
	screen_brighten.c\
	screen_exit.c

SCREEN_BONUS_DIR = ./screen_bonus/
SCREEN_BONUS_NAME = \
	init_screen_bonus.c\
	screen_entity_bonus.c\
	screen_face_bonus.c\
	screen_face_util_bonus.c\
	screen_bitmap_bonus.c\
	save_screenshot_bonus.c\
	screen_brighten_bonus.c\
	screen_exit_bonus.c

LINEAR_DIR = ./linear_algebra/
LINEAR_NAME = \
	vec0.c\
	vec1.c\
	vec2.c\
	mat0.c\
	mat1.c\
	mat2.c\
	equation.c\
	equation_line_operation0.c\
	equation_line_operation1.c\
	linear_algebra_print.c

LINEAR_BONUS_DIR = ./linear_algebra_bonus/
LINEAR_BONUS_NAME = \
	vec0_bonus.c\
	vec1_bonus.c\
	vec2_bonus.c\
	mat0_bonus.c\
	mat1_bonus.c\
	mat2_bonus.c\
	equation_bonus.c\
	equation_line_operation0_bonus.c\
	equation_line_operation1_bonus.c\
	linear_algebra_print_bonus.c

GEOMETRY_DIR = ./geometry/
GEOMETRY_NAME =\
	face0.c\
	face1.c\
	entity.c\
	geometry_print.c\
	stl_to_geometry.c

GEOMETRY_BONUS_DIR = ./geometry_bonus/
GEOMETRY_BONUS_NAME =\
	face0_bonus.c\
	face1_bonus.c\
	entity_bonus.c\
	geometry_print_bonus.c\
	stl_to_geometry_bonus.c

SRCS_DIR = ./srcs/
SRCS_NAME =\
	init.c\
	init_util.c\
	init_check_map.c\
	print_entities.c\
	main.c\
	init_entity.c\
	init_parse_line.c\
	init_create_entity.c\
	player_manage.c

SRCS_BONUS_DIR = ./srcs_bonus/
SRCS_BONUS_NAME =\
	init_bonus.c\
	init_util_bonus.c\
	init_check_map_bonus.c\
	print_entities_bonus.c\
	main_bonus.c\
	put_fps_bonus.c\
	init_entity_bonus.c\
	init_parse_line_bonus.c\
	init_create_entity_bonus.c\
	player_move_turn_bonus.c\
	check_collision_bonus.c\
	jump_bonus.c\
	crouch_bonus.c\
	mouse_motion_bonus.c\
	hud_bonus.c\
	hud_lifebar_bonus.c\
	hud_stand_crouch_bonus.c\
	item_interaction_bonus.c\
	player_dead_bonus.c\
	player_door_bonus.c\
	key_manager_bonus.c

MANDATORY = $(addprefix $(SRCS_DIR),$(SRCS_NAME))\
	$(addprefix $(SCREEN_DIR),$(SCREEN_NAME))\
	$(addprefix $(LINEAR_DIR),$(LINEAR_NAME))\
	$(addprefix $(BITMAP_DIR),$(BITMAP_NAME))\
	$(addprefix $(GEOMETRY_DIR),$(GEOMETRY_NAME))

BONUS = $(addprefix $(SRCS_BONUS_DIR),$(SRCS_BONUS_NAME))\
	$(addprefix $(SCREEN_BONUS_DIR),$(SCREEN_BONUS_NAME))\
	$(addprefix $(LINEAR_BONUS_DIR),$(LINEAR_BONUS_NAME))\
	$(addprefix $(BITMAP_BONUS_DIR),$(BITMAP_BONUS_NAME))\
	$(addprefix $(GEOMETRY_BONUS_DIR),$(GEOMETRY_BONUS_NAME))

OBJS = $(MANDATORY:.c=.o)

OBJS_BONUS = $(BONUS:.c=.o)

HEADERS = \
	$(SRCS_DIR)cub3d.h\
	$(SRCS_BONUS_DIR)cub3d_bonus.h\
	$(SCREEN_DIR)screen.h\
	$(SCREEN_BONUS_DIR)screen_bonus.h\
	$(LINEAR_DIR)linear_algebra.h\
	$(LINEAR_BONUS_DIR)linear_algebra_bonus.h\
	$(BITMAP_DIR)bitmap.h\
	$(BITMAP_BONUS_DIR)bitmap_bonus.h\
	$(GEOMETRY_DIR)geometry.h\
	$(GEOMETRY_BONUS_DIR)geometry_bonus.h\

#rules

all : $(NAME)

norm :
	norminette $(MANDATORY) $(HEADERS) $(BONUS) libft/*.c libft/*.h libft/*/*.c libft/*/*.h

$(NAME) : library $(OBJS)
	$(CC) $(FLAG) -o $(NAME) $(OBJS) \
	-lm -L. -lft -I./includes -I./usr/include -lmlx -lpthread \
	-framework OpenGL -framework AppKit

bonus : library $(OBJS_BONUS)
	$(CC) $(FLAG) -o $(NAME) $(OBJS_BONUS) \
	-lm -L. -lft -I./includes -I./usr/include -lmlx \
	-framework OpenGL -framework AppKit

%.o : %.c
	$(CC) $(FLAG) -c $*.c -o $@

lib : library

library : $(LIBFT) $(OPENGL)

$(LIBFT) :
	make -C $(LIBFT_DIR)
	mv $(LIBFT_DIR)$(LIBFT) .

clean :
	rm -rf $(SRCS_DIR)*.o
	rm -rf $(SRCS_BONUS_DIR)*.o
	rm -rf $(SCREEN_DIR)*.o
	rm -rf $(SCREEN_BONUS_DIR)*.o
	rm -rf $(LINEAR_DIR)*.o
	rm -rf $(LINEAR_BONUS_DIR)*.o
	rm -rf $(BITMAP_DIR)*.o
	rm -rf $(BITMAP_BONUS_DIR)*.o
	rm -rf $(GEOMETRY_DIR)*.o
	rm -rf $(GEOMETRY_BONUS_DIR)*.o
	make clean -C $(LIBFT_DIR)
	make clean -C $(OPENGL_DIR)

fclean : clean
	make fclean -C $(LIBFT_DIR)
	rm -rf $(NAME)
	rm -rf $(LIBFT)
	rm -rf $(OPENGL)

re : fclean $(NAME)

reb : fclean bonus

# MMS_DIR = ./minilibx_mms_20200219/
# MMS = libmlx.dylib



# mms :
# 	make -C $(MMS_DIR)
# 	mv $(MMS_DIR)$(MMS) ./$(MMS)

$(OPENGL) :
	make -C $(OPENGL_DIR)
	mv $(OPENGL_DIR)$(OPENGL) ./$(OPENGL)

# clean :
# 	rm -rf $(OBJS) $(LIBFT) $(MMS) $(OPENGL)
# 	make clean -C $(LIBFT_DIR)
# 	make clean -C $(MMS_DIR)
# 	make clean -C $(OPENGL_DIR)

# fclean :
# 	rm -rf $(OBJS) $(LIBFT) $(MMS) $(OPENGL) $(NAME)
# 	make clean -C $(LIBFT_DIR)
# 	make clean -C $(MMS_DIR)
# 	make clean -C $(OPENGL_DIR)

# re : fclean $(NAME)
