within Dev.Bodies.Contact;

model BaseContactingBody extends Dev.Bodies.DynamicBodyQuaternion;
	import Dev.Interfaces.ContactPort;
	import Surface = Dev.Surfaces.BaseSurface;

	replaceable Surface surface;
	redeclare replaceable ContactPort port;
	
	Real alphaStub; //needed to compile in case Contact not connected.	
equation
	if cardinality(port) < 2 then 
		port.point = alphaStub * {0, 0, -1}; //this works only when Contact not connected,
											 //and hence this makes no effect.
	else
		alphaStub = 0;
	end if;
	
	connect(port.frame, dynamics.frame_a);
	connect(port,		surface.port);		
	
end BaseContactingBody;