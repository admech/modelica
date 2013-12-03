within Dev.Test.Surfaces;
model SphereSurfaceTest
	import Surface = Dev.Surfaces.Impl.SphereSurface;
	
	Surface surface;
	Real[3] targetPoint;
	Real alpha;
	
	Real distance;
equation

	surface.port.frame.r_0 = zeros(3);	
	surface.port.frame.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();	
	
//	surface.port.frame.f = zeros(3);	
//	surface.port.frame.t = zeros(3);	

	surface.port.point = alpha * (targetPoint - surface.port.frame.r_0);
	targetPoint = 10 * {sin(time), cos(time), 0};
	
	distance = Modelica.Math.Vectors.norm(targetPoint - surface.port.point);
end SphereSurfaceTest;