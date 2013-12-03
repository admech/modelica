within Dev.Bodies;
model DynamicBody
	import Modelica.Mechanics.MultiBody.Interfaces.Frame;
	import Dev.Interfaces.FramePort;

	SimpleBodyDynamics dynamics;
	replaceable FramePort port;
	 
equation
	connect(port.frame, dynamics.frame_a);
end DynamicBody;