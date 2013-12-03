within Dev.Bodies;
model StandardDynamicBody
	import Modelica.Mechanics.MultiBody.Interfaces.Frame;
	import Dev.Interfaces.FramePort;

	BodyDynamics dynamics;
	replaceable FramePort port;
	 
equation
	connect(port.frame, dynamics.frame_a);
end StandardDynamicBody;