within Dev.Bodies.Contact.Trackers;

model ConvexWithPlaneForceContactTracker
	extends Dev.Bodies.Contact.Trackers.ConvexWithPlaneGeometricContactTracker;
	import Modelica.Math.Vectors.norm;

	replaceable function getTangentForce
		input Real[3] normalForce;
		input Real[3] contactRelativeVelocity;
		parameter Real koef = 0.1;
		output Real[3] force;
	algorithm
		if norm(contactRelativeVelocity) < 0.0001 then
			force := zeros(3);
		else 
			force := koef * norm(normalForce) * contactRelativeVelocity / norm(contactRelativeVelocity);
		end if;
	end getTangentForce;
	
	replaceable function getNormalForce
		input Real m;
		input Real[3] g;
		output Real[3] force;
	algorithm
		force := m * g;
	end getNormalForce;	
	
	Real[3] normalForce;
	Real[3] tangentForce;
equation
	if distance < 0.0001 then
//		normalForce = getNormalForce(1, {0, 0, -1});
		tangentForce = getTangentForce(normalForce, contactPointVelocityGlobal);
	else
//		normalForce = zeros(3);
		tangentForce = zeros(3);
	end if;
	
	//TODO: implement proper switching:
	normalForce = getNormalForce(1, {0, 0, -1});

	port.frame.f = normalForce + tangentForce;		
	port.frame.t = cross(
							port.point - port.frame.r_0,
							normalForce + tangentForce
						);
	
end ConvexWithPlaneForceContactTracker;