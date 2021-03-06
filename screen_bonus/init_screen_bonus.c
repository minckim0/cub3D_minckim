/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init_screen_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minckim <minckim@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/07/13 23:50:15 by minckim           #+#    #+#             */
/*   Updated: 2020/08/03 20:36:02 by minckim          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "screen_bonus.h"
#include <CoreGraphics/CGDisplayConfiguration.h>
#define BASIC_COLOR 0

void		get_screen_resolution(int *mx_x, int *mx_y)
{
	CGRect	main_monitor;

	main_monitor = CGDisplayBounds(CGMainDisplayID());
	*mx_x = (int)CGRectGetWidth(main_monitor);
	*mx_y = (int)CGRectGetHeight(main_monitor);
	ft_printf(" - Max screen size: %4d %4d\n", *mx_x, *mx_y);
}

t_screen	init_screen(int rx, int ry, t_angle angle)
{
	t_screen	s;
	t_img		*img;
	int			resolution_mx_x;
	int			resolution_mx_y;

	get_screen_resolution(&resolution_mx_x, &resolution_mx_y);
	s.origin = vec_new(0, 0, 0);
	s.h = 0;
	s.v = 0;
	s.rx = rx < resolution_mx_x ? rx : resolution_mx_x;
	s.ry = ry < resolution_mx_y ? ry : resolution_mx_y;
	s.mlx = mlx_init();
	s.win = mlx_new_window(s.mlx, s.rx, s.ry, "cub3d_minckim");
	img = &(s.img);
	img->img = mlx_new_image(s.mlx, s.rx, s.ry);
	img->addr = mlx_get_data_addr(img->img, &(img->bits_per_pixel), \
		&(img->line_length), &(img->endian));
	s.tan_camera_angle_2 = tan(angle / 2) * 2;
	s.distance = s.rx / s.tan_camera_angle_2;
	s.cos_cam = cos(angle / 2);
	s.pixel = pixel_init(&s);
	s.odd = 0;
	s.gi = vec_new(1 / 1.8, 1 / 1.8, -1 / 1.8);
	return (s);
}

t_pixel		**pixel_init(t_screen *s)
{
	t_pixel	**pixel;
	int		i;
	int		j;
	t_pixel	*tmp;

	pixel = (t_pixel**)malloc(sizeof(t_pixel*) * s->rx);
	i = -1;
	while (++i < s->rx)
	{
		j = -1;
		pixel[i] = (t_pixel*)malloc(sizeof(t_pixel) * s->ry);
		while (++j < s->ry)
		{
			tmp = &(pixel[i][j]);
			tmp->distance = BIG_REAL;
			tmp->ray = vec_new(s->distance, s->rx / 2 - i, s->ry / 2 - j);
			vec_unit(&tmp->ray);
			tmp->color = s->img.addr + \
				(j * s->img.line_length + i * (s->img.bits_per_pixel / 8));
		}
	}
	return (pixel);
}

void		mlx_pixel(t_img *img, int x, int y, int color)
{
	char	*dst;

	dst = img->addr + (y * img->line_length + x * (img->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

void		refresh_screen(t_screen *s)
{
	int		i;
	int		j;
	t_pixel	**p;

	p = s->pixel;
	i = -1;
	while (++i < s->rx)
	{
		j = -1;
		while (++j < s->ry)
		{
			(p[i][j]).distance = BIG_REAL;
		}
	}
}
