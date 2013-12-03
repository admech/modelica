within Dev.Test.Interfaces;

// shows the proper information flow in contact model.
model ContactConnectionsTest
	import Port = Dev.Interfaces.ContactPort;
	import Frame = Modelica.Mechanics.MultiBody.Interfaces.Frame;
	import Modelica.Mechanics.MultiBody.Frames.nullRotation;

	model DynamicsStub
		Frame frame;
	equation
		//dynamics defines frame completely
		frame.r_0 = zeros(3);
		frame.R = nullRotation();
		//to complile only DynamicsStub,
		//you must delete .f & .t eqs, 0_o
		//because they are generated automatically, apparently.
		//(by OpenModelica)
		//Yet if you take a non-stub body, then it will compile with no changes!
		frame.f = zeros(3);
		frame.t = zeros(3);
	end DynamicsStub;
	
	model SurfaceStub
		Port port;
		Real[3] r;
	equation
		r = port.point;
		//surface defines the surface equation
		r[1]^2 + r[2]^2 + r[3]^2 = 1;
	end SurfaceStub;
	
	model BodyStub
		Port port;
		DynamicsStub dynamics;
		SurfaceStub surface;
	equation
		//does nothing
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
end ContactConnectionsTest;