within Dev.Bodies.Contact.Trackers;

model ConvexWithPlaneGeometricContactTracker extends BaseContactTracker;
	Real alpha;
	parameter Real[3] direction = {0, 0, -1};
	
	//Absolute velocity in world frame
	Real[3] contactPointVelocityGlobal;
	
	//Absolute coords in world frame
	Real[3] contactPointGlobal;
	Real distance(min = 0);	

	Real[3] potentialContactPoint;
	function getProperDirection
		input Real x;
		input Real[3] v;
		output Real[3] w;
	algorithm
		if x < 0 then
			w := -v;
		else
			w := v;
		end if;
	end getProperDirection;

equation	
	potentialContactPoint = alpha * direction;
	port.point = getProperDirection(alpha, potentialContactPoint);
	
	contactPointGlobal = port.point + port.frame.r_0;
	distance = abs(contactPointGlobal[3]);
	
	contactPointVelocityGlobal = der(port.frame.r_0)
							     + cross(port.frame.R.w, port.point);
	
end ConvexWithPlaneGeometricContactTracker;