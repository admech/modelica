within Dev.Test.Bodies.Wheel;

model JointTestPendulum
	import Dev.Bodies.Wheel.Joint;
	import Body = Dev.Bodies.DynamicBodyQuaternion;
	import Dev.World;
	import Frame_a = Modelica.Mechanics.MultiBody.Interfaces.Frame_a;
	import Frame_b = Modelica.Mechanics.MultiBody.Interfaces.Frame_b;
	import Modelica.Math.Vectors.norm;
	
	model Rod
		Frame_a frame_a;
		Frame_b frame_b;
		parameter Real length = 1;
	equation
		norm(frame_a.r_0 - frame_b.r_0) = length;
		
		frame_a.f = zeros(3);
		frame_a.t = zeros(3);
		frame_b.f = zeros(3);
		frame_b.t = zeros(3);
	end Rod;
	
	Joint joint;
	Body body;
	Rod rod;
	inner World world;
equation
	connect(body.port.frame, rod.frame_b);
	connect(rod.frame_a, joint.frame_b);
	connect(joint.frame_a, world.frame_b);
end JointTestPendulum;