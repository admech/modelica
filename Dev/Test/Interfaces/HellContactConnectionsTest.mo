within Dev.Test.Interfaces;

// shows the proper information flow in contact model.
// advanced case
model HellContactConnectionsTest
	import Port = Dev.Interfaces.ContactPort;
	import Frame = Modelica.Mechanics.MultiBody.Interfaces.Frame;
	import Modelica.Mechanics.MultiBody.Frames.nullRotation;

	model DynamicsStub
		Frame frame;

		parameter Real m = 1;
		parameter Real[3] g = {0, 0, -1};	

		Real[3] r(start = zeros(3));
		Real[3] v(start = zeros(3));
		Real[3] a(start = zeros(3));	
		Real[3] phi(start = zeros(3));
	equation
        v = der(frame.r_0);
        a = der(v);

		//dynamics defines frame completely		
		frame.r_0 = r;
		frame.R = nullRotation();
		frame.f = m * (a - g);
		frame.t = phi; //OMG!!! KOSTYL for compilation (vars must be dependent)
	end DynamicsStub;
	
	model SurfaceStub
		Port port;
		Real[3] r;
	equation
		r = port.point;
		//surface defines the surface equation
		r[1]^2 + r[2]^2 + r[3]^2 = 1;

		port.frame.f = zeros(3);
		port.frame.t = zeros(3);
	end SurfaceStub;
	
	model BodyStub
		Port port;
		DynamicsStub dynamics;
		SurfaceStub surface;
	
		Real alphaStub;
	equation
		//body does nothing, but interconnect its parts
		if cardinality(port) < 2 then 
			port.point = alphaStub * {0, 0, -1}; //this works only when Contact not connected,
												//and hence this makes no effect.
		else
			alphaStub = 0;
		end if;

		connect(port.frame, dynamics.frame);
		connect(port,		surface.port);		
	end BodyStub;
	
	model ContactStub
		Port port;
		Real alpha;
	equation
		//contact tracks contact
		port.point = alpha * {0, 0, -1};
		//and defines contact force and torque
		port.frame.f = zeros(3);
		port.frame.t = zeros(3);
	end ContactStub;
	
	BodyStub body;
	ContactStub contact;
	
	Boolean testOK;
equation
	testOK = true;

	connect(body.port, contact.port);	
end HellContactConnectionsTest;