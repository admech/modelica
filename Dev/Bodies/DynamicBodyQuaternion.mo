within Dev.Bodies;
model DynamicBodyQuaternion
	import Modelica.Mechanics.MultiBody.Interfaces.Frame;
	import Dev.Interfaces.FramePort;

	SimpleBodyDynamicsQuaternion dynamics;
	replaceable FramePort port;
	 
equation
	connect(port.frame, dynamics.frame_a);end DynamicBodyQuaternion;