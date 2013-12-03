within Dev.Surfaces.Impl;

model SphereSurface extends Dev.Surfaces.BaseSurface;
	parameter Real radius = 1;
equation
	r[1]^2 + r[2]^2 + r[3]^2 = radius;
end SphereSurface;