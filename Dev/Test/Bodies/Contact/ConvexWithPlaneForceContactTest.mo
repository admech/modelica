within Dev.Test.Bodies.Contact;

model ConvexWithPlaneForceContactTest
	import Body = Dev.Bodies.Contact.Impl.ContactingSphereBody;
	import Dynamics = Dev.Bodies.SimpleBodyDynamics;
	import Contact = Dev.Bodies.Contact.Trackers.ConvexWithPlaneForceContactTracker;
	import World = Dev.World;

	import Modelica.Math.Vectors.norm;

	inner World world;
	
	Body body(
				dynamics(
					r_0(start = {0, 0, 1}),
					v_0(start = {1, 0, 0})
				)
	);
	Contact contact;
	
	Real contactPointRelativeGlobal_3;
	Real distance;
	Real massCenterGlobal_3;
	Real tangentForce;
	Real normalForce;
	Real normalForce_3;
	
	Real masscenterVelocity;
	Real contactPointVelocity;
	
	Boolean testOK;
equation
	testOK = true;
	
	contactPointRelativeGlobal_3 = body.port.point[3];
	massCenterGlobal_3 = body.port.frame.r_0[3];
	distance = contact.distance;
	
	tangentForce = norm(contact.tangentForce);
	normalForce = norm(contact.normalForce);
	normalForce_3 = contact.normalForce[3];
	
	masscenterVelocity = body.dynamics.v_0[1];
	contactPointVelocity = contact.contactPointVelocityGlobal[1];

	connect(body.port, contact.port);	
end ConvexWithPlaneForceContactTest;