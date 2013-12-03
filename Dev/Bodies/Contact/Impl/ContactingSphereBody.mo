within Dev.Bodies.Contact.Impl;

model ContactingSphereBody extends Dev.Bodies.Contact.BaseContactingBody;
	import Dev.Surfaces.Impl.SphereSurface;

	redeclare SphereSurface surface(radius = 1);
equation

end ContactingSphereBody;